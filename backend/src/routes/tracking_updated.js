const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Update location with session_id
router.post('/update', async (req, res) => {
  try {
    const { user_id, session_id, latitude, longitude, altitude, accuracy, speed, battery } = req.body;

    // Validate session exists and is active
    const sessionCheck = await db.query(
      'SELECT id FROM tracking_sessions WHERE session_id = $1 AND status = $2',
      [session_id, 'active']
    );

    if (sessionCheck.rows.length === 0) {
      return res.status(404).json({ error: 'Active session not found' });
    }

    const result = await db.query(
      `INSERT INTO tracking_locations 
       (user_id, session_id, latitude, longitude, altitude, accuracy, speed, battery, timestamp) 
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, CURRENT_TIMESTAMP) 
       RETURNING *`,
      [user_id, session_id, latitude, longitude, altitude, accuracy, speed, battery]
    );

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Update location error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get session tracking locations
router.get('/session/:sessionId', async (req, res) => {
  try {
    const { sessionId } = req.params;
    const { limit = 1000 } = req.query;

    const result = await db.query(
      `SELECT tl.*, u.name as user_name 
       FROM tracking_locations tl 
       JOIN users u ON tl.user_id = u.id 
       WHERE tl.session_id = $1 
       ORDER BY tl.timestamp ASC 
       LIMIT $2`,
      [sessionId, limit]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Get session tracking error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get latest location for each user in session
router.get('/session/:sessionId/latest', async (req, res) => {
  try {
    const { sessionId } = req.params;

    const result = await db.query(
      `SELECT DISTINCT ON (tl.user_id) tl.*, u.name as user_name
       FROM tracking_locations tl
       JOIN users u ON tl.user_id = u.id
       WHERE tl.session_id = $1
       ORDER BY tl.user_id, tl.timestamp DESC`,
      [sessionId]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Get latest locations error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get user trail history
router.get('/user/:userId/history', async (req, res) => {
  try {
    const { userId } = req.params;
    const { limit = 50 } = req.query;

    const result = await db.query(
      `SELECT ts.session_id, ts.name, ts.start_time, ts.end_time, ts.total_distance_km, ts.total_time_minutes
       FROM session_participants sp
       JOIN tracking_sessions ts ON sp.session_id = ts.session_id
       WHERE sp.user_id = $1
       ORDER BY ts.start_time DESC
       LIMIT $2`,
      [userId, limit]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Get user history error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
