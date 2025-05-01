CREATE TABLE IF NOT EXISTS temperature_logs (
    created_at TIMESTAMP NOT NULL,
    device_id VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    temperature FLOAT NOT NULL,
    unit VARCHAR(1) NOT NULL DEFAULT 'C'
);

-- Create composite indexes
CREATE INDEX IF NOT EXISTS idx_temperature_logs_created_at_device_id 
ON temperature_logs (created_at, device_id);

CREATE INDEX IF NOT EXISTS idx_temperature_logs_created_at_location 
ON temperature_logs (created_at, location);
