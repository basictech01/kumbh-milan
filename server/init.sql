CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each user
    name VARCHAR(255) NOT NULL,         -- Full name of the user
    username VARCHAR(100) NOT NULL UNIQUE, -- Username, must be unique
    password_hash VARCHAR(1024) NOT NULL,     -- Encrypted password
    phone VARCHAR(20) NOT NULL,         -- Phone number
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp of user creation
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

