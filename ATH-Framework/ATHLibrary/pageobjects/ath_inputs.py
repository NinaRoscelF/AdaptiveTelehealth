import time
from robot.api import logger
from selenium.webdriver.common.keys import Keys
from Selenium2Library.keywords._formelement import _FormElementKeywords
from ATHLibrary.core.ath_element_finder import ATHElementFinder
from ATHLibrary.core.input_value_overrides import Overrides
from ATHLibrary.pageobjects import handle_stale_element
from ATHLibrary.core.ath_exceptions import ValidationFailedError
from selenium.common.exceptions import NoSuchElementException

class ATHInputs(ATHElementFinder):

    ###########
    # TEXTBOX #
    ###########
    @handle_stale_element
    def ath_input_text_value(self, label, value, index=1, typing_delay=0.05, verify='no', str_format='%d.%m.%Y', tab='Yes', country='English US'):
        '''get a text box by dummy class and name and then set it's value'''
        if not value: return
        text_value = Overrides.get_input_val(value, str_format)
        translated = self._get_translation(label,country)

        elem = self.get_textbox_by_label(translated, index, 0.250)
        if elem[0] is not None:
            self.input_text(elem[0], text_value, typing_delay, verify, tab)
            # self.ath_wait_until_loaded()
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(label))


    @handle_stale_element
    def ath_verify_textbox_value(self, label, value, index=1, attr='value', is_positive='true', str_format='%d.%m.%Y', country='English US'):
        if not value: return
        text_value = Overrides.get_input_val(value, str_format)
        translated = self._get_translation(label,country)

        elem = self.get_textbox_by_label(translated, index, 0.250)
        if elem[0] is not None:
            self._verify_text_content(elem[0],text_value,attr,is_positive)
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(label))


    ##############################################
    # DROPDOWN VALUE - SELECTION or AUTOCOMPLETE #
    ##############################################
    # @handle_stale_element
    # def ath_select_drop_down_field_value_by_autocomplete(self,label, value, index=1, typing_delay=0.50, verify='no', str_format='%d.%m.%Y'):
    #     '''get a text box by dummy class and name and then set it's value'''
    #     if not value: return
    #     text_value = Overrides.get_input_val(value, str_format)
    #     elem = self.get_dropdown_by_label(label, index, widget, 1.0)
    #     self.input_text(elem, text_value, typing_delay, verify, 'no')

    #     if label.lower().startswith(('or:','//','xpath')):
    #         elem = "xpath=(//*[@title='%s'])[%s]"%(value,str(index))
    #     else:
    #         elem = "xpath=(%s*[text()='%s']/following-sibling::*[1]/descendant::*[@title='%s'])[%s]"%(widget_base,label,value,str(index))
    #     self.click_element(elem)
    #     self.ath_wait_until_loaded()

    #@handle_stale_element
    def ath_select_drop_down_field_value(self,label, value, index=1, typing_delay=0.50, verify='no', str_format='%d.%m.%Y',country='English US'):
        '''get a text box by dummy class and name and then set it's value'''
        if not value: return
        translated = self._get_translation(label,country)
        elem = self.get_dropdown_value_by_label_select(translated,index,0.5)

        if elem[0] is not None:
            self.wait_until_element_is_visible(elem[0],100)
            self.select_from_list(elem[0],value)
            #time.sleep(.5)
            self.ath_wait_until_loaded()
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(label))


    @handle_stale_element
    def ath_verify_drop_down_field_value(self, label, value, index=1, attr='textContent', is_positive='true', str_format='%d.%m.%Y',country='English US'):
        if not value: return
        text_value = Overrides.get_input_val(value, str_format)
        translated = self._get_translation(label,country)
        elem = self.get_dropdown_by_value(translated, index, 1.0)
        if elem[0] is not None:
            self._verify_text_content(elem[0],text_value,attr,is_positive)
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(label))

    ############
    # TEXTAREA #
    ############
    @handle_stale_element
    def ath_set_text_area_value(self,label, value, index=1, typing_delay=0.05, verify='yes', str_format='%d.%m.%Y'):
        '''get a text box by dummy class and name and then set it's value'''
        if not value: return
        text_value = Overrides.get_input_val(value, str_format)
        elem = self.get_textarea_by_label(label, index, 0.250)
        if elem is not None:
            self.input_text(elem, text_value, typing_delay, verify)
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(label))

    @handle_stale_element
    def ath_verify_text_area_value(self, label, value, index=1, attr='textContent',is_positive='true', str_format='%d.%m.%Y'):
        if not value: return
        text_value = Overrides.get_input_val(value, str_format)
        elem = self.get_textarea_by_label(label, index, 0.250)
        if elem is not None:
            self._verify_text_content(elem,text_value,attr,is_positive)
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(label))

    ####################
    # STATIC TEXTFIELD #
    ####################
    @handle_stale_element
    def ath_verify_displayed_text(self, label, value, index=1, accordion=None, attr='textContent', is_positive='true', str_format='%d.%m.%Y', country='English US'):
        if not value: return
        text_value = Overrides.get_input_val(value, str_format)
        translated = self._get_translation(label,country)
        elem = self.get_textfield_by_label(translated, index, accordion, 0.05)
        if elem[0] is not None:
            self._verify_text_content(elem[0],text_value,attr,is_positive)
        else:
            raise NoSuchElementException("No element with name/locator - %s found"%(label))

    ##########
    # LABELS #
    ##########
    @handle_stale_element
    def ath_check_label(self, label, index=1, attr='textContent', is_positive='true', str_format='%d.%m.%Y', country='English US'):
        if not label: return
        logger.info (label)
        text_value = Overrides.get_input_val(label, str_format)
        translated = self._get_translation(text_value,country)
        elem = self.get_label_by_label(translated, index)
        logger.info (elem)
        boolean_is_positive = self._determine_should_be_checked(is_positive)
        if elem[0] and boolean_is_positive:
            logger.info("Label with name - %s is visible"%(label))
        if elem[0] and not(boolean_is_positive):
            raise ValidationFailedError("Label with name - %s should not be visible"%(label))
        if not(elem[0]) and not(boolean_is_positive):
            logger.info("Label with name - %s is not visible as expected"%(label))
        if not(elem[0]) and boolean_is_positive:
            raise ValidationFailedError("Label with name - %s should be visible"%(label))

    ####################
    # Private Function #
    ####################
    def _input_text_into_text_field(self, element, text, delay=0.5):
        """ Override Selenium2Library definition to support typing_delay.
        """
        element.clear()
        self.ath_wait_until_loaded
        from time import sleep
        for letter in text:
            element.send_keys(letter)
            sleep(float(delay))

    def input_password(self, locator, text, typing_delay=0.05):
        """ Override Selenium2Library's Input Text command to support delays
        defaults to 50ms, tolerable delay for getting feedback from an app <100 ms
        """
        #self._info("Typing text '%s' into text field '%s' with typing_delay='%s'" % (text, locator,typing_delay))
        element = self._element_find(locator, True, True)
        logger.info("Typing password into text field '%s'"%(locator))
        self._input_text_into_text_field(element, text, typing_delay)


    def input_text(self, locator, text, typing_delay=0.05, verify="no", tab="Yes"):
        """ Override Selenium2Library's Input Text command to support delays
        defaults to 50ms, tolerable delay for getting feedback from an app <100 ms
        """
        self._info("Typing text '%s' into text field '%s' with typing_delay='%s'" % (text, locator,typing_delay))
        element = self._element_find(locator, True, True)
        self._input_text_into_text_field(element, text, typing_delay)
        if  verify.lower() == "yes":
            actual_value = element.get_attribute('value')
            logger.info("Verifying Data Entry...")
            if (actual_value != text):
                raise ValidationFailedError("Element - %s expect to have %s but actual value is %s"%(locator,text,actual_value))
            else:
                logger.info("Expected = %s, Actual = %s"%(text,actual_value))
            #self.textfield_value_should_be(locator,text)
        if tab.lower() == 'yes':
            element.send_keys(Keys.TAB)


    @handle_stale_element
    def _verify_text_content(self,locator,text,attr='textContent',is_positive='true'):
        logger.info("locator={0}".format(locator))
        textbox_element = self._element_find(locator, True, True)
        actual_value = textbox_element.get_attribute(attr)
        logger.info("Verifying Text Content...")
        if is_positive.lower() == 'false':
            if (actual_value.strip().replace('\n', '') != text):
                logger.info("Expected = %s, Actual = %s"%(text,actual_value))
            else:
                raise ValidationFailedError("Element - %s expect to have %s but actual value is %s"%(locator,text,actual_value))
        if is_positive.lower() == 'true':
            if text in actual_value:
                logger.info("Expected = %s, Actual = %s"%(text,actual_value.strip().replace('\n', '')))
            else:
                raise ValidationFailedError("Element - %s expect to have %s but actual value is %s"%(locator,text,actual_value.strip().replace('\n', '')))
            # if (actual_value.strip().replace('\n', '') != text):
            #     raise ValidationFailedError("Element - %s expect to have %s but actual value is %s"%(locator,text,actual_value))
            # else:
            #     logger.info("Expected = %s, Actual = %s"%(text,actual_value))

