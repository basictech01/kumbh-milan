import logging
import random
import time

from models.profile import Profile
from utils.error import DATABASE_ERROR, INVALID_MATCH, INVALID_SWIPE
from utils.mysql_client import MySQLConnection
from utils.result import Result

log = logging.getLogger("swipe_service")

CACHE_TOTAL_NUMBER_USERS = None
CACHE_TOTAL_NUMBER_USERS_TIME = None

"""
CREATE TABLE swipe (
    user_min_id INT,
    user_max_id INT,
    operation INT,
    PRIMARY KEY (user_min_id, user_max_id)
    UNIQUE KEY (user_max_id, user_min_id)
    KEY (operation)
)
"""

"""
swipe table has 3 columns and represents the swipe interaction between two users
user_min_id is the user id of the user which id is smaller
user_max_id is the user id of the user which id is bigger

OPERATION will have unique value depending on the operation that has been performed
user_min can do two operation swipe left or swipe right they are represented by 2 and 4 respectively
user_max can do two operation swipe left or swipe right they are represented by 3 and 9 respectively

FOLLOWING is the truth table for the operation
| user_min | user_max | operation |
|   X      |    X     | row not present or 1|
|   L      |    X     |     2     |
|   R      |    X     |     4     |
|   X      |    L     |     3     |
|   X      |    R     |     9     |
|   L      |    L     |     6     |
|   R      |    R     |     36    |
|   L      |    R     |     18    |
|   R      |    L     |     12    |
"""


def _get_total_number_users_from_database() -> Result[int]:
    query = "SELECT COUNT(*) as count FROM user"
    try:
        with MySQLConnection() as connection:
            result = connection.read_one(query)
            return Result(success=True, value=result["count"])
    except Exception as e:
        log.error(f"Error getting total number of users: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def _get_total_number_users() -> Result[int]:
    global CACHE_TOTAL_NUMBER_USERS
    global CACHE_TOTAL_NUMBER_USERS_TIME
    if (
        CACHE_TOTAL_NUMBER_USERS is not None
        and CACHE_TOTAL_NUMBER_USERS_TIME is not None
    ):
        if time.time() - CACHE_TOTAL_NUMBER_USERS_TIME < 60 * 15:  # 15 minutes
            return Result(success=True, value=CACHE_TOTAL_NUMBER_USERS)
    result = _get_total_number_users_from_database()
    if result.success:
        CACHE_TOTAL_NUMBER_USERS = result.value
        CACHE_TOTAL_NUMBER_USERS_TIME = time.time()
        return result
    else:
        if CACHE_TOTAL_NUMBER_USERS is not None:
            return Result(success=True, value=CACHE_TOTAL_NUMBER_USERS)
        return Result(success=False, error=result.error)


def __filter_swiped_users(user_id, ids: list[int]) -> Result[list[int]]:
    query = "SELECT * from swipe WHERE user_min_id = %s or user_max_id = %s"
    try:
        with MySQLConnection() as connection:
            result = connection.read(query, user_id, user_id)
            swiped_ids = set()
            swiped_ids.add(user_id)  # Add the user itself
            for row in result:
                # skipping the users for which user has only right swipe (they can be potential match)
                if row["user_min_id"] == user_id and row["operation"] != 9:
                    swiped_ids.add(row["user_max_id"])
                if row["user_max_id"] == user_id and row["operation"] != 4:
                    swiped_ids.add(row["user_min_id"])
            filtered_ids = [id for id in ids if id not in swiped_ids]
            return Result(success=True, value=filtered_ids)
    except Exception as e:
        log.error(f"Error filtering swiped users: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def __convert_to_profile(user: list[int]) -> Result[list[Profile]]:
    try:
        with MySQLConnection() as connection:
            query = f"SELECT user_id, name, age, gender, home_town, language, occupation, education, \
                 sub_group, about, interests, looking_for, advice_to_younger_self, your_meaning_of_life, biggest_achievement, biggest_challenge, profile_picture_url FROM profile WHERE user_id in ({','.join(['%s' for _ in user])})"
            profile = connection.read(query, *user)
            return Result(success=True, value=[Profile(**p) for p in profile])
    except Exception as e:
        log.error(f"Error converting to profile: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def __convert_to_profile_with_phone(user: list[int]) -> Result[list[Profile]]:
    try:
        with MySQLConnection() as connection:
            query = f"SELECT user_id, profile.name as name, age, gender, home_town, language, occupation, education, user.phone as phone,  \
                 sub_group, about, interests, looking_for, advice_to_younger_self, your_meaning_of_life, biggest_achievement, biggest_challenge, profile_picture_url FROM profile JOIN user where user.id= profile.user_id and user_id in ({','.join(['%s' for _ in user])})"
            profile = connection.read(query, *user)
            return Result(success=True, value=[Profile(**p) for p in profile])
    except Exception as e:
        log.error(f"Error converting to profile: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def get_new_users_to_swipe(user_id, page_length) -> Result[list[Profile]]:
    total_number_users = _get_total_number_users()
    if not total_number_users.success:
        return Result(success=False, error=total_number_users.error)
    total_pages = total_number_users.value // page_length

    random_page = random.randint(0, total_pages)
    offset = random_page * page_length
    query = "SELECT id FROM user where id != %s and last_accessed > NOW() - INTERVAL 2 DAY LIMIT %s, %s"
    try:
        with MySQLConnection() as connection:
            ids = connection.read(query, user_id, offset, page_length)
            ids = [row["id"] for row in ids]
            filtered_user = __filter_swiped_users(user_id, ids)
            if not filtered_user.success:
                return Result(success=False, error=filtered_user.error)
            if not filtered_user.value:
                return Result(success=True, value=[])
            profiles = __convert_to_profile(filtered_user.value)
            if not profiles.success:
                return Result(success=False, error=profiles.error)
            return Result(success=True, value=profiles.value)
    except Exception as e:
        log.error(f"Error getting new users to swipe: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def swipe_left(user_id, user_id_swiped):
    if user_id == user_id_swiped:
        return Result(success=False, error=INVALID_SWIPE)
    if user_id > user_id_swiped:
        query = "SELECT * from swipe WHERE user_min_id = %s and user_max_id = %s"
        try:
            with MySQLConnection() as connection:
                result = connection.read_one(query, user_id_swiped, user_id)
                if result:
                    if result["operation"] in [2, 4]:
                        query = "UPDATE swipe SET operation = operation * 3 WHERE user_min_id = %s and user_max_id = %s"
                        connection.write(query, user_id_swiped, user_id)
                        return Result(success=True, value=True)
                    if result["operation"] in [9, 18, 36]:
                        query = "UPDATE swipe SET operation = operation / 3 WHERE user_min_id = %s and user_max_id = %s"
                        connection.write(query, user_id_swiped, user_id)
                        return Result(success=True, value=True)
                    if result["operation"] in [3, 6, 12]:
                        return Result(success=True, value=True)
                else:
                    query = "INSERT INTO swipe (user_min_id, user_max_id, operation) VALUES (%s, %s, %s)"
                    connection.write(query, user_id_swiped, user_id, 3)
                    return Result(success=True, value=True)
        except Exception as e:
            log.error(f"Error swiping left: {e}")
            return Result(success=False, error=DATABASE_ERROR)
    else:
        query = "SELECT * from swipe WHERE user_min_id = %s and user_max_id = %s"
        try:
            with MySQLConnection() as connection:
                result = connection.read_one(query, user_id, user_id_swiped)
                if result:
                    if result["operation"] in [3, 9]:
                        query = "UPDATE swipe SET operation = operation * 2 WHERE user_min_id = %s and user_max_id = %s"
                        connection.write(query, user_id, user_id_swiped)
                        return Result(success=True, value=True)
                    if result["operation"] in [4, 12, 36]:
                        query = "UPDATE swipe SET operation = operation / 2 WHERE user_min_id = %s and user_max_id = %s"
                        connection.write(query, user_id, user_id_swiped)
                        return Result(success=True, value=True)
                    if result["operation"] in [2, 6, 18]:
                        return Result(success=True, value=True)
                else:
                    query = "INSERT INTO swipe (user_min_id, user_max_id, operation) VALUES (%s, %s, %s)"
                    connection.write(query, user_id, user_id_swiped, 2)
                    return Result(success=True, value=True)
        except Exception as e:
            log.error(f"Error swiping left: {e}")
            return Result(success=False, error=DATABASE_ERROR)


def swipe_right(user_id, user_id_swiped):
    if user_id == user_id_swiped:
        return Result(success=False, error=INVALID_SWIPE)
    if user_id > user_id_swiped:
        query = "SELECT * from swipe WHERE user_min_id = %s and user_max_id = %s"
        try:
            with MySQLConnection() as connection:
                result = connection.read_one(query, user_id_swiped, user_id)
                if result:
                    if result["operation"] in [2, 4]:
                        query = "UPDATE swipe SET operation = operation * 9 WHERE user_min_id = %s and user_max_id = %s"
                        connection.write(query, user_id_swiped, user_id)
                        return Result(success=True, value=True)
                    if result["operation"] in [3, 6, 12]:
                        query = "UPDATE swipe SET operation = operation * 3 WHERE user_min_id = %s and user_max_id = %s"
                        connection.write(query, user_id_swiped, user_id)
                        return Result(success=True, value=True)
                    if result["operation"] in [9, 18, 36]:
                        return Result(success=True, value=True)
                else:
                    query = "INSERT INTO swipe (user_min_id, user_max_id, operation) VALUES (%s, %s, %s)"
                    connection.write(query, user_id_swiped, user_id, 9)
                    return Result(success=True, value=True)
        except Exception as e:
            log.error(f"Error swiping right: {e}")
            return Result(success=False, error=DATABASE_ERROR)
    else:
        query = "SELECT * from swipe WHERE user_min_id = %s and user_max_id = %s"
        try:
            with MySQLConnection() as connection:
                result = connection.read_one(query, user_id, user_id_swiped)
                if result:
                    if result["operation"] in [3, 9]:
                        query = "UPDATE swipe SET operation = operation * 4 WHERE user_min_id = %s and user_max_id = %s"
                        connection.write(query, user_id, user_id_swiped)
                        return Result(success=True, value=True)
                    if result["operation"] in [2, 6, 18]:
                        query = "UPDATE swipe SET operation = operation * 2 WHERE user_min_id = %s and user_max_id = %s"
                        connection.write(query, user_id, user_id_swiped)
                        return Result(success=True, value=True)
                    if result["operation"] in [4, 12, 36]:
                        return Result(success=True, value=True)
                else:
                    query = "INSERT INTO swipe (user_min_id, user_max_id, operation) VALUES (%s, %s, %s)"
                    connection.write(query, user_id, user_id_swiped, 4)
                    return Result(success=True, value=True)
        except Exception as e:
            log.error(f"Error swiping right: {e}")
            return Result(success=False, error=DATABASE_ERROR)


def check_if_matched(user_id, user_id_swiped):
    if user_id == user_id_swiped:
        return Result(success=False, error=INVALID_MATCH)

    query = "SELECT * from swipe WHERE (user_min_id = %s and user_max_id = %s) or (user_min_id = %s and user_max_id = %s) and operation = 36"
    try:
        with MySQLConnection() as connection:
            result = connection.read_one(
                query, user_id, user_id_swiped, user_id_swiped, user_id
            )
            if result:
                return Result(success=True, value=True)
            return Result(success=True, value=False)
    except Exception as e:
        log.error(f"Error checking if matched: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def get_all_matched_users(user_id) -> Result[list[Profile]]:
    try:
        with MySQLConnection() as connection:
            matched = []
            query = "SELECT user_max_id AS matched_user FROM swipe WHERE user_min_id = %s AND operation = 36 UNION SELECT user_min_id AS matched_user FROM swipe WHERE user_max_id = %s AND operation = 36"
            result = connection.read(query, user_id, user_id)
            matched.extend([row["matched_user"] for row in result])
            if not matched:
                return Result(success=True, value=[])
            result = __convert_to_profile_with_phone(matched)
            if result.success:
                return Result(success=True, value=result.value)
            return Result(success=False, error=result.error)

    except Exception as e:
        log.error(f"Error getting all matched users: {e}")
        return Result(success=False, error=DATABASE_ERROR)


def get_all_users_like(user_id) -> Result[list[Profile]]:
    try:
        with MySQLConnection() as connection:
            liked = []
            query = "SELECT user_max_id AS liked_user FROM swipe WHERE user_min_id = %s AND operation = 9 UNION SELECT user_min_id AS liked_user FROM swipe WHERE user_max_id = %s AND operation = 4"
            result = connection.read(query, user_id, user_id)
            liked.extend([row["liked_user"] for row in result])
            if not liked:
                return Result(success=True, value=[])
            result = __convert_to_profile(liked)
            if not result.success:
                return Result(success=False, error=result.error)
            return Result(success=True, value=result.value)
    except Exception as e:
        log.error(f"Error getting all users liked: {e}")
        return Result(success=False, error=DATABASE_ERROR)
