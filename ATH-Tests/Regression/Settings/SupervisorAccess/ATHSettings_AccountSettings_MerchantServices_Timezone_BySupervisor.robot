** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers



***Test Cases***
ATHSettings_AccountSettings_MechantServices_BySupervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu 	Merchant Services
	Settings.Timezone.Select Cardconnect as Merchant Service
	Check Label Existence 	Merchant ID
	Settings.Timezone.Select Paypal as Merchant Service
	Check Label Existence 	PayPal Email
	Settings.AS.MerchantServices.Verify Merchant Services Page Display

ATHSettings_AccountSettings_Timezone_BySupervisor
	Settings.AccountSettings.Select SubMenu 	Timezone
	Settings.AS.Timezone.Verify Timezone Page Display
	Settings.Timezone.Select Timezone Dropdown	(GMT-06:00) Saskatchewan
	Settings.Timezone.Click Save Button
	Settings.Timezone.Verify Timxezone Changed Successfully
	Settings.Timezone.Select Timezone Dropdown	(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi
	Settings.Timezone.Click Save Button
	Settings.Timezone.Verify Timxezone Changed Successfully
	Logout from Application
