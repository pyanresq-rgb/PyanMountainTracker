-- Update tracking_locations table
ALTER TABLE tracking_locations ADD COLUMN session_id VARCHAR(20);
ALTER TABLE tracking_locations ADD COLUMN battery DECIMAL(5, 2);
ALTER TABLE tracking_locations ADD INDEX idx_session_id (session_id);

-- Create tracking_sessions table
CREATE TABLE tracking_sessions (
  id SERIAL PRIMARY KEY,
  session_id VARCHAR(20) UNIQUE NOT NULL,
  group_id INTEGER NOT NULL,
  created_by INTEGER NOT NULL,
  name VARCHAR(255),
  description TEXT,
  start_location POINT,
  end_location POINT,
  start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  end_time TIMESTAMP,
  total_distance_km DECIMAL(10, 2),
  total_time_minutes INTEGER,
  participants_count INTEGER DEFAULT 1,
  status VARCHAR(50) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE,
  FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Create session_participants table
CREATE TABLE session_participants (
  id SERIAL PRIMARY KEY,
  session_id VARCHAR(20) NOT NULL,
  user_id INTEGER NOT NULL,
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  left_at TIMESTAMP,
  distance_km DECIMAL(10, 2),
  avg_speed DECIMAL(10, 2),
  FOREIGN KEY (session_id) REFERENCES tracking_sessions(session_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE(session_id, user_id)
);

-- Create indexes
CREATE INDEX idx_sessions_group ON tracking_sessions(group_id);
CREATE INDEX idx_sessions_created_by ON tracking_sessions(created_by);
CREATE INDEX idx_sessions_status ON tracking_sessions(status);
CREATE INDEX idx_session_participants_user ON session_participants(user_id);
CREATE INDEX idx_tracking_session ON tracking_locations(session_id);
