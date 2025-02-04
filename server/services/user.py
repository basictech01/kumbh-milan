"""
User table

CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each user
    name VARCHAR(255) NOT NULL,         -- Full name of the user
    username VARCHAR(100) NOT NULL UNIQUE, -- Username, must be unique
    password_hash VARCHAR(255) NOT NULL,     -- Encrypted password
    phone VARCHAR(20) NOT NULL,         -- Phone number
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp of user creation
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
"""
from utils.mysql_client import MySQLClient
from utils.extensions import bcrypt
import logging

log = logging.getLogger("user_service")

def check_username_exists(username) -> bool:
    """
    Check if a user with the given username exists in the database.

    :param connection: MySQL database connection object.
    :param username: The username to check for existence.
    :return: True if the user exists, False otherwise.
    """
    query = "SELECT COUNT(*) AS user_count FROM user WHERE username = %s;"
    try:
        with MySQLClient() as client:
            cursor = client.connection.cursor()
            cursor.execute(query, (username,))
            result = cursor.fetchone()
            return result['user_count'] > 0
    except Exception as e:
        log.error(f"Error checking user existence: {e}")
        raise e


def create_user(name, username, password) -> object:
    """
    Create a new user in the database.

    :param name: Full name of the user.
    :param username: Username for the user.
    :param password: password for the user.
    :return: The ID of the newly created user.
    """
    password_hash = bcrypt.generate_password_hash(password).decode('utf-8')
    query = "INSERT INTO user (name, username, password_hash) VALUES (%s, %s, %s);"
    try:
        with MySQLClient() as client:
            cursor = client.connection.cursor()
            cursor.execute(query, (name, username, password_hash))
            client.connection.commit()
            return get_user_by_id(cursor.lastrowid)
    except Exception as e:
        log.error(f"Error creating user: {e}")
        raise e

def get_user_by_id(user_id) -> dict:
    """
    Retrieve a user from the database by their ID.

    :param user_id: The ID of the user to retrieve.
    :return: A dictionary containing user details if found, None otherwise.
    """
    query = "SELECT id, name, username, created_at FROM user WHERE id = %s;"
    try:
        with MySQLClient() as client:
            cursor = client.connection.cursor()
            cursor.execute(query, (user_id,))
            user = cursor.fetchone()
            return user
    except Exception as e:
        log.error(f"Error retrieving user by ID: {e}")
        raise e

def check_username_and_password(username: str, password: str) -> bool:
    """
    Check if the given username and password match a user in the database.

    :param username: The username to check.
    :param password: The password to check.
    :return: True if the username and password match, False otherwise.
    """
    query = "SELECT COUNT(*) AS user_count FROM user WHERE username = %s AND password = %s;"
    try:
        with MySQLClient() as client:
            cursor = client.connection.cursor()
            cursor.execute(query, (username, password))
            result = cursor.fetchone()
            return result['user_count'] > 0
    except Exception as e:
        log.error(f"Error checking username and password: {e}")
        raise e

def get_user_from_username_and_password(username: str, password: str) -> dict:
    """
    Retrieve a user from the database by their username and password.

    :param username: The username of the user.
    :param password: The password of the user.
    :return: A dictionary containing user details if found, None otherwise.
    """
    query = "SELECT id, name, username FROM user WHERE username = %s AND password = %s;"
    try:
        with MySQLClient() as client:
            cursor = client.connection.cursor()
            cursor.execute(query, (username, password))
            user = cursor.fetchone()
            return user
    except Exception as e:
        log.error(f"Error retrieving user by username and password: {e}")
        raise e