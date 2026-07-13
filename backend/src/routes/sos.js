const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Send SOS alert
router.post('/alert', async (req, res) => {
  try {
    const { user_id, group_id, latitude, longitude, message } = req.body;

    const result = await db.query(
      'INSERT INTO sos_alerts (user_id, group_id, latitude, longitude, message, status) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [user_id, group_id, latitude, longitude, message, 'active']
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('SOS alert error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get active SOS alerts for group
router.get('/group/:groupId', async (req, res) => {
  try {
    const { groupId } = req.params;

    const result = await db.query(
      `SELECT sa.*, u.name as user_name 
       FROM sos_alerts sa 
       JOIN users u ON sa.user_id = u.id 
       WHERE sa.group_id = $1 AND sa.status = 'active' 
       ORDER BY sa.created_at DESC`,
      [groupId]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Get SOS alerts error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Resolve SOS alert
router.put('/:sosId/resolve', async (req, res) => {
  try {
    const { sosId } = req.params;
    const { resolved_by } = req.body;

    const result = await db.query(
      'UPDATE sos_alerts SET status = $1, resolved_at = CURRENT_TIMESTAMP, resolved_by = $2 WHERE id = $3 RETURNING *',
      ['resolved', resolved_by, sosId]
    );

    res.json(result.rows[0]);
  } catch (error) {
    console.error('Resolve SOS error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
