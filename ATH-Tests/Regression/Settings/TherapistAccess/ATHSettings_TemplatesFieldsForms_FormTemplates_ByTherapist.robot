** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ATHSettings_TFF.FormTemplates_DisplayTemplatePage
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Templates, Fields and Forms
	Settings.AccountSettings.Select SubMenu 	Form Templates
	Settings.TFF.Click Create New Template Button
#	ath verify element is visible	xpath=//div[contains(@class,'ui-widget-content')]/descendant::span[text()="Warning"]
	Select Frame 	//iframe[@id='contactFormGenerator']
	# ath click button	//button[contains(@class,'ui-button ui-widget')]/span[text()="OK"]

	Clear element Text 	xpath=//input[@id='cfgenwp-config-form-name']
	ath input text value 	xpath=//input[@id='cfgenwp-config-form-name']	Automation template
	Capture Page Screenshot
	ath click button	//span[@id='copyTemplateBtn']
	Capture Page Screenshot
#	Logout from Application