class ValidationFailedError(RuntimeError):
    ROBOT_CONTINUE_ON_FAILURE = True

class ElementNotFoundException(RuntimeError):
    ROBOT_CONTINUE_ON_FAILURE = True
