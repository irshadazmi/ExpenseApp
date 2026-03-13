from fastapi import HTTPException
from enum import Enum

class ErrorCode(Enum):
    """Enum for HTTP status codes."""
    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    NOT_FOUND = 404
    TOO_MANY_REQUESTS = 429
    INTERNAL_SERVER_ERROR = 500

# Authentication Exceptions
class UserAlreadyExistsException(HTTPException):
    """Exception raised when a user already exists."""
    def __init__(self, detail: str = "User already exists"):
        super().__init__(status_code=ErrorCode.BAD_REQUEST.value, detail=detail)

class AuthenticationFailedException(HTTPException):
    """Exception raised when login fails."""
    def __init__(self, detail: str = "Invalid authentication"):
        super().__init__(status_code=ErrorCode.UNAUTHORIZED.value, detail=detail)

class PasswordMismatchException(HTTPException):
    """Exception raised when passwords do not match."""
    def __init__(self, detail: str = "Passwords do not match"):
        super().__init__(status_code=ErrorCode.BAD_REQUEST.value, detail=detail)

# Database Exceptions
class RecordNotFoundException(HTTPException):
    """Exception raised when a record is not found."""
    def __init__(self, detail: str = "Record not found"):
        super().__init__(status_code=ErrorCode.NOT_FOUND.value, detail=detail)

class RecordAlreadyExistsException(HTTPException):
    """Exception raised when a record already exists."""
    def __init__(self, detail: str = "Record already exists"):
        super().__init__(status_code=ErrorCode.BAD_REQUEST.value, detail=detail)

class EmailOrPhoneAlreadyExistsException(HTTPException):
    """Exception raised when an email or phone number already exists."""
    def __init__(self, detail: str = "Email or phone number already exists"):
        super().__init__(status_code=ErrorCode.BAD_REQUEST.value, detail=detail)

class FailedToCreateException(HTTPException):
    """Exception raised when creating a record fails."""
    def __init__(self, detail: str = "Failed to create a new record"):
        super().__init__(status_code=ErrorCode.BAD_REQUEST.value, detail=detail)

class FailedToUpdateException(HTTPException):
    """Exception raised when updating a record fails."""
    def __init__(self, detail: str = "Failed to update the record"):
        super().__init__(status_code=ErrorCode.BAD_REQUEST.value, detail=detail)

class FailedToDeleteException(HTTPException):
    """Exception raised when deleting a record fails."""
    def __init__(self, detail: str = "Failed to delete the record"):
        super().__init__(status_code=ErrorCode.BAD_REQUEST.value, detail=detail)

# Registration Exceptions
class RegistrationFailedException(HTTPException):
    """Exception raised when registration fails."""
    def __init__(self, detail: str = "Registration failed. Please try again"):
        super().__init__(status_code=ErrorCode.BAD_REQUEST.value, detail=detail)

# Rate Limiting Exceptions
class TooManyRequestsException(HTTPException):
    """Exception raised when too many requests are made."""
    def __init__(self, detail: str = "Too many requests"):
        super().__init__(status_code=ErrorCode.TOO_MANY_REQUESTS.value, detail=detail)

# Server Exceptions
class InternalServerErrorException(HTTPException):
    """Exception raised for internal server errors."""
    def __init__(self, detail: str = "Internal server error"):
        super().__init__(status_code=ErrorCode.INTERNAL_SERVER_ERROR.value, detail=detail)