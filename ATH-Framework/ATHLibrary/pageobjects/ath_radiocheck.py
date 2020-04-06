import time
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
from Selenium2Library.keywords import _browsermanagement
from ATHLibrary.core.input_value_overrides import Overrides
from selenium.webdriver.common.keys import Keys
from Selenium2Library.keywords._element import _ElementKeywords
from ATHLibrary.core.ath_element_finder import ATHElementFinder
from ATHLibrary.pageobjects.ath_waits import ATHWaits
from ATHLibrary.pageobjects import handle_stale_element
from ATHLibrary.core.ath_exceptions import ValidationFailedError
from selenium.common.exceptions import NoSuchElementException

class ATHRadioCheck(ATHElementFinder,ATHWaits):


    ############
    # CHECKBOX #
    ############
    @handle_stale_element
    def ath_set_checkbox(self, value, should_be_checked='true', index=1):
        '''Select checkbox by value'''
        if not value: return
        Boolean_should_be_checked = self._determine_should_be_checked(should_be_checked)
        elem = self.get_checkbox_by_value(value, index, 1.0)
        if elem[0] is not None:
            if Boolean_should_be_checked:
                self._info('Pls check me..')
                self._select_checkbox(elem[0])
            else:
                self._info('Pls uncheck me..')
                self._unselect_checkbox_value(elem[0])
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(value))

    def _select_checkbox(self,elem):
        if not elem.is_selected():
            self.click_element(elem)
            self.ath_wait_until_loaded()

    def _unselect_checkbox_value(self,elem):
        if elem.is_selected():
            self.click_element(elem)
            self.ath_wait_until_loaded()

    def ath_verify_checkbox_value(self, value, should_be_checked='true', index=1):
        '''Verify Checkbox value'''
        if not value: return
        #text_value = Overrides.get_input_val(value, "%d-%m-%Y")
        elem = self.get_checkbox_by_value(value, index, 1.0)
        Boolean_should_be_checked = self._determine_should_be_checked(should_be_checked)
        if elem[0].is_selected() != Boolean_should_be_checked:
            raise ValidationFailedError ("verify checkbox FAILED. Expected value %s and the actual value is %s" % 
                (should_be_checked, elem[0].is_selected()))

    ###############
    # RADIOBUTTON #
    ###############
    @handle_stale_element
    def ath_select_radio_button(self, value, index=1):
        '''Select Radiobutton by value'''
        if not value: return
        #text_value = Overrides.get_input_val(value, "%d-%m-%Y")
        elem = self.get_radiobutton_by_value(value, index, 1.0)
        if elem[0] is not None:
            if not elem[0].is_selected():
                self.click_element(elem[0])
                self.ath_wait_until_loaded()
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(value))

    def ath_verify_radio_button_value(self, value, should_be_checked='true', index=1):
        '''Verify Checkbox value'''
        if not value: return
        #text_value = Overrides.get_input_val(value, "%d-%m-%Y")
        elem = self.get_radiobutton_by_value(value, index, 1.0)
        if elem[0] is not None:
            Boolean_should_be_checked = self._determine_should_be_checked(should_be_checked)
            if elem[0].is_selected() != Boolean_should_be_checked:
                raise ValidationFailedError ("verify radiobutton FAILED. Expected value %s and the actual value is %s" % 
                    (should_be_checked, elem[0].is_selected()))
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(value))




