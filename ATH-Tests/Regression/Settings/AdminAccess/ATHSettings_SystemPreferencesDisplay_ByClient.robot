** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ATHSettings_SystemPreferences_ScheduleDisplay_ByClient

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu 	Timezone
	Settings.SP.Schedule.Verify Schedule Page Display

ATHSettings_SystemPreference_PasswordDisplay_ByClient
	Settings.AccountSettings.Select SubMenu 	Password
	Check Label Existence	Change Password,New Password,Confirm Password
	ath check button existence	Change Password
	Capture Page Screenshot

ATHSettings_SystemPreference_Input Change Password Details_ByClient
	Settings.SP.Password.Input New Password Value 	Password123
	Settings.SP.Password.Click Unmask New Password Input
	Settings.SP.Password.Input Confirm Password Value 	Password123
	Settings.SP.Password.Click Unmask Confirm Password Input
	Logout from Application
