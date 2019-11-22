from robot.api import logger
from selenium.webdriver.common.keys import Keys
from ATHLibrary.core.ath_element_finder import ATHElementFinder
from ATHLibrary.core.input_value_overrides import Overrides
from ATHLibrary.pageobjects import handle_stale_element
from ATHLibrary.core.ath_exceptions import ValidationFailedError
from selenium.common.exceptions import NoSuchElementException
from ATHLibrary.core.ath_exceptions import ElementNotFoundException

class ATHMenu(ATHElementFinder):

    #########
    # Menus #
    #########
    @handle_stale_element
    def ath_navigate_to_main_menu(self, menu, country='English US'):
        if not menu: return
        translated = self._get_translation(menu,country)
        self.click_element("//ul[contains(@class,'nav-main')]/li/a[normalize-space()='%s']"%(translated))
        self.ath_wait_until_loaded()

    def ath_check_main_menu_displayed(self, menu, is_positive='true', country='English US'):
        if not menu: return
        translated = self._get_translation(menu,country)
        elem = self.get_link_by_label(translated, 1.0)

        boolean_is_positive = self._determine_should_be_checked(is_positive)
        if elem and boolean_is_positive:
            logger.info("Menu with name - %s is visible"%(menu))
        if elem and not(boolean_is_positive):
            raise ValidationFailedError("Menu with name - %s should not be visible"%(menu))
        if not(elem) and not(boolean_is_positive):
            logger.info("Menu with name - %s is not visible as expected"%(menu))
        if not elem and boolean_is_positive:
            raise ValidationFailedError("Menu with name - %s should be visible"%(menu))

