from dataclasses import dataclass


@dataclass
class Error:
    code: int
    message: str
    status_code: int = 500
    client_message: str = "Internal Server Error"


# all generic errors starts from 10000
DATABASE_ERROR = Error(10001, "Database error", 500, "INTERNAL SERVER ERROR")


class MISSING_FIELD(Error):
    def __init__(self, field: str):
        super().__init__(
            10002,
            f"The field '{field}' is required.",
            400,
            f"The field '{field}' is required.",
        )

class INVALID_FIELD(Error):
    def __init__(self, field: str):
        super().__init__(
            10002,
            f"The field '{field}' is invalid.",
            400,
            f"The field '{field}' is invalid.",
        )


# all user error starts from 20000
USER_NOT_FOUND = Error(20001, "User not found", 404, "User not found")
USER_PASSWORD_INCORRECT = Error(
    20002, "Password is incorrect", 401, "Password is incorrect"
)
USER_EXISTS = Error(20003, "User already exists", 400, "User already exists")

# all profile errors starts from 30000
PROFILE_NOT_FOUND = Error(30001, "Profile not found", 404, "Profile not found")
PHOTO_NOT_FOUND = Error(30002, "Photo not found", 404, "Photo not found")
PHOTO_CANNOT_BE_UPLOADED = Error(30003, "Photo cannot be uploaded", 500, "Internal Server Error")
AGE_MUST_BE_INTEGER = Error(30004, "Age must be an integer", 400, "Age must be an integer")
AGE_MUST_BE_POSITIVE_INTEGER = Error(30005, "Age must be a positive integer", 400, "Age must be a positive integer")
INVALID_GENDER = Error(30006, "Invalid gender", 400, "Invalid gender value")
INVALID_HOME_TOWN = Error(30007, "Invalid home town", 400, "Invalid home town")
INVALID_LANGUAGE = Error(30008, "Invalid language", 400, "Invalid language")
INVALID_OCCUPATION = Error(30009, "Invalid occupation", 400, "Invalid occupation")
INVALID_EDUCATION = Error(30010, "Invalid education", 400, "Invalid education")
INVALID_SUB_GROUP = Error(30011, "Invalid sub group", 400, "Invalid sub group")
INVALID_PROFILE_PICTURE_URL = Error(30012, "Invalid profile picture URL", 400, "Invalid profile picture URL")

