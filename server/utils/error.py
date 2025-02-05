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


# all user error starts from 20000
USER_NOT_FOUND = Error(20001, "User not found", 404, "User not found")
USER_PASSWORD_INCORRECT = Error(
    20002, "Password is incorrect", 401, "Password is incorrect"
)
USER_EXISTS = Error(20003, "User already exists", 400, "User already exists")
