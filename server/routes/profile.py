import logging
import uuid

from azure.storage.blob import BlobClient, BlobServiceClient, ContainerClient
from flask import Blueprint, jsonify, request
from flask_jwt_extended import (create_access_token, get_jwt_identity,
                                jwt_required)

from services.profile import create_profile, get_profile, update_profile
from utils.config import (AZURE_FILE_PREFIX, AZURE_STORAGE_CONNECTION_STRING,
                          CONTAINER_NAME)
from utils.error import (AGE_MUST_BE_INTEGER, AGE_MUST_BE_POSITIVE_INTEGER,
                         INVALID_EDUCATION, INVALID_FIELD, INVALID_GENDER,
                         INVALID_HOME_TOWN, INVALID_LANGUAGE,
                         INVALID_OCCUPATION, INVALID_PROFILE_PICTURE_URL,
                         INVALID_SUB_GROUP, PHOTO_CANNOT_BE_UPLOADED,
                         PHOTO_NOT_FOUND)
from utils.response import ErrorResponse, SuccessResponse
from utils.result import Result

log = logging.getLogger("profile")

blob_service_client = BlobServiceClient.from_connection_string(
    AZURE_STORAGE_CONNECTION_STRING
)
container_client = blob_service_client.get_container_client(CONTAINER_NAME)
try:
    container_client.create_container()
except Exception as e:
    log.error(f"Container already exists: {e}")

profile = Blueprint("profile", __name__)


def validate_profile_request(request: dict) -> Result[None]:
    allowed_felids = [
        "age",
        "gender",
        "home_town",
        "language",
        "occupation",
        "education",
        "sub_group",
        "about",
        "interests",
        "looking_for",
        "advice_to_younger_self",
        "your_meaning_of_life",
        "biggest_achievement",
        "biggest_challenge",
        "profile_picture_url",
    ]
    for key in request.keys():
        if key not in allowed_felids:
            return Result(success=False, error=INVALID_FIELD(key))
        if key == "age":
            if not isinstance(request[key], int):
                return Result(success=False, error=AGE_MUST_BE_INTEGER)
            if request[key] < 0:
                return Result(success=False, error=AGE_MUST_BE_POSITIVE_INTEGER)
        elif key == "gender":
            if request[key] not in ["MALE", "FEMALE", "OTHER"]:
                return Result(success=False, error=INVALID_GENDER)
        elif key == "home_town":
            if len(request[key]) > 255:
                return Result(success=False, error=INVALID_HOME_TOWN)
        elif key == "language":
            if len(request[key]) > 1024:
                Result(success=False, error=INVALID_LANGUAGE)
        elif key == "occupation":
            if len(request[key]) > 1024:
                Result(success=False, error=INVALID_OCCUPATION)
        elif key == "education":
            if len(request[key]) > 1024:
                Result(success=False, error=INVALID_EDUCATION)
        elif key == "sub_group":
            if len(request[key]) > 1024:
                Result(success=False, error=INVALID_SUB_GROUP)
        elif key == "profile_picture_url":
            if len(request[key]) > 1024:
                Result(success=False, error=INVALID_PROFILE_PICTURE_URL)
    return Result(success=True, value=None)


@profile.route("/<id>", methods=["GET"])
@jwt_required()
def get_profile_handler(id):
    result = get_profile(id)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    return SuccessResponse.from_value(result.value.to_dict(), 200)


@profile.route("/", methods=["POST"])
@jwt_required()
def create_profile_handler():
    log.error("Create profile")
    result = validate_profile_request(request.json)
    id = get_jwt_identity()
    if not result.success:
        return ErrorResponse.from_error(result.error)
    result = create_profile(id, request.json)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    return SuccessResponse.from_value(result.value.to_dict(), 201)


@profile.route("/", methods=["PUT"])
@jwt_required()
def update_profile_handler():
    result = validate_profile_request(request.json)
    id = get_jwt_identity()
    if not result.success:
        return ErrorResponse.from_error(result.error)
    result = update_profile(id, request.json)
    if not result.success:
        return ErrorResponse.from_error(result.error)
    return SuccessResponse.from_value(True, 200)


@profile.route("/upload_image", methods=["POST"])
@jwt_required()
def upload_image():
    id = get_jwt_identity()
    if "photo" not in request.files:
        return ErrorResponse.from_error(PHOTO_NOT_FOUND)

    file = request.files["photo"]

    # If no file is selected
    if file.filename == "":
        return ErrorResponse.from_error(PHOTO_NOT_FOUND)
    # Generate a unique name for the file (to avoid conflicts)
    file_name = str(id) + str(uuid.uuid4())
    file_url = AZURE_FILE_PREFIX + file_name
    try:
        # Upload file to Azure Blob Storage
        blob_client = container_client.get_blob_client(file_name)
        blob_client.upload_blob(file)

        return SuccessResponse.from_value({"url": file_url})
    except Exception as e:
        return ErrorResponse.from_error(PHOTO_CANNOT_BE_UPLOADED)
