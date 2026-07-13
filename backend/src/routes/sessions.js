const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Generate Session ID (PMT000001 format)
function generateSessionId() {
  const timestamp = Date.now();
  const random = Math.floor(Math.random() * 1000);
  const sessionNumber = timestamp % 1000000;
  return `PMT${String(sessionNumber).padStart(6, '0')}`;
}

// Start tracking session
router.post('/start', async (req, res) => {
  try {
    const { group_id, created_by, name, description, latitude, longitude } = req.body;

    // Generate unique session ID
    let sessionId = generateSessionId();
    let exists = true;
    
    while (exists) {
      const check = await db.query('SELECT id FROM tracking_sessions WHERE session_id = $1', [sessionId]);
      if (check.rows.length === 0) {
        exists = false;
      } else {
        sessionId = generateSessionId();
      }
    }

    const result = await db.query(
      `INSERT INTO tracking_sessions 
       (session_id, group_id, created_by, name, description, start_location, status) 
       VALUES ($1, $2, $3, $4, $5, ST_Point($6, $7), $8) 
       RETURNING *`,
      [sessionId, group_id, created_by, name, description, latitude, longitude, 'active']
    );

    // Add creator as first participant
    await db.query(
      `INSERT INTO session_participants (session_id, user_id) VALUES ($1, $2)`,
      [sessionId, created_by]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Start session error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// End tracking session
router.put('/:sessionId/end', async (req, res) => {
  try {
    const { sessionId } = req.params;
    const { end_latitude, end_longitude } = req.body;

    // Calculate total distance and time
    const sessionData = await db.query(
      `SELECT start_time, start_location FROM tracking_sessions WHERE session_id = $1`,
      [sessionId]
    );

    if (sessionData.rows.length === 0) {
      return res.status(404).json({ error: 'Session not found' });
    }

    const startTime = sessionData.rows[0].start_time;
    const endTime = new Date();
    const totalMinutes = Math.floor((endTime - startTime) / 60000);

    // Calculate distance between start and end points
    const distanceResult = await db.query(
      `SELECT 
        ST_Distance(
          start_location::geography,
          ST_Point($1, $2)::geography
        ) / 1000 as distance_km
       FROM tracking_sessions WHERE session_id = $3`,
      [end_longitude, end_latitude, sessionId]
    );

    const totalDistance = distanceResult.rows[0].distance_km;

    const result = await db.query(
      `UPDATE tracking_sessions 
       SET status = $1, end_time = $2, end_location = ST_Point($3, $4), 
           total_distance_km = $5, total_time_minutes = $6, updated_at = CURRENT_TIMESTAMP
       WHERE session_id = $7 
       RETURNING *`,
      ['ended', endTime, end_longitude, end_latitude, totalDistance, totalMinutes, sessionId]
    );

    res.json(result.rows[0]);
  } catch (error) {
    console.error('End session error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get session details
router.get('/:sessionId', async (req, res) => {
  try {
    const { sessionId } = req.params;

    const sessionResult = await db.query(
      'SELECT * FROM tracking_sessions WHERE session_id = $1',
      [sessionId]
    );

    if (sessionResult.rows.length === 0) {
      return res.status(404).json({ error: 'Session not found' });
    }

    const participantsResult = await db.query(
      `SELECT sp.*, u.name, u.email 
       FROM session_participants sp 
       JOIN users u ON sp.user_id = u.id 
       WHERE sp.session_id = $1 
       ORDER BY sp.joined_at ASC`,
      [sessionId]
    );

    const trackingResult = await db.query(
      `SELECT * FROM tracking_locations 
       WHERE session_id = $1 
       ORDER BY timestamp ASC`,
      [sessionId]
    );

    res.json({
      session: sessionResult.rows[0],
      participants: participantsResult.rows,
      tracking_points: trackingResult.rows
    });
  } catch (error) {
    console.error('Get session error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get group active sessions
router.get('/group/:groupId/active', async (req, res) => {
  try {
    const { groupId } = req.params;

    const result = await db.query(
      `SELECT ts.*, u.name as created_by_name, COUNT(sp.id) as participants_count
       FROM tracking_sessions ts
       LEFT JOIN users u ON ts.created_by = u.id
       LEFT JOIN session_participants sp ON ts.session_id = sp.session_id
       WHERE ts.group_id = $1 AND ts.status = 'active'
       GROUP BY ts.id
       ORDER BY ts.start_time DESC`,
      [groupId]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Get active sessions error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get group session history
router.get('/group/:groupId/history', async (req, res) => {
  try {
    const { groupId } = req.params;
    const { limit = 50, offset = 0 } = req.query;

    const result = await db.query(
      `SELECT ts.*, u.name as created_by_name, COUNT(sp.id) as participants_count
       FROM tracking_sessions ts
       LEFT JOIN users u ON ts.created_by = u.id
       LEFT JOIN session_participants sp ON ts.session_id = sp.session_id
       WHERE ts.group_id = $1
       GROUP BY ts.id
       ORDER BY ts.start_time DESC
       LIMIT $2 OFFSET $3`,
      [groupId, limit, offset]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Get session history error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Join existing session
router.post('/:sessionId/join', async (req, res) => {
  try {
    const { sessionId } = req.params;
    const { user_id } = req.body;

    const result = await db.query(
      `INSERT INTO session_participants (session_id, user_id) 
       VALUES ($1, $2) 
       RETURNING *`,
      [sessionId, user_id]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    if (error.code === '23505') {
      return res.status(409).json({ error: 'User already in session' });
    }
    console.error('Join session error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Leave session
router.put('/:sessionId/leave', async (req, res) => {
  try {
    const { sessionId } = req.params;
    const { user_id } = req.body;

    const result = await db.query(
      `UPDATE session_participants 
       SET left_at = CURRENT_TIMESTAMP 
       WHERE session_id = $1 AND user_id = $2 
       RETURNING *`,
      [sessionId, user_id]
    );

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Leave session error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
