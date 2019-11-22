import time
from robot.api import logger
from selenium.webdriver.common.keys import Keys
from ATHLibrary.core.ath_element_finder import ATHElementFinder
from ATHLibrary.core.input_value_overrides import Overrides
from ATHLibrary.pageobjects import handle_stale_element
from ATHLibrary.core.ath_exceptions import ValidationFailedError
from selenium.common.exceptions import NoSuchElementException
from ATHLibrary.core.ath_exceptions import ElementNotFoundException
from selenium.common.exceptions import NoSuchElementException

class ATHLinks(ATHElementFinder):

    #########
    # Links #
    #########
    #@handle_stale_element
    def ath_click_link(self, link_name, index=1, str_format='%d.%m.%Y', country='English US', use_js=False):
        if not link_name: return
        text_value = Overrides.get_input_val(link_name, str_format)
        translated = self._get_translation(text_value,country)
        elem = self.get_link_by_label(translated, index)
        logger.info(elem)
        if elem[0] is not None:
            if use_js:
                import re
                logger.info(elem)
                locator_trim = re.sub(r'xpath=',r'',elem[1])
                try:
                    elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim.replace("\'","\""))
                    self.execute_javascript(elem_js)
                    elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()'%(locator_trim.replace("\'","\""))
                    self.execute_javascript(elem_js)
                    self._info('Successfully clicked by javascript..')
                except:
                    pass
                    self._info('JavascriptException on click..')
            try:
                import re
                locator_trim = re.sub(r'xpath=',r'',elem[1])
                elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim.replace("\'","\""))
                self.execute_javascript(elem_js)
                self.click_element(elem[0])
            except:
                import re
                logger.info(elem)
                locator_trim = re.sub(r'xpath=',r'',elem[1])
                try:
                    elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim.replace("\'","\""))
                    self.execute_javascript(elem_js)
                    elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()'%(locator_trim.replace("\'","\""))
                    self.execute_javascript(elem_js)
                    self._info('Successfully clicked by javascript..')
                except:
                    pass
                    self._info('JavascriptException on click..')
            self.ath_wait_until_loaded()
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(link_name))

    @handle_stale_element
    def ath_check_links_displayed(self, label, index=1, is_positive='true', str_format='%d.%m.%Y', country='English US'):
        if not label: return
        text_value = Overrides.get_input_val(label, str_format)
        translated = self._get_translation(text_value,country)
        elem = self.get_link_by_label(translated, index)
        if elem[0] is None:
            logger.info("Link with name - %s is not visible"%(elem[0]))

        boolean_is_positive = self._determine_should_be_checked(is_positive)
        logger.info("Boolean is positive: %s"%(boolean_is_positive))
        if elem[0] and boolean_is_positive:
            logger.info("Link with name - %s is visible"%(label))
        if elem[0] and not (boolean_is_positive):
            raise ValidationFailedError("Link with name - %s should not be visible"%(label))
        if not (elem[0]) and not (boolean_is_positive):
            logger.info("Link with name - %s is not visible as expected"%(label))
        if not (elem[0]) and boolean_is_positive:
            raise ValidationFailedError("Link with name - %s should be visible"%(label))
