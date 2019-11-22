import time
import robot
from robot.api import logger
from Selenium2Library.keywords._element import _ElementKeywords
from Selenium2Library.keywords._formelement import _FormElementKeywords
from Selenium2Library.keywords._selectelement import _SelectElementKeywords
from Selenium2Library.keywords._javascript import _JavaScriptKeywords
from selenium.common.exceptions import ElementNotVisibleException
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import StaleElementReferenceException
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import TimeoutException
from ath_windowmanager import ATHWindowManager
from ath_browsermgr import ATHBrowserMgr
from input_value_overrides import Overrides
from ATHLibrary.pageobjects.ath_waits import ATHWaits
from ath_exceptions import ValidationFailedError

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By

class ATHElementFinder(ATHBrowserMgr, _ElementKeywords,
    _FormElementKeywords, _SelectElementKeywords, ATHWaits):

    def __init__(self):
        self._element_finder = ElementFinder()


    def _element_find(self, locator, first_only, required, tag=None):
        ''' Override _element_find method of Selenium2Library to insert handle
        for Object Repository'''
        browser = self._current_browser()

        if locator is None:
            raise ValueError("Element locator '" + locator + "' did not match any elements.")
            return

        if isinstance(locator, WebElement):
            return locator
            
        locator = self.get_locator_from_OR(locator)
        elements = self._element_finder.find(browser,locator, tag)
        if required and len(elements) == 0:
            raise ValueError("Element locator '" + locator + "' did not match any elements.")
        if first_only:
            if len(elements) == 0: return None
            return elements[0]
        return elements

    def scroll_into_view(self, locator):
        try:
            import re
            locator_trim = re.sub(r'xpath=\((.*)\)\[.*\]',r'\1',locator)
            self._info('locator:%s'%(locator_trim))
            # elem_js = "window.document.evaluate('%s', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)"%(locator_trim)
            elem_js = "var element = document.evaluate(\"%s\" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue;if (element != null) {element.scrollIntoView(true);}"%(locator_trim)
            self.execute_javascript(elem_js)
            self._info('Successfully scrolled..')
        except:
            self._info("ScrollIntoView threw exception..")

    def _ath_wait_until_element_present(self, locator, timeout=20.0,isicon='false'):
        timeout = robot.utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        maxtime = time.time() + timeout
        brwsr_inst = self._current_browser()
        timeout = robot.utils.timestr_to_secs(timeout)
        import re
        locator_trim = self.get_locator_from_OR(locator)
        locator_trim = re.sub(r'(.*)',r'\1',locator_trim)
        locator_trim = re.sub(r'xpath=',r'',locator_trim)
        logger.info("Waiting for locator - %s"%(locator_trim))

        try:
            located = WebDriverWait(brwsr_inst,timeout).until(EC.presence_of_element_located((By.XPATH,locator_trim)))
            logger.info("Locator - %s is found"%(located))
#            self.scroll_into_view(locator)
            if isicon == 'true' and located is not None: return True,locator_trim,located
            if located is not None: return True,located
        except TimeoutException:
            logger.info("TimeoutException - Waiting for element %s"%(locator_trim))
            # time.sleep(5.0)
            return False,None
        return False,None

    def ath_wait_until_element_staleness(self, locator, timeout=20.0):
        timeout = robot.utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        maxtime = time.time() + timeout
        brwsr_inst = self._current_browser()
        timeout = robot.utils.timestr_to_secs(timeout)
        import re
        locator_trim = self.get_locator_from_OR(locator)
        locator_trim = re.sub(r'(.*)',r'\1',locator_trim)
        locator_trim = re.sub(r'xpath=',r'',locator_trim)
        logger.info("Waiting for locator - %s"%(locator_trim))

        try:
            logger.info("Waiting for locator - %s to be stale"%(locator_trim))
            located_elem = self._element_find(locator_trim, True, True)
            located = WebDriverWait(brwsr_inst,timeout).until(EC.staleness_of(located_elem))
            logger.info("Locator - %s now stale"%(locator_trim))
        except:
        #except TimeoutException:
            logger.info("Staleness threw exception!")
            time.sleep(5.0)
        return False,None



    def _wait_until_no_error_timeout(self, timeout, wait_func, *args):
        timeout = robot.utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        maxtime = time.time() + timeout
        while True:
            timeout_error = wait_func(*args)
            if not timeout_error: return
            if time.time() > maxtime:
                logger.warn("Still Loading after %s seconds" %(timeout))
                return False
            time.sleep(0.2)

    def ath_wait_until_loaded(self, timeout=100, error=None):
        try:
            brwsr_inst = self._current_browser()
            timeout = robot.utils.timestr_to_secs(timeout)
            WebDriverWait(brwsr_inst,timeout).until(EC.invisibility_of_element_located((By.XPATH,"//html[contains(@class,'progress-bar')][contains(@class,'show')]")))
        except TimeoutException:
            time.sleep(5.0)


    def get_locator_from_OR(self,OR_name):
        '''gets a locator stored in the Object repository'''
        if OR_name and OR_name.lower().startswith("or:"):
            name = OR_name[3:].lower()
        elif OR_name:
            return OR_name
        # logger.info(name)
        return self.OR[name]

    def _determine_should_be_checked(self, should_be_checked):
        should_be_checked = str(should_be_checked).lower()
        if should_be_checked in ["checked", "true", "on", "yes"] : return True
        elif should_be_checked in ["unchecked", "false", "off", "no"] : return False
        else:
            raise RuntimeError('''CheckBox and Radio button must be On/Off, True/False, 
                                Checked/Unchecked. Value given: %s''' % should_be_checked)


    ####################
    # Element Locator #
    ####################
    def get_button_by_label(self, labelname, index=1, timeout=10.0):
        ''' Add handle to locate element from label'''
        if labelname.lower().startswith(('or:','//','xpath','css')):
            element = self._ath_wait_until_element_present(labelname,timeout)
            return element[1],labelname


        visible = self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(labelname,labelname,labelname),30)
        locator_0 = 'xpath=(//button[normalize-space()="%s"])[%s]'%(labelname,str(index)) # verified
        locator_1 = 'xpath=(//a[contains(@class,"btn")][normalize-space()="%s"])[%s]'%(labelname,str(index)) # verified
        locator_2 = 'xpath=(//input[@type="submit"][@value="%s"])[%s]'%(labelname,str(index)) # verified
        locator_3 = 'xpath=(//a[normalize-space()="%s"])[%s]'%(labelname,str(index)) # verified
        locator_4 = 'xpath=(//input[@type="button"][@value="%s"])[%s]'%(labelname,str(index))
        locator_5 = 'xpath=(//*[(@title="%s")])[%s]'%(labelname,str(index))
        locator_6 = 'xpath=(//div[@id="confirm_modal"]/descendant::button[contains(text(),"%s")])[%s]'%(labelname,str(index))
        locator_7 = 'xpath=(//td/button[normalize-space()="%s"])[%s]'%(labelname,str(index))
        locator_list = []
        locator_list.extend((locator_0,locator_1,locator_2,locator_3,locator_4,locator_5,locator_6,locator_7))

        locator_str = '|'.join(locator_list)
        element = self._ath_wait_until_element_present(locator_str,timeout)
        return element[1],locator_str


    def get_label_by_label(self,labelname,index=1, timeout=10.0):
        ''' Add handle to locate element from label'''
        if labelname.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(labelname,timeout)
            return element[1],labelname

        visible = self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(labelname,labelname,labelname),30)
        if not visible:
            elem = None
            logger.info(visible)
            return None


        locator_0 = 'xpath=(//h3[text()="%s"])[%s]'%(labelname,str(index))
        locator_1 = 'xpath=(//*[contains(text(), "%s")])[%s]'%(labelname,str(index)) # verified
        locator_2 = 'xpath=(//p[contains(normalize-space(),"%s")])[%s]'%(labelname,str(index))
        locator_3 = 'xpath=(//label[contains(@class, "label")][text()="%s"])[%s]'%(labelname,str(index)) # verified
        locator_4 = 'xpath=(//*[contains(@placeholder, "%s")][@type="text"])[%s]'%(labelname,str(index))
        locator_5 = 'xpath=(//table[contains(@class, "table-hover")]/descendant::*[contains(text(), "%s")])[%s]'%(labelname,str(index))
        locator_list = []
        locator_list.extend((locator_0,locator_1,locator_2,locator_3,locator_4,locator_5))

        locator_str = '|'.join(locator_list)
        element = self._ath_wait_until_element_present(locator_str,timeout)
        return element[1],locator_str

    def get_textfield_by_label(self, labelname, index=1, accordion=None, timeout=10.0):
        ''' Add handle to locate element from label'''
        if labelname.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(labelname,timeout)
            return element[1],labelname

        if accordion:
            accordion_base =  '//a[normalize-space()="%s"]/following-sibling::*[1]/descendant::'%(accordion)
        else:
            accordion_base = "//*"

        self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(labelname,labelname,labelname),30)

        locator_0 = "xpath=(%s[text()='%s']/following-sibling::*[1]/input[@type='text'])[%s]"%(accordion_base,labelname,str(index))
        locator_1 = "xpath=(%s[@type='text' and @placeholder='%s'])[%s]"%(accordion_base,labelname,str(index))
        locator_2 = "xpath=(%S[input[contains(@placeholder,'%s')])[%s]"%(accordion_base,labelname,str(index))
        locator_3 = "xpath=(%s[text()='%s']/following-sibling::*[1])[%s]"%(accordion_base,labelname,str(index)) #verified
        locator_4 = "xpath=(%s[text()='%s']/following::ul/descendant::div)[%s]"%(accordion_base,labelname,str(index))

        locator_list = []
        locator_list.extend((locator_0,locator_1,locator_2,locator_3,locator_4))

        logger.info("Locator list: %s"%(locator_list))
        locator_str = '|'.join(locator_list)
        element = self._ath_wait_until_element_present(locator_str,timeout)
        return element[1],locator_str

    def get_textarea_by_label(self,labelname,index=1, timeout=10.0):
        ''' Add handle to locate element from label'''
        if labelname.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(labelname,timeout)
            return element[1]

        self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(labelname,labelname,labelname),30)
        locator_0 = "xpath=(//label[contains(text(),'%s')]/following-sibling::*[1]/textarea)[%s]"%(labelname,str(index))
        locator_1 = "xpath=(//label[contains(text(),'%s')]/following::textarea)[%s]"%(labelname,str(index))
        locator_2 = "xpath=(//label[contains(normalize-space(),'%s')]/descendant::textarea)[%s]"%(labelname,str(index))

        locator_list = []
        locator_list.extend((locator_0,locator_1,locator_2))

        for locator in locator_list:
            element = self._ath_wait_until_element_present(locator,timeout)
            if element[0]:
                self._info(" Element visible: '%s' with locator='%s' & webelement='%s'" % (element[0], locator,element[1]))
                self.wait_until_element_is_visible(locator,100)
                try:
                    import re
                    locator_trim = re.sub(r'xpath=\((.*)\)\[.*\]',r'\1',locator)
                    elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim)
                    self.execute_javascript(elem_js)
                    self._info('Successfully scrolled..')
                except:
                    self._info("ScrollIntoView threw exception..")
                    pass
                return element[1]
            else:
                self._info("Element with locator='%s' not found!!" % (locator))

    def get_dropdown_value_by_label_select(self, labelname, index=1, timeout=10.0):
        ''' Add handle to locate element from label'''
        if labelname.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(labelname,timeout)
            return element[1],labelname

        self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(labelname,labelname,labelname),30)

        locator_0 ='xpath=(//*[@class="form-group"]/descendant::option[normalize-space()="%s"]/ancestor::select)[%s]'%(labelname,str(index)) # Verified
        locator_1='xpath=(//*[contains(text(),"%s")]/select)[%s]'%(labelname,str(index))
        locator_2= 'xpath=(//*[contains(text(),"%s")]/ancestor::div[contains(@class,"form-group")]/descendant::select/option)[%s]'%(labelname,str(index))
        locator_3= "xpath=(//label[contains(normalize-space(),'%s')]/descendant::select/option)[%s]"%(labelname,str(index))
        locator_4= "xpath=(//*[contains(normalize-space(),'%s')]/following::select)[%s]"%(labelname,str(index))
        locator_list = []
        locator_list.extend((locator_0,locator_1,locator_2,locator_3,locator_4))

        logger.info("Locator list: %s"%(locator_list))
        locator_str = '|'.join(locator_list)
        element = self._ath_wait_until_element_present(locator_str,timeout)
        return element[1],locator_str

    def get_dropdown_by_value(self,labelname,index=1, timeout=10.0):
        ''' Add handle to locate element from label'''
        if labelname.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(labelname,timeout)
            return element[1]

        self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(labelname,labelname,labelname),30)

        locator_0 = 'xpath=(//*[contains(normalize-space(),"%s")]/descendant::select/option[@selected])[%s]'%(labelname,str(index)) # Verified
        locator_1='xpath=(//*[contains(text(),"%s")]/select)[%s]'%(labelname,str(index))
        locator_2= 'xpath=(//*[contains(text(),"%s")]/ancestor::div[contains(@class,"form-group")]/descendant::select)[%s]'%(labelname,str(index))
        locator_3= "xpath=(//label[contains(normalize-space(),'%s')]/descendant::select/option)[%s]"%(labelname,str(index))
        locator_list = []
        locator_list.extend((locator_0,locator_1,locator_2,locator_3))

        logger.info("Locator list: %s"%(locator_list))
        locator_str = '|'.join(locator_list)
        element = self._ath_wait_until_element_present(locator_str,timeout)
        return element[1],locator_str

    def get_textbox_by_label(self,labelname,index=1, timeout=10.0):
        ''' Add handle to locate element from label'''
        if labelname.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(labelname,timeout)
            return element[1],labelname

        #try:
        self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(labelname,labelname,labelname),30)
        #except:
            #placeholder = '//*[@placeholder="%s"]'%labelname
        #    self.wait_until_page_contains_element(placeholder,30)

        locator_0 = 'xpath=(//input[@placeholder="%s"])[%s]'%(labelname,str(index)) #Verified
        locator_1 = 'xpath=(//label[contains(text(),"%s")]/ancestor::*[contains(@class,"form-group")]/descendant::input)[%s]'%(labelname,str(index))
        locator_2 = 'xpath=(//*[contains(text(),"%s")]/ancestor::*[contains(@class,"form-group")]/descendant::li/input)[%s]'%(labelname,str(index))
        locator_3 = 'xpath=(//*[text()="%s"]/following-sibling::*[1]/input)[%s]'%(labelname,str(index))
        locator_4 = 'xpath=(//*[contains(text(),"%s")]/following-sibling::input)[%s]'%(labelname,str(index))
        locator_5 = 'xpath=(//*[contains(text(),"%s")]/ancestor::div[1]/descendant::input)[%s]'%(labelname,str(index))
        locator_6 = 'xpath=(//*[text()="%s"]/ancestor::*[@class="form-group"]/descendant::input)[%s]'%(labelname,str(index))
        locator_7 = 'xpath=(//label[contains(text(),"%s")]/following::input[1])[%s]'%(labelname,str(index))
        locator_8 = 'xpath=(//*[normalize-space()="%s"]/following::*[1]/input)[%s]'%(labelname,str(index))
        locator_list = []
        locator_list.extend((locator_0,locator_1,locator_2,locator_3,locator_4,locator_5,locator_6,locator_7,locator_8))

        logger.info("Locator list: %s"%(locator_list))
        locator_str = '|'.join(locator_list)
        element = self._ath_wait_until_element_present(locator_str,timeout)
        return element[1],locator_str
            
    def get_link_by_label(self,labelname,index=1, widget_name=None,timeout=30.0):
        ''' Add handle to locate element from label'''
        if labelname.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(labelname,timeout)
            return element[1],labelname

        visible = self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(labelname,labelname,labelname),30)
        # if not visible:
        #     elem = None
        #     logger.info("%s visible passed"%(elem))
        #     return elem

        locator_0 ='xpath=(//*[normalize-space()="%s"])[%s]'%(labelname,str(index)) # Verified
        locator_1 ='xpath=(//*[contains(@title,"%s")])[%s]'%(labelname,str(index))

        locator_list = []
        # locator_list.extend((locator_0,locator_1,locator_2,locator_3,locator_4,locator_5,locator_6))
        locator_list.extend((locator_0,locator_1))

        locator_str = '|'.join(locator_list)
        element = self._ath_wait_until_element_present(locator_str,timeout)
        return element[1],locator_str

    def get_radiobutton_by_value(self,value,index=1, timeout=10.0):
        ''' Find Radiobutton'''
        if value.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(value,timeout)
            return element[1],value

        self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(value,value,value),30)
        locator_0 ="xpath=(//*[text()='%s']/preceding::*[1][@type='radio'])[%s]"%(value,str(index))
        locator_1 ="xpath=(//*[text()='%s']/following-sibling::*[1][@type='radio'])[%s]"%(value,str(index))
        locator_2 ="xpath=(//label[contains(normalize-space(),'%s')]/div)[%s]"%(value,str(index))
        locator_3 ="xpath=(//label[contains(normalize-space(),'%s')]/input)[%s]"%(value,str(index))

        locator_list = []
        locator_list.extend((locator_0,locator_1,locator_2,locator_3))

        locator_str = '|'.join(locator_list)
        element = self._ath_wait_until_element_present(locator_str,timeout)
        return element[1],locator_str

    def get_checkbox_by_value(self,value,index=1, timeout=10.0):
        ''' Find Checkbox '''
        if value.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(value,timeout)
            return element[1],value

        self._ath_wait_until_element_present("//*[contains(., \"%s\")] | //*[contains(@title,\"%s\")] | //*[@placeholder=\"%s\"]"%(value,value,value),30)
#        locator_0 ='xpath=(//*[normalize-space()=""%s"]/preceding::tr[1]/descendant::input)["%s]'%(value,str(index))
#        locator_1 ='xpath=(//tr/td[normalize-space()="%s"])[%s]/../td[1]/div'%(value,str(index))
        locator_0 ='xpath=((//label[normalize-space()="%s"])[%s]/preceding::th/descendant::div)[%s]'%(value,str(index),str(index))
        locator_1 = 'xpath=(//*[contains(text(),"%s")]/preceding::div[@class="icheckbox_minimal"])[%s]'%(value,str(index))
        locator_2 = "xpath=(//*[contains(text(),'%s')]/div)[%s]"%(value,str(index))
        locator_3 = "xpath=(//*[contains(text(),'%s')]/../descendant::ins)[%s]"%(value,str(index))


        locator_list = []
        locator_list.extend((locator_0,locator_1, locator_2,locator_3))

        for locator in locator_list:
            element = self._ath_wait_until_element_present(locator,timeout)
            if element[0]:
                self._info(" Element visible: '%s' with locator='%s' & webelement='%s'" % (element[0], locator,element[1]))
                self.wait_until_element_is_visible(locator,100)
                try:
                    import re
                    locator_trim = re.sub(r'xpath=\((.*)\)\[.*\]',r'\1',locator)
                    elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim)
#                    self.execute_javascript(elem_js)
                    self._info('Successfully scrolled..')
                except:
                    self._info("ScrollIntoView threw exception..")
                    pass
                self._info('this will be passed..')
                locator_str = '|'.join(locator_list)
                return element[1],locator_str
            else:
                self._info("Element with locator='%s' not found!!" % (locator))

        return element[1],locator_str

    def ath_verify_element_is_visible(self, locator, is_positive='true'):
        # Use this keyword to verify if element is present only accepts locators, ORs
        if not locator: return

        if locator.lower().startswith(('or:','//','xpath')):
            element = self._ath_wait_until_element_present(locator,0.50)
        else :
            raise ValidationFailedError("ERROR: This keyword only accepts locators, ORs!!")

        boolean_is_positive = self._determine_should_be_checked(is_positive)
        if element[0] and boolean_is_positive:
            logger.info("Element - %s is visible"%(locator))
        if element[0] and not(boolean_is_positive):
            raise ValidationFailedError("Element - %s should not be visible"%(locator))
        if not(element[0]) and not(boolean_is_positive):
            logger.info("Element - %s is not visible as expected"%(locator))
        if not element[0] and boolean_is_positive:
            raise ValidationFailedError("Element - %s should be visible"%(locator))


    def execute_javascript(self, jscript):
        js = self._get_javascript_to_execute(''.join(jscript))
        self._info("Executing JavaScript:\n%s" % js)
        return self._current_browser().execute_script(js)

    def ath_wait_ajax(self, timeout=100.0, error=None):
        for counter in range(0, int(timeout)):
            page_state = self.execute_javascript('return document.readyState;')
            logger.info(page_state)
            if page_state == 'complete':
                break
            self.wait_for_manual_step(1.0)

    def ath_wait_jquery(self, timeout=100.00, error=None):
        for counter in range(0, int(timeout)):
            try:
                jquery_state = self.execute_javascript('return jQuery.active')
                if jquery_state == 0:
                    break
                self.wait_for_manual_step(1.0)
            except:
                self.wait_for_manual_step(5.0)
                break
