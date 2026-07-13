const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Update location
router.post('/update', async (req, res) => {
  try {
    const { user_id, group_id, latitude, longitude, altitude, accuracy, speed } = req.body;

    const result = await db.query(
      'INSERT INTO tracking_locations (user_id, group_id, latitude, longitude, altitude, accuracy, speed, timestamp) VALUES ($1, $2, $3, $4, $5, $6, $7, CURRENT_TIMESTAMP) RETURNING *',
      [user_id, group_id, latitude, longitude, altitude, accuracy, speed]
    );

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Update location error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get group tracking locations
router.get('/group/:groupId', async (req, res) => {
  try {
    const { groupId } = req.params;

    const result = await db.query(
      `SELECT tl.*, u.name as user_name 
       FROM tracking_locations tl 
       JOIN users u ON tl.user_id = u.id 
       WHERE tl.group_id = $1 
       ORDER BY tl.timestamp DESC 
       LIMIT 100`,
      [groupId]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Get group locations error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get user trail history
router.get('/history/:userId', async (req, res) => {
  try {
    const { userId } = req.params;

    const result = await db.query(
      `SELECT * FROM trail_history 
       WHERE user_id = $1 
       ORDER BY start_time DESC 
       LIMIT 50`,
      [userId]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Get history error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
