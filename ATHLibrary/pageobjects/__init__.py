import time
from robot.api import logger
from selenium.common.exceptions import StaleElementReferenceException
from selenium.common.exceptions import InvalidElementStateException
from selenium.common.exceptions import ElementNotVisibleException
from selenium.common.exceptions import WebDriverException
from selenium.common.exceptions import NoSuchElementException
from decorator import decorator
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.remote.webelement import WebElement

@decorator
def handle_stale_element(method, *args, **kwargs):
    '''This is a decorator which means it is a function used
    to wrap other functions.  It will wrap a function and if that
    function throws a StaleElementReferenceException, which usually
    happens becaue an AJAX call has changed an element we are trying
    to operate on, it will retry the function one more time, the idea
    is the function would just try to find the element again and then
    performe an operation on the element.
    To use this decorator on a function declare the function like:
    @handle_stale_element
    def myfunction():
    '''
    try:
        return method(*args, **kwargs)
    #except (StaleElementReferenceException, InvalidElementStateException, ElementNotVisibleException, WebDriverException) :
    except StaleElementReferenceException as e:
        # logger.warn("StaleElementReferenceException : Not Retrying")
        time.sleep(5.0)
        # pass
        logger.warn("StaleElementReferenceException: %s in %s" %(e, method.__name__))
        # time.sleep(5.0)
        return method(*args, **kwargs)

