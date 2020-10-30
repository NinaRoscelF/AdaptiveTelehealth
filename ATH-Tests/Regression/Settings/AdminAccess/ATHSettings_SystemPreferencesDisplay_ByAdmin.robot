** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ATHSettings_SystemPreferences_InviteUsersDisplay_ByAdmin

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.SP.InviteUsers.Verify InviteUsers Page Display

ATHSettings_SystemPreferences_DisplayAuthorizationCode_ByAdmin
	Settings.AccountSettings.Select SubMenu 	Authorization
	ath check label	Display Authorization Code
	Capture Page Screenshot

ATHSettings_SystemPreferences_ClientConsentFormDisplay_ByAdmin
	Settings.AccountSettings.Select SubMenu 	Consent
	Settings.SP.ConsentForm.Verify ConsentForm Page Display

ATHSettings_SystemPreferences_ClientConsentForm_UpdateConsentForm_ByAdmin
	Settings.SP.ConsentForm.Input Consent Form Title 	Automation Consent Title
	Settings.SP.ConsentForm.Click Update Consent Form Button

ATHSettings_SystemPreferences_ClientConsentForm_PreviewConsentForm_ByAdmin
	Settings.SP.ConsentForm.Click Preview Consent Form Button
	Settings.SP.ConsentForm.Verify Display Consent Form Popup
	Settings.SP.ConsentForm.Close Preview Popup


ATHSettings_SystemPreferences_ScheduleDisplay_ByAdmin
	Settings.AccountSettings.Select SubMenu 	Schedule
	Settings.SP.Schedule.Verify Schedule Page Display

ATHSettings_SystemPreference_LogoSettingsDisplay_ByAdmin
	Settings.AccountSettings.Select SubMenu 	Logo
	Check Label Existence 	Active Logo
	Capture Page Screenshot

ATHSettings_SystemPreference_GroupsProgramsDisplay_ByAdmin
	Settings.AccountSettings.Select SubMenu 	Programs
	Settings.SP.GroupsAndProgram.Verify GroupsAndProgram Page Display

ATHSettings_SystemPreference_PasswordDisplay_ByAdmin
	Settings.AccountSettings.Select SubMenu 	Password
	Check Label Existence	Change Password,New Password,Confirm Password
	ath check button existence	Change Password
	Capture Page Screenshot

ATHSettings_SystemPreference_Input Change Password Details_ByAdmin
	Settings.SP.Password.Input New Password Value 	Password123
	Settings.SP.Password.Click Unmask New Password Input
	Settings.SP.Password.Input Confirm Password Value 	Password123
	Settings.SP.Password.Click Unmask Confirm Password Input
	Logout from Application
