const express = require('express');
const router = express.Router();
const db = require('../config/database');

// Create group
router.post('/create', async (req, res) => {
  try {
    const { leader_id, name, description, location, start_date, end_date } = req.body;

    const result = await db.query(
      'INSERT INTO groups (leader_id, name, description, location, start_date, end_date) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [leader_id, name, description, location, start_date, end_date]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Create group error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Get group details
router.get('/:groupId', async (req, res) => {
  try {
    const { groupId } = req.params;

    const groupResult = await db.query('SELECT * FROM groups WHERE id = $1', [groupId]);
    if (groupResult.rows.length === 0) {
      return res.status(404).json({ error: 'Group not found' });
    }

    const membersResult = await db.query(
      'SELECT u.id, u.name, u.email, u.phone FROM group_members gm JOIN users u ON gm.user_id = u.id WHERE gm.group_id = $1',
      [groupId]
    );

    res.json({
      group: groupResult.rows[0],
      members: membersResult.rows
    });
  } catch (error) {
    console.error('Get group error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Add member to group
router.post('/:groupId/members', async (req, res) => {
  try {
    const { groupId } = req.params;
    const { user_id } = req.body;

    const result = await db.query(
      'INSERT INTO group_members (group_id, user_id) VALUES ($1, $2) RETURNING *',
      [groupId, user_id]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Add member error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
