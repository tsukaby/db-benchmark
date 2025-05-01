CREATE TABLE IF NOT EXISTS user_actions (
    performed_at TIMESTAMP NOT NULL,
    user_id UUID NOT NULL,
    action VARCHAR(255) NOT NULL
);

-- Create composite indexes
CREATE INDEX IF NOT EXISTS idx_user_actions_performed_at_user_id 
ON user_actions (performed_at, user_id);

CREATE INDEX IF NOT EXISTS idx_user_actions_performed_at_action 
ON user_actions (performed_at, action); 