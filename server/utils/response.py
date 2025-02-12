from flask import jsonify

from utils.error import Error


class Response:
    def __init__(self, success: bool, status_code: int):
        """
        Base class for responses.

        :param success: Indicates whether the operation was successful.
        :param status_code: HTTP-like status code as a string.
        """
        self.success = success
        self.status_code = status_code


class SuccessResponse(Response):
    def __init__(self, status_code: int, data: object):
        """
        Response for a successful operation.

        :param status_code: HTTP-like status code as a string.
        :param data: Data to return in case of a successful response.
        """
        super().__init__(success=True, status_code=status_code)
        self.data = data

    def to_dict(self):
        """
        Convert the success response to a dictionary.

        :return: Dictionary representation of the success response.
        """
        return {
            "success": self.success,
            "status_code": self.status_code,
            "data": self.data,
        }

    def from_value(value: object, status_code: int = 200):
        """
        Create a SuccessResponse from a value.

        :param value: Value to return in case of a successful response.
        :return: A SuccessResponse object.
        """
        return (
            jsonify(SuccessResponse(status_code=status_code, data=value).to_dict()),
            status_code,
        )


class ErrorResponse(Response):
    def __init__(self, status_code: int, error_code: int, message: str):
        """
        Response for an error case.

        :param status_code: HTTP-like status code as a string.
        :param error_code: Specific code identifying the error.
        :param message: Description of the error.
        """
        super().__init__(success=False, status_code=status_code)
        self.error_code = error_code
        self.message = message

    @staticmethod
    def from_error(error: Error):
        """
        Create an ErrorResponse from a Result object.

        :param result: Result object containing the error information.
        :return: An ErrorResponse object.
        """
        return (
            jsonify(
                ErrorResponse(
                    status_code=error.status_code,
                    error_code=error.code,
                    message=error.client_message,
                ).to_dict()
            ),
            error.status_code,
        )

    def to_dict(self):
        """
        Convert the error response to a dictionary.

        :return: Dictionary representation of the error response.
        """
        return {
            "success": self.success,
            "status_code": self.status_code,
            "data": {
                "error_code": self.error_code,
                "message": self.message,
            },
        }
