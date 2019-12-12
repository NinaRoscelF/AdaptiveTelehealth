import os
import time
from csv import DictReader
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
from Selenium2Library import Selenium2Library

# ATH Core Object repository
from ATHLibrary.core.object_repository import ObjectRepository
from ATHLibrary.core.commonfunctions import CommonFunctions

# Ath Page Objects
from ATHLibrary.pageobjects.ath_inputs import ATHInputs
from ATHLibrary.pageobjects.ath_buttons import ATHButtons
from ATHLibrary.pageobjects.ath_links import ATHLinks
from ATHLibrary.pageobjects.ath_radiocheck import ATHRadioCheck
from ATHLibrary.pageobjects.ath_datetime import ATHDateTime
from ATHLibrary.pageobjects.ath_menu import ATHMenu


# ATH Flows
from ATHLibrary.flows.ath_flows import ATHFlows

ROOT_DIR =  os.path.dirname(__file__)
RESOURCES_DIR = os.path.join(ROOT_DIR,'../../','ATH-Resources')


class ATHLibrary(Selenium2Library, ATHInputs, ATHButtons, ATHLinks, ATHRadioCheck, ATHDateTime, ATHMenu, ATHFlows, CommonFunctions):


    proxies = {'DCA': '172.17.84.35:8080',
               'DCB': '172.17.87.35:8080',
               'SEC': '127.0.0.1:8090'
               }

    def __init__(self, timeout=5.0, implicit_timeout=0.0, run_on_failure='Capture Page Screenshot'):
        '''for the init function timeout will be used to set both javascript timeout and
        the implicit_wait functunality.
        run_on_failure is the robot framework keyword that is run when a keyword fails, by default it is
        set to capturing a page screenshot'''
        super( ATHLibrary, self).__init__()
        self.OR = ObjectRepository().default_OR
        self.OR = self.merge_ORs(self.OR)
        Selenium2Library.__init__(self,timeout=timeout, implicit_wait=implicit_timeout,
              run_on_failure=run_on_failure)

    def _make_ff(self, remote, desired_capabilites, profile_dir):

        from selenium import webdriver
        #Use synthetic events
        if os.name != "nt":
            webdriver.Firefox.NATIVE_EVENTS_ALLOWED = False
            ROOT_DIR = os.path.abspath(os.path.dirname(__file__))
            FIREFOX_PROFILE_DIR = os.path.join(ROOT_DIR, 'lib', 'firefoxprofile')
            logger.info("Profile Dir located in '%s'" % (FIREFOX_PROFILE_DIR))
        else:
            webdriver.Firefox.NATIVE_EVENTS_ALLOWED = True
            ROOT_DIR = os.path.abspath(os.path.dirname(__file__))
            FIREFOX_PROFILE_DIR = os.path.join(ROOT_DIR, 'lib', 'firefoxprofile_Windows')
            logger.info("Windows Profile Dir is located in '%s'" % (FIREFOX_PROFILE_DIR))

        use_proxy = self._cmdline_val("proxy", None)



        if not profile_dir: profile_dir = FIREFOX_PROFILE_DIR
        profile = webdriver.FirefoxProfile(FIREFOX_PROFILE_DIR)
        logger.info("My Profile is located in '%s'" % (profile))
        if remote:
            browser = self._create_remote_web_driver(webdriver.DesiredCapabilities.FIREFOX  ,
                        remote , desired_capabilites , profile)
        else:
            proxy = None
            if (use_proxy is not None):
                proxy = self._get_proxy_ff(use_proxy.upper(), webdriver)
                logger.info("My Profile2 is located in '%s'" % (profile))
            from selenium import webdriver
            cap = webdriver.DesiredCapabilities.FIREFOX.copy()
            ### source: https://stackoverflow.com/questions/16879566/how-to-disable-firefoxs-untrusted-connection-warning-using-selenium ###
            cap['acceptInsecureCerts'] = True
            use_marionette = self._cmdline_val("marionette", "false")
            use_marionette_bool = self.make_bool(use_marionette)
            if use_marionette_bool:
                cap['marionette'] = True
                cap['proxy'] = proxy
            else:
                cap['marionette'] = False

        use_headless = self._cmdline_val("headless", "false")
        use_headless_bool = self.make_bool(use_headless)
        if use_headless_bool:
            from selenium import webdriver
            from selenium.webdriver.firefox.options import Options
            options = Options()
            options.add_argument("--headless")
            browser = webdriver.Firefox(firefox_profile=profile, proxy=proxy, capabilities=cap, options=options)
        else:
            browser = webdriver.Firefox(firefox_profile=profile, proxy=proxy, capabilities=cap)

        return browser


    def _make_ie(self , remote , desired_capabilities , profile_dir):
        from selenium import webdriver
        cap = webdriver.DesiredCapabilities.INTERNETEXPLORER.copy()
        cap['nativeEvents'] = False
        cap['requireWindowFocus'] = True
        cap['ie.usePerProcessProxy'] = True

        use_proxy = self._cmdline_val("proxy", None)
        proxy = None
        if (use_proxy is not None):
            proxy = self._get_proxy_ie(use_proxy.upper(), webdriver)
            cap['proxy'] = proxy

        browser = webdriver.Ie(capabilities=cap)
        return browser

    def _make_chrome(self , remote , desired_capabilities , profile_dir):
        from selenium import webdriver
        cap = webdriver.DesiredCapabilities.CHROME.copy()
        cap['nativeEvents'] = False
        cap['requireWindowFocus'] = False

        use_proxy = self._cmdline_val("proxy", None)
        proxy = None
        if (use_proxy is not None):
            proxy = self._get_proxy_chrome(use_proxy.upper(), webdriver)
            cap['proxy'] = proxy

        options = webdriver.ChromeOptions()
#        options.add_argument('--headless')
        downloadFilepath = "C:\\Adaptive_Telehealth\\ATH-Resources\\Downloads"
        chromePrefs = {}
        chromePrefs["profile.default_content_settings.popups"] = 0
        chromePrefs["download.default_directory"] = downloadFilepath
        options.add_experimental_option("prefs", chromePrefs)
        # browser = webdriver.Chrome(chrome_options=options, executable_path=CHROMEDRIVER_PATH)

        browser = webdriver.Chrome(desired_capabilities=cap, chrome_options=options)
        return browser

    def _get_proxy_ff(self, proxy_env, webdriver):
        logger.info("proxy setting: %s" % proxy_env, also_console=True)

        if not self.proxies[proxy_env]:
            logger.warn('<span class="fail">Proxy "%s" does not exist!</b>' % proxy_env, html=True)
            raise ValueError("proxy doesn't exist")
        else:
            from selenium.webdriver.common.proxy import Proxy, ProxyType
            myProxy = self.proxies[proxy_env]
            logger.info("proxy for '%s' is '%s'" % (proxy_env, myProxy))

            use_marionette = self._cmdline_val("marionette", "false")
            use_marionette_bool = self.make_bool(use_marionette)

            if use_marionette_bool:
                proxy = {
                    'proxyType': "manual",
                    'httpProxy': myProxy,
                    'ftpProxy': myProxy,
                    'sslProxy': myProxy
                    }
            else:
                proxy = Proxy({
                    'proxyType': ProxyType.MANUAL,
                    'autodetect': False,
                    'httpProxy': myProxy,
                    'ftpProxy': myProxy,
                    'sslProxy': myProxy,
                    'noProxy': ''
                    })
            return proxy

    def _get_proxy_chrome(self, proxy_env, webdriver):
        logger.info("proxy setting: %s" % proxy_env, also_console=True)

        if not self.proxies[proxy_env]:
            logger.warn('<span class="fail">Proxy "%s" does not exist!</b>' % proxy_env, html=True)
            raise ValueError("proxy doesn't exist")
        else:
            from selenium.webdriver.common.proxy import Proxy, ProxyType
            myProxy = self.proxies[proxy_env]
            logger.info("proxy for '%s' is '%s'" % (proxy_env, myProxy))

            proxy = {
                'proxyType': "MANUAL",
                'autodetect': False,
                'httpProxy': myProxy,
                'ftpProxy': myProxy,
                'sslProxy': myProxy,
                'noProxy': None
                }
            return proxy

    def _get_proxy_ie(self, proxy_env, webdriver):
        logger.info("proxy setting: %s" % proxy_env, also_console=True)

        if not self.proxies[proxy_env]:
            logger.warn('<span class="fail">Proxy "%s" does not exist!</b>' % proxy_env, html=True)
            raise ValueError("proxy doesn't exist")
        else:
            from selenium.webdriver.common.proxy import Proxy, ProxyType
            myProxy = self.proxies[proxy_env]
            logger.info("proxy for '%s' is '%s'" % (proxy_env, myProxy))

            proxy = {
                'proxyType': "MANUAL",
                'autodetect': False,
                'httpProxy': myProxy,
                'ftpProxy': myProxy,
                'sslProxy': myProxy,
                'noProxy': None
                }
            return proxy


    def _cmdline_val(self, cmdline_name, default):
        '''returns the value from the command line if it exists otherwise
        returns the default value
        '''
        try:
            val = BuiltIn().get_variable_value("${%s}" % cmdline_name)
            return val if val else default
        except AttributeError:  #raised during unit testing
            return default

    def merge_ORs(self, originalOR):
        '''returns originalOR merged with client OR'''
        import sys
        Resource_cmdline = self._cmdline_val("PRJ_RES_DIR",RESOURCES_DIR)
        Default_OR_ath = os.path.join(Resource_cmdline,'ObjectRepository')
        client_OR_cmdline = self._cmdline_val("OR_DIR",Default_OR_ath)
        #client_dir =  os.path.join(client_OR_cmdline,'ObjectRepository')
        if client_OR_cmdline:
                try:
                    print "client dir is %s" % (client_OR_cmdline)
                    logger.info("client dir is %s"%(client_OR_cmdline))
                    #add path to client OR to sys.path so we can import it
                    sys.path.append(client_OR_cmdline)
                    from client_object_repository import OR as client_OR
                    #merge client OR with ews OR, overriding duplicates
                    originalOR.update(client_OR)
                    sys.path.remove(client_OR_cmdline)
                    return originalOR
                except ImportError:
                    logger.warn("unable to import client_object_repository.py from %s." %
                    client_OR_cmdline)
        else:
            logger.warn("No client OR for client_name %s using default")
        return originalOR

    def _get_password(self, user_name, client_sys):
        """Read through the 'logins.txt' directly under the proj repo and check
        each username against the listed one, returning the password according
        to the client_sys provided in the password argument from RF.
        If client_sys is None or '' then return the one under 'Password'
        """
        if not client_sys: client_sys = 'Password'
        Resource_cmdline = self._cmdline_val("PRJ_RES_DIR",RESOURCES_DIR)
        Default_login = os.path.join(Resource_cmdline,'LoginData')
        Client_Login_dir = self._cmdline_val("LOGIN_DATA_DIR",Default_login)
        self.login_file = os.path.join(Client_Login_dir,'logins.txt')
        logger.info('login file: %s' % self.login_file, also_console=True)
        lf = DictReader(open(self.login_file, 'rb'), delimiter='\t')
        for row in lf:
            if row['Username'] == user_name:
                #logger.info(row)
                password = row.get(client_sys, None)
                break
        else:
            raise ValueError("username not found: '%s'" % user_name)

        if password is None:
            raise ValueError("password not found for username '%s' on system '%s'"
                             % (user_name, client_sys))
        return password

    def _get_translation(self, fieldname, country):
        if not country: country = 'US'
        Resource_cmdline = self._cmdline_val("PRJ_RES_DIR",RESOURCES_DIR)
        self.login_file = os.path.join(Resource_cmdline,'Translations','translate.txt')
        #logger.info('login file: %s' % self.login_file, also_console=True)
        lf = DictReader(open(self.login_file, 'rb'), delimiter='\t')
        for row in lf:
            if row['FieldName'] == fieldname:
                logger.info(row)
                translated = row.get(country, None)
                logger.info("Translated '%s' to Language '%s'. "%(fieldname,country))
                return translated
                #break
        else:
            logger.info('No translation found for %s'%(fieldname))

        return fieldname


