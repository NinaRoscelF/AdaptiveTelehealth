from robot.api import logger
from selenium.webdriver.common.keys import Keys
from Selenium2Library.keywords._formelement import _FormElementKeywords
from selenium.common.exceptions import StaleElementReferenceException
from selenium.common.exceptions import ElementNotVisibleException
from ATHLibrary.core.ath_element_finder import ATHElementFinder
from ATHLibrary.core.ath_exceptions import ValidationFailedError
from ATHLibrary.core.input_value_overrides import Overrides
from ATHLibrary.pageobjects.ath_inputs import ATHInputs
from ATHLibrary.core.ath_browsermgr import ATHBrowserMgr
from ATHLibrary.core.commonfunctions import CommonFunctions

class ATHFlows(ATHElementFinder, _FormElementKeywords):


    def kill_process(self):
        import platform
        if platform.system() == 'Windows':
            import os
            os.system("taskkill /f /im  firefox.exe")
            os.system("taskkill /f /im  geckodriver.exe")
            os.system("taskkill /f /im  iexplore.exe")
            os.system("taskkill /f /im  iedriverserver.exe")
            os.system("taskkill /f /im  chrome.exe")
            os.system("taskkill /f /im  chromedriver.exe")
        else:
            import os
            os.system("killall -SIGTERM firefox")

    def ath_Logon(self, browser, url, user_name, client,profiledir='firefoxprofile',killall=False):

        if killall:
            self.kill_process()
        try:
            # https://github.com/Hi-Fi/robotframework-seleniumlibrary-java/issues/21
            self.open_browser(url, browser, ff_profile_dir=profiledir)
        except:
            self.wait_for_manual_step(5.0)
            self.open_browser(url, browser, ff_profile_dir=profiledir)

        self.maximize_browser_window()
        pwd = self._get_password(user_name,client)
        # logger.info("Password before decoding is %s"%(pwd))
        if "adaptive.com" in user_name:

            import base64
            # decode using base64 encoding
            logger.info("Password encoded - decoding..")
#            pwd = base64.b64decode(pwd)
            # logger.info("Password decoded is %s"%(pwd))

        self.wait_until_page_contains_element("OR:ath_login_username",30)
        self.input_text("OR:ath_login_username", user_name)
        self.input_password("OR:ath_login_password", pwd)
        self.click_element("OR:ath_login_button")
        self.ath_wait_until_loaded(100)


    def ath_Logout(self):
        ''' Log-off Current session & Closes the Browser'''
        logger.info("Logoff...")
        self.wait_for_manual_step(2.0)
        self.ath_wait_until_loaded(40)
        self.click_element("OR:logout_icon")
        self.ath_wait_until_loaded(100)
        self.wait_until_page_contains_element("//h3[@class='box-title'][normalize-space()='Login']",2.0)


    def ath_launch_via_shortcut_keys(self,ShortcutKey="CTRL+Q",target="//*[contains(@class,'panel panel-default')]"):
        # Direct to mainpage
        element = self._element_find(target, True, True)
        if ShortcutKey ==  "CTRL+Q":
            element.send_keys(Keys.CONTROL + 'q')
        elif ShortcutKey ==  "Shift+F8":
            element.send_keys(Keys.SHIFT + Keys.F8)
        elif ShortcutKey ==  "CTRL+A":
            element.send_keys(Keys.CONTROL + 'a')
        elif ShortcutKey ==  "DEL":
            element.send_keys(Keys.DELETE)
        elif ShortcutKey ==  "CTRL+O":
            element.send_keys(Keys.CONTROL + 'o')
        elif ShortcutKey ==  "Shift+F3":
            element.send_keys(Keys.SHIFT + Keys.F3)
        elif ShortcutKey ==  "Shift+F5":
            element.send_keys(Keys.SHIFT + Keys.F5)
        elif ShortcutKey ==  "CTRL+C":
            element.send_keys(Keys.CONTROL + 'c')
        elif ShortcutKey ==  "CTRL+F":
            element.send_keys(Keys.CONTROL + 'f')
        elif ShortcutKey ==  "CTRL+V":
            element.send_keys(Keys.CONTROL + 'v')
        elif ShortcutKey ==  "CTRL+X":
            element.send_keys(Keys.CONTROL + 'x')
        elif ShortcutKey ==  "CTRL+M":
            element.send_keys(Keys.CONTROL + 'm')
        elif ShortcutKey ==  "CTRL+P":
            element.send_keys(Keys.CONTROL + 'p')
        elif ShortcutKey ==  "ESC":
            element.send_keys(Keys.ESCAPE)
        elif ShortcutKey ==  "TAB":
            element.send_keys(Keys.TAB)
        elif ShortcutKey ==  "ALT+SHIFT+N":
            element.send_keys(Keys.ALT + Keys.SHIFT + 'n')
        elif ShortcutKey ==  "ALT+N":
            element.send_keys(Keys.ALT + 'n')
        elif ShortcutKey ==  "ENTER":
            element.send_keys(Keys.ENTER)
        elif ShortcutKey ==  "ALT+F4":
            element.send_keys(Keys.ALT + Keys.F4)
        elif ShortcutKey ==  "F1":
            element.send_keys(Keys.F1)
        elif ShortcutKey ==  "F2":
            element.send_keys(Keys.F2)
        elif ShortcutKey ==  "F3":
            element.send_keys(Keys.F3)
        elif ShortcutKey ==  "F4":
            element.send_keys(Keys.F4)
        elif ShortcutKey ==  "F5":
            element.send_keys(Keys.F5)
        elif ShortcutKey ==  "F6":
            element.send_keys(Keys.F6)
        elif ShortcutKey ==  "F7":
            element.send_keys(Keys.F7)
        elif ShortcutKey ==  "F8":
            element.send_keys(Keys.F8)
        elif ShortcutKey ==  "F9":
            element.send_keys(Keys.F9)
        elif ShortcutKey ==  "F10":
            element.send_keys(Keys.F10)
        elif ShortcutKey ==  "F11":
            element.send_keys(Keys.F11)
        elif ShortcutKey ==  "F12":
            element.send_keys(Keys.F12)
        elif ShortcutKey ==  "CTRL+1":
            element.send_keys(Keys.CONTROL + '1')
        elif ShortcutKey ==  "CTRL+2":
            element.send_keys(Keys.CONTROL + '2')
        elif ShortcutKey ==  "CTRL+3":
            element.send_keys(Keys.CONTROL + '3')
        elif ShortcutKey ==  "CTRL+4":
            element.send_keys(Keys.CONTROL + '4')
        elif ShortcutKey ==  "CTRL+5":
            element.send_keys(Keys.CONTROL + '5')
        elif ShortcutKey ==  "CTRL+6":
            element.send_keys(Keys.CONTROL + '6')
        elif ShortcutKey ==  "CTRL+7":
            element.send_keys(Keys.CONTROL + '7')
        elif ShortcutKey ==  "CTRL+8":
            element.send_keys(Keys.CONTROL + '8')
        elif ShortcutKey ==  "CTRL+9":
            element.send_keys(Keys.CONTROL + '9')
        else:
            raise ValueError("Shortcut Key not found: '%s'" % ShortcutKey)


    def format_number_with_comma(self,number,isfloat="true"):
        ''' formats a number with commas, provide true if value has decimal
        and false otherwise'''

        if isfloat == "true":
            isnumber = float(number)
            return '{:,.2f}'.format(isnumber)
        elif isfloat == "false":
            isnumber = int(number)
            return '{:,}'.format(isnumber)
        elif type(isnumber) == str:
            logger.info('Input is not a valid integer value')

    def rgb2hex(self, str):
       # hex = "#{:02x}{:02x}{:02x}".format(r,g,b)
        import re
        return   '%02x%02x%02x' % (map(int, re.findall('\d+', str))[0], map(int, re.findall('\d+', str))[1], map(int, re.findall('\d+', str))[2])

