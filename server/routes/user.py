from flask import Blueprint, request, jsonify
from services.user import check_username_exists, get_user_from_username_and_password, create_user, get_user_by_id
from utils.response import ErrorResponse, SuccessResponse

user = Blueprint('user', __name__)

@user.route('/check_username_exists', methods=['POST'])
def check_user():
    try:
        data = request.json
        required_fields = ["username"]
        for field in required_fields:
            if field not in data:
                return jsonify(
                    ErrorResponse(
                        status_code="400",
                        error_code="MISSING_FIELD",
                        message=f"The field '{field}' is required."
                    ).to_dict()
                ), 400

        username = data["username"]
        exists = check_username_exists(username)
        return jsonify(SuccessResponse(data={"exists": exists}, status_code=200).to_dict())
    except Exception as e:
        # Handle unexpected errors
        return jsonify(
            ErrorResponse(
                status_code="500",
                error_code="INTERNAL_SERVER_ERROR",
                message=str(e)
            ).to_dict()
        ), 500


@user.route('/register', methods=['POST'])
def register():
    try:
        data = request.json
        required_fields = ["name", "username", "password", "phone"]
        for field in required_fields:
            if field not in data:
                return jsonify(
                    ErrorResponse(
                        status_code="400",
                        error_code="MISSING_FIELD",
                        message=f"The field '{field}' is required."
                    ).to_dict()
                ), 400

        name = data["name"]
        username = data["username"]
        password = data["password"]
        phone = data["phone"]

        # Check if the user already exists
        if check_username_exists(username):
            return jsonify(
                ErrorResponse(
                    status_code="400",
                    error_code="USER_EXISTS",
                    message="A user with this username already exists."
                ).to_dict()
            ), 400

        # Create the user
        user = create_user(name, username, password)
        return jsonify(SuccessResponse(data=user, status_code=201).to_dict()), 201
    except Exception as e:
        # Handle unexpected errors
        return jsonify(
            ErrorResponse(
                status_code="500",
                error_code="INTERNAL_SERVER_ERROR",
                message=str(e)
            ).to_dict()
        ), 500

@user.route('/login', methods=['POST'])
def login():
    try:
        data = request.json
        required_fields = ["username", "password"]
        for field in required_fields:
            if field not in data:
                return jsonify(
                    ErrorResponse(
                        status_code="400",
                        error_code="MISSING_FIELD",
                        message=f"The field '{field}' is required."
                    ).to_dict()
                ), 400

        username = data["username"]
        password = data["password"]

        # Authenticate the user
        user = get_user_from_username_and_password(username, password)
        if not user:
            return jsonify(
                ErrorResponse(
                    status_code="401",
                    error_code="UNAUTHORIZED",
                    message="Invalid username or password."
                ).to_dict()
            ), 401

        return jsonify(SuccessResponse(data=user, status_code=200).to_dict()), 200
    except Exception as e:
        # Handle unexpected errors
        return jsonify(
            ErrorResponse(
                status_code="500",
                error_code="INTERNAL_SERVER_ERROR",
                message=str(e)
            ).to_dict()
        ), 500

