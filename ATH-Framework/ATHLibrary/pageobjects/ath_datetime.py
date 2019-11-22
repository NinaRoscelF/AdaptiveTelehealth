import os
import time
import datetime
import random
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.keys import Keys
from ATHLibrary.core.ath_element_finder import ATHElementFinder
#from Selenium2Library.keywords._formelement import _FormElementKeywords
from selenium.common.exceptions import StaleElementReferenceException
from selenium.common.exceptions import ElementNotVisibleException
from ATHLibrary.pageobjects import handle_stale_element
from ATHLibrary.core.ath_time import ATHTime
from ATHLibrary.core.ath_exceptions import ValidationFailedError
from ATHLibrary.core.input_value_overrides import Overrides

class ATHDateTime(ATHElementFinder):

    def ath_GetDateTime(self,text,str_format="%d-%m-%Y" ):
        text = Overrides.get_input_val(text,str_format)
        return text

    def ath_ConvertTimeZone(self, in_datetime, offset='1',dateformat="'%d-%b-%Y %H:%M'"):
        # input - 10-Nov-2016 16:55
        in_date,in_time = in_datetime.split()
        day,month,year = in_date.split("-")
        hours,minutes = in_time.split(":")
        months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        month_int = months.index(month) + 1

        offset_int = int(offset)
        offset_format = str(dateformat)

        t = datetime.datetime(int(year),int(month_int),int(day),int(hours),int(minutes))

        t_ref = t + datetime.timedelta(hours=offset_int)
        t_formatted = t_ref.strftime(format=offset_format)
        return t_formatted

    def ath_DateFormatter(self, day, month, year, dateformat="'%m-%d-%Y'"):
        t = datetime.datetime(int(year),int(month),int(day))
        t_formatted = t.strftime(format=dateformat)
        return t_formatted

    def ath_select_date_from_datepicker(self,indate,calicon,text_field=None):
        ''' Select Date from Calendar Widget
        indate - should be in format DD-MM-YYYY e.g. 28-Jun-2017
        calicon - locator of calendar icon
        textfield - locator of the text field
        '''
        if not indate: return
        if text_field:
            self.clear_element_text(text_field)

        indate = Overrides.get_input_val(indate,"%d-%b-%Y")

        date = indate.split("-")
        month = date[1]
        day = date[0]
        year = date[2]

        # Get Current Date
        current_date = datetime.datetime.today().strftime("%B %Y")
        curdate = current_date.split(" ")
        curmonth = curdate[0]
        curyear = curdate[1]

        #Steps
        # Click icon to launch Calendar
        import re
        locator_trim = re.sub(r'xpath=(.*)',r'\1',calicon)
        elem_scrollToView = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true)'%(locator_trim.replace("\'","\""))
        self.execute_javascript(elem_scrollToView)
        elem_js = 'window.document.evaluate(\'%s\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()'%(locator_trim.replace("\'","\""))
        self.execute_javascript(elem_js)
        self._info('Successfully clicked by javascript..')
#        self.click_element(calicon)
        self.ath_wait_until_loaded()
        # Click Calendar Header to Select Month & Year
        calendarheader = "(//span[@class='ui-datepicker-year'])[1]"
        sel_month = "xpath=//*[contains(@class,'datetimepicker')][contains(@style, 'display: block')]/descendant::*[contains(@class,'month')]/descendant::span[text()='%s']" %(month)
        sel_year = "xpath=//*[contains(@class,'datetimepicker')][contains(@style, 'display: block')]/descendant::*[contains(@class,'year')][text()='%s']" %(year)
        self.click_element(calendarheader)
        self.ath_wait_until_loaded()
        #Select Year
        if curyear != year:
            yearicon = "xpath=(//*[contains(@class,'datetimepicker')][contains(@style, 'display: block')]/descendant::*[@class='switch' and text()='%s'])[1]" %(curyear)
            self.click_element(yearicon)
            self.ath_wait_until_loaded()
            self.click_element(sel_year)
            self.click_element(sel_month)
            logger.info(year)
            logger.info(curyear)
        else:
            self.click_element(sel_month)
            self.ath_wait_until_loaded()
        #Select Day
            if day.startswith('0'):
                isday = day[1]
                logger.info(isday)
                sel_day = "xpath=(//*[contains(@class, 'datetimepicker')][contains(@style, 'display: block')]/descendant::*[not(contains(@class,'day old'))][text()='%s'])[1]" %(isday)
            else:
                sel_day = "xpath=(//*[contains(@class, 'datetimepicker')][contains(@style, 'display: block')]/descendant::*[not(contains(@class,'day old'))][text()='%s'])[1]" %(day)
            self.click_element(sel_day)
        self.ath_wait_until_loaded()
