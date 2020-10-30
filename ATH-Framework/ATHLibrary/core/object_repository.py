#pylint: disable=C0301

class ObjectRepository(object):

    def __init__(self):
        self.default_OR = {
            # Framework objects
            "ath_login_username" :"//input[@placeholder='Email Address']",
            "ath_login_password" : "//input[@placeholder='Password']",
            "ath_login_button" : "xpath=//button[normalize-space()='Login']",
            ##//button[@class='btn btn-primary standard_view']
            "logout_icon" : "xpath=//span[text()='Logout']/ancestor::a",
            
        }


