import time
import robot
from robot.api import logger
from selenium.common.exceptions import StaleElementReferenceException
from Selenium2Library.keywords import _WaitingKeywords
from ATHLibrary.pageobjects import handle_stale_element

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC

class ATHWaits(_WaitingKeywords):

    def wait_for_manual_step(self, timeout=0.0):
        '''Wait for `timeout` secs'''
        time.sleep(float(timeout))

    def _ath_wait_until_no_error(self, timeout, wait_func, *args):
        timeout = robot.utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        maxtime = time.time() + timeout
        while True:
            timeout_error = wait_func(*args)
            if not timeout_error: return
            if time.time() > maxtime:
                raise AssertionError(timeout_error)
            time.sleep(.250)

    def _ath_format_timeout(self, timeout):
        timeout = robot.utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        return robot.utils.secs_to_timestr(timeout)


    @handle_stale_element
    def ath_wait_until_element_is_present(self, locator, timeout=10.0):
        timeout = robot.utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        maxtime = time.time() + timeout
        while True:
            element_located = self._element_find(locator, True, False)
            if element_located is not None: return True,element_located
            if time.time() > maxtime:
                logger.warn("Element not visible after %s seconds" %(timeout))
                return False,None
            time.sleep(.250)
        return False,None