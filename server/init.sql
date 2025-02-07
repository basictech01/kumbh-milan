CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each user
    name VARCHAR(255) NOT NULL,         -- Full name of the user
    username VARCHAR(100) NOT NULL UNIQUE, -- Username, must be unique
    password_hash VARCHAR(1024) NOT NULL,     -- Encrypted password
    phone VARCHAR(20) NOT NULL,         -- Phone number
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp of user creation
    last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Timestamp of last login
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE profile (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    age INT DEFAULT 20,
    gender VARCHAR(20),
    home_town VARCHAR(255),
    language VARCHAR(1024),
    occupation VARCHAR(1024),
    education VARCHAR(1024),
    sub_group VARCHAR(1024),
    about TEXT,
    interests TEXT,
    looking_for TEXT,
    advice_to_younger_self TEXT,
    your_meaning_of_life TEXT,
    biggest_achievement TEXT,
    biggest_challenge TEXT,
    profile_picture_url VARCHAR(1024),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE swipe (
    user_min_id INT,
    user_max_id INT,
    operation INT,
    PRIMARY KEY (user_min_id, user_max_id),
    UNIQUE KEY (user_max_id, user_min_id),
    KEY (operation)
);

