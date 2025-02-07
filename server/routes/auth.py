from flask import Blueprint, request
from flask_jwt_extended import (create_access_token, get_jwt_identity,
                                jwt_required)

from services.auth import (check_username_exists, create_user,
                           get_user_from_username_and_password,
                           update_last_accessed)
from utils.error import MISSING_FIELD, USER_EXISTS
from utils.response import ErrorResponse, SuccessResponse

auth = Blueprint("auth", __name__)

import logging

log = logging.getLogger("auth")


@auth.route("/check_username_exists", methods=["POST"])
def check_user():
    data = request.json
    required_fields = ["username"]
    for field in required_fields:
        if field not in data:
            return ErrorResponse.from_error(MISSING_FIELD(field))

    username = data["username"]
    result = check_username_exists(username)

    if not result.success:
        return ErrorResponse.from_error(result.error)
    return SuccessResponse.from_value({"exists": result.value}, 200)


@auth.route("/register", methods=["POST"])
def register():
    data = request.json
    required_fields = ["name", "username", "password", "phone"]
    for field in required_fields:
        if field not in data:
            return ErrorResponse.from_error(MISSING_FIELD(field))

    name = data["name"]
    username = data["username"]
    password = data["password"]
    phone = data["phone"]

    # Check if the user already exists
    result = check_username_exists(username)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    if result.value:
        return ErrorResponse.from_error(USER_EXISTS)

    # Create the user
    result = create_user(name, username, password, phone)
    if result:
        return SuccessResponse.from_value(result.value.to_dict(), 201)
    return ErrorResponse.from_error(result.error)


@auth.route("/login", methods=["POST"])
def login():
    data = request.json
    required_fields = ["username", "password"]
    for field in required_fields:
        if field not in data:
            return ErrorResponse.from_error(MISSING_FIELD(field))

    username = data["username"]
    password = data["password"]

    # Authenticate the user
    result = get_user_from_username_and_password(username, password)

    if not result.success:
        return ErrorResponse.from_error(result.error)
    return SuccessResponse.from_value(result.value.to_dict(), 200)


@auth.route("/refresh", methods=["POST"])
@jwt_required(refresh=True)
def refresh():
    identity = get_jwt_identity()
    new_access_token = create_access_token(identity=identity)
    update_last_accessed(int(identity))
    return SuccessResponse.from_value({"access_token": new_access_token}, 200)
