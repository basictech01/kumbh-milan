"""
User table

CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each user
    name VARCHAR(255) NOT NULL,         -- Full name of the user
    username VARCHAR(100) NOT NULL UNIQUE, -- Username, must be unique
    password_hash VARCHAR(255) NOT NULL,     -- Encrypted password
    phone VARCHAR(20) NOT NULL,         -- Phone number
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp of user creation`
    last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Timestamp of last access
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
"""

import logging

from flask_jwt_extended import create_access_token, create_refresh_token

from models.user import User
from utils.error import DATABASE_ERROR, USER_NOT_FOUND, USER_PASSWORD_INCORRECT
from utils.extensions import bcrypt
from utils.mysql_client import MySQLConnection
from utils.result import Result

log = logging.getLogger("user_service")


def check_username_exists(username) -> Result[bool]:
    """
    Check if a user with the given username exists in the database.

    :param connection: MySQL database connection object.
    :param username: The username to check for existence.
    :return: True if the user exists, False otherwise.
    """
    query = "SELECT COUNT(*) AS user_count FROM user WHERE username = %s"
    try:
        with MySQLConnection() as connection:
            result = connection.read_one(query, username)
            if result["user_count"] > 0:
                return Result(success=True, value=True)
            return Result(success=True, value=False)
    except Exception as e:
        log.error(f"Error checking user existence: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def create_user(name, username, password, phone) -> Result[User]:
    """
    Create a new user in the database.

    :param name: Full name of the user.
    :param username: Username for the user.
    :param password: password for the user.
    :return: The ID of the newly created user.
    """
    password_hash = bcrypt.generate_password_hash(password).decode("utf-8")
    query = "INSERT INTO user (name, username, password_hash, phone) VALUES (%s, %s, %s, %s);"
    try:
        with MySQLConnection() as connection:
            lastrowid = connection.write(query, name, username, password_hash, phone)
            result = __get_user_by_id(lastrowid)
            if not result:
                return Result(success=False, error=result.error)
            user = result.unwrap()
            access_token = create_access_token(identity=user["id"])
            refresh_token = create_refresh_token(identity=user["id"])
            return Result(
                success=True,
                value=User(
                    id=user["id"],
                    name=user["name"],
                    phone=user["phone"],
                    access_token=access_token,
                    refresh_token=refresh_token,
                ),
            )
    except Exception as e:
        log.error(f"Error creating user: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def __get_user_by_id(user_id) -> Result[dict]:
    """
    Retrieve a user from the database by their ID.

    :param user_id: The ID of the user to retrieve.
    :return: A dictionary containing user details if found, None otherwise.
    """
    query = "SELECT id, name, username, phone FROM user WHERE id = %s;"
    try:
        with MySQLConnection() as connection:
            user = connection.read_one(query, user_id)
            return Result(success=True, value=user)
    except Exception as e:
        log.error(f"Error retrieving user by ID: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def get_user_from_username_and_password(username: str, password: str) -> Result[User]:
    """
    Retrieve a user from the database by their username and password.

    :param username: The username of the user.
    :param password: The password of the user.
    :return: A dictionary containing user details if found, None otherwise.
    """
    query = (
        "SELECT id, name, username, phone, password_hash FROM user WHERE username = %s;"
    )
    try:
        with MySQLConnection() as connection:
            user = connection.read_one(query, username)

            if not user:
                return Result(success=False, error=USER_NOT_FOUND)
            if not bcrypt.check_password_hash(user["password_hash"], password):
                return Result(success=False, error=USER_PASSWORD_INCORRECT)
            log.error(f"User found: {user}")
            access_token = create_access_token(identity=str(user["id"]))
            refresh_token = create_refresh_token(identity=str(user["id"]))
            return Result(
                success=True,
                value=User(
                    id=user["id"],
                    name=user["name"],
                    phone=user["phone"],
                    access_token=access_token,
                    refresh_token=refresh_token,
                ),
            )
    except Exception as e:
        log.error(f"Error retrieving user by username and password: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def update_last_accessed(user_id):
    query = "UPDATE user SET last_accessed = NOW() WHERE id = %s"
    try:
        with MySQLConnection() as connection:
            connection.write(query, user_id)
            return Result(success=True)
    except Exception as e:
        log.error(f"Error updating last accessed time: {e}")
        return Result(success=False, error=DATABASE_ERROR)
