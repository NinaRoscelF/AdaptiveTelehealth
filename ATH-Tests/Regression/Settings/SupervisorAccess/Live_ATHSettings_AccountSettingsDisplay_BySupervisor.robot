*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ATHSettings_AccountSettings_MerchantServicesDisplay_BySupervisor
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Capture Page Screenshot
	Settings.AccountSettings.Select SubMenu 	Merchant Services
	Settings.AS.MerchantServices.Verify Merchant Services Page Display

ATHSettings_AccountSettings_TimezoneDisplay_BySupervisor
	Settings.AccountSettings.Select SubMenu 	Timezone
	Settings.AS.Timezone.Verify Timezone Page Display
	Logout from Application


