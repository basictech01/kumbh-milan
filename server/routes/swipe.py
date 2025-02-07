import logging

from flask import Blueprint, request
from flask_jwt_extended import get_jwt_identity, jwt_required

from services.swipe import (get_all_matched_users, get_all_users_like,
                            get_new_users_to_swipe, swipe_left, swipe_right)
from utils.error import USER_ID_SWIPED_MISSING
from utils.response import ErrorResponse, SuccessResponse

log = logging.getLogger("swipe")

swipe = Blueprint("swipe", __name__)


@swipe.route("/", methods=["GET"])
@jwt_required()
def get_swipe_handler():
    id = get_jwt_identity()
    id = int(id)
    result = get_new_users_to_swipe(id, 50)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    profiles_serialized = [profile.to_dict() for profile in result.value]
    return SuccessResponse.from_value(profiles_serialized, 200)


@swipe.route("/right", methods=["POST"])
@jwt_required()
def swipe_right_handler():
    id = get_jwt_identity()
    id = int(id)
    user_id_swiped = request.json.get("user_id_swiped")
    if not user_id_swiped:
        return ErrorResponse.from_error(USER_ID_SWIPED_MISSING)
    result = swipe_right(id, user_id_swiped)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    return SuccessResponse.from_value(result.value, 200)


@swipe.route("/left", methods=["POST"])
@jwt_required()
def swipe_left_handler():
    id = get_jwt_identity()
    id = int(id)
    user_id_swiped = request.json.get("user_id_swiped")
    if not user_id_swiped:
        return ErrorResponse.from_error(USER_ID_SWIPED_MISSING)
    result = swipe_left(id, user_id_swiped)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    return SuccessResponse.from_value(result.value, 200)


@swipe.route("/matched", methods=["GET"])
@jwt_required()
def get_matched_handler():
    id = get_jwt_identity()
    id = int(id)
    result = get_all_matched_users(id)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    profiles_serialized = [profile.to_dict() for profile in result.value]
    return SuccessResponse.from_value(profiles_serialized, 200)


@swipe.route("/liked", methods=["GET"])
@jwt_required()
def get_liked_handler():
    id = get_jwt_identity()
    id = int(id)
    result = get_all_users_like(id)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    profiles_serialized = [profile.to_dict() for profile in result.value]
    return SuccessResponse.from_value(profiles_serialized, 200)
