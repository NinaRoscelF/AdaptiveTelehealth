from Selenium2Library.locators import WindowManager
from selenium.webdriver.support.ui import WebDriverWait
from robot.api import logger

class ATHWindowManager(WindowManager):
    def wait_for_new_window(self, driver, timeout=10.0):
        '''Wait for new window to be launched
        Implementation: Check window handles until new window appears - i.e. prev_win != curr_win
        '''
        curr_handles = driver.window_handles
        try:
            WebDriverWait(driver, timeout).until(lambda driver: len(curr_handles) != len(driver.window_handles))
        except:
            logger.info("No change in Window Handles detected! Proceeding to Switch Window")

    def ath_select_new_window(self, browser, timeout=10.0):
        '''Navigate to the new window launched'''
        self.wait_for_new_window(browser, timeout)
        self.select(browser, 'new')
