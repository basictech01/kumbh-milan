"""
CREATE TABLE profile (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
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
);,


"""

import logging
from models.profile import Profile
from utils.error import DATABASE_ERROR, PROFILE_NOT_FOUND
from utils.mysql_client import MySQLConnection
from utils.result import Result

log = logging.getLogger("profile_service")

def get_profile(id):
    query = "SELECT * FROM profile WHERE user_id = %s"
    try:
        with MySQLConnection() as connection:
            profile = connection.read_one(query, id)
            if not profile:
                return Result(success=False, error=PROFILE_NOT_FOUND)
            profile.pop("created_at")
            profile.pop("updated_at")
            return Result(success=True, value=Profile(**profile))
    except Exception as e:
        log.error(f"Error retrieving profile: {e}")
        return Result(success=False, error=DATABASE_ERROR)
    
def update_profile(id, profile_change_map) -> Result[None]:
    query = "UPDATE profile SET "
    query += ", ".join([f"{key} = %s" for key in profile_change_map.keys()])
    query += " WHERE user_id = %s"
    
    try:
        with MySQLConnection() as connection:
            connection.write(query, *profile_change_map.values(), id)
            return Result(success=True, value=None)
    except Exception as e:
        log.error(f"Error updating profile: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def create_profile(id, profile_data) -> Result[None]:
    query = "INSERT INTO profile (user_id,"
    query += ", ".join(profile_data.keys())
    query += ") VALUES (%s, "
    query += ", ".join(["%s" for _ in profile_data.keys()])
    query += ")"
    log.error(f"Query: {query}")

    try:
        with MySQLConnection() as connection:
            connection.write(query, id, *profile_data.values())
            return Result(success=True, value=None)
    except Exception as e:
        log.error(f"Error creating profile: {e}")
        return Result(success=False, error=DATABASE_ERROR)
    