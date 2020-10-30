** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers



***Test Cases***
ATHSettings_AccountSettings_MechantServices_ByTherapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu 	Merchant Services
	Settings.AS.MerchantServices.Verify Merchant Services Page Display
	Settings.Timezone.Select Cardconnect as Merchant Service
	Check Label Existence 	MerchantID
	Settings.Timezone.Select Paypal as Merchant Service
	Check Label Existence 	Paypal Client ID

ATHSettings_AccountSettings_Timezone_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Timezone
	Settings.AS.Timezone.Verify Timezone Page Display
	Settings.Timezone.Select Timezone Dropdown	(GMT-06:00) Saskatchewan
	Settings.Timezone.Click Save Button
	Settings.Timezone.Verify Timxezone Changed Successfully
	Settings.Timezone.Select Timezone Dropdown	(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi
	Settings.Timezone.Click Save Button
	Settings.Timezone.Verify Timxezone Changed Successfully
	Logout from Application
