from Selenium2Library.keywords import _BrowserManagementKeywords
from ath_windowmanager import ATHWindowManager

class ATHBrowserMgr(_BrowserManagementKeywords, ATHWindowManager):
    def ath_switch_to_New_Window(self,timeout=5.0):
        self.ath_select_new_window(self._current_browser(),timeout)