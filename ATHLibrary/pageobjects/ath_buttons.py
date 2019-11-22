import robot
from robot.api import logger
from selenium.webdriver.common.keys import Keys

from ATHLibrary.core.ath_element_finder import ATHElementFinder
from ATHLibrary.core.input_value_overrides import Overrides
from ATHLibrary.pageobjects import handle_stale_element
from ATHLibrary.core.ath_exceptions import ValidationFailedError
from selenium.common.exceptions import NoSuchElementException
from selenium import webdriver
from Selenium2Library.keywords._javascript import _JavaScriptKeywords
from selenium.webdriver.support.ui import WebDriverWait

class ATHButtons(ATHElementFinder):

    ###########
    # Buttons #
    ###########

    @handle_stale_element
    def ath_click_button(self, button_name, index=1, country='English US', should_wait='true'):
        if not button_name: return
        translated = self._get_translation(button_name,country)
        elem = self.get_button_by_label(translated, index, 0.250)
        if elem[0] is not None:
            try:
                import re
                logger.info(elem[1])
                locator_trim = re.sub(r'xpath=',r'',elem[1])
                elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()'%(locator_trim.replace("\'","\""))
                self.execute_javascript(elem_js)
                self._info('Successfully clicked by javascript..')
            except:
                self.wait_until_element_is_enabled(elem[0],10)
                self.click_element(elem[0])
            boolean_should_wait = self._determine_should_be_checked(should_wait)
            if boolean_should_wait:
                self.ath_wait_until_loaded()
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(button_name))

    @handle_stale_element
    def ath_check_button_existence(self, button_name, index=1, is_positive='true', country='English US'):
        if not button_name: return
        translated = self._get_translation(button_name,country)
        elem = self.get_button_by_label(translated, index, 0.250)

        if is_positive == 'true':
            import re
            locator_trim = re.sub(r'xpath=',r'',elem[1])
            elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim)
            self.execute_javascript(elem_js)
            logger.info("Scrolled Successfully...")

        if elem[0] is None:
            logger.info("Button with name - %s is not visible"%(elem[1]))

        boolean_is_positive = self._determine_should_be_checked(is_positive)
        if elem[0] and boolean_is_positive:
            logger.info("Button with name - %s is visible"%(button_name))
        if elem[0] and not(boolean_is_positive):
            raise ValidationFailedError("Button with name - %s should not be visible"%(button_name))
        if not (elem[0]) and not(boolean_is_positive):
            logger.info("Button with name - %s is not visible as expected"%(button_name))
        if not (elem[0]) and boolean_is_positive:
            raise ValidationFailedError("Button with name - %s should be visible"%(button_name))


    #########
    # Icons #
    #########
    #@handle_stale_element
    def ath_click_icon(self,icon_name,escape='false'):

        if not icon_name: return

        element = self._ath_wait_until_element_present(icon_name,30,'true')
        logger.info(element[0])
        logger.info(element[1])
        logger.info(element[2])
        import re
        locator_trim = re.sub(r'xpath=',r'',element[1])
        if escape == 'true':
            locator_trim = locator_trim.replace("\'","\\\'")
        else:
            locator_trim = locator_trim.replace("\'","\"")
            
        if element[0] is True:
            try:
                elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim)
#                self.execute_javascript(elem_js)
                self.click_element(element[1])
                self._info('Successfully clicked by locator..')
            except:
                elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim)
#                self.execute_javascript(elem_js)
                self.click_element(element[2])
                self._info('Successfully clicked by element..')
                # self.wait_until_element_is_visible(element[1],100)
                # self.wait_until_element_is_enabled(element[1],100)
                # self.click_element(element[1])
            self.ath_wait_until_loaded()
    
    @handle_stale_element
    def ath_check_icon_existence(self,locator,is_positive='true',timeout=0.5):
        if not locator: return
        elem = self._ath_wait_until_element_present(locator,timeout)
        boolean_is_positive = self._determine_should_be_checked(is_positive)
        if elem[0] and boolean_is_positive:
            logger.info("Icon with name - %s is visible"%(locator))
        if elem[0] and not(boolean_is_positive):
            raise ValidationFailedError("Icon with name - %s should not be visible"%(locator))
        if not(elem[0]) and not(boolean_is_positive):
            logger.info("Icon with name - %s is not visible as expected"%(locator))
        if not(elem[0]) and boolean_is_positive:
            raise ValidationFailedError("Icon with name - %s should be visible"%(locator))


