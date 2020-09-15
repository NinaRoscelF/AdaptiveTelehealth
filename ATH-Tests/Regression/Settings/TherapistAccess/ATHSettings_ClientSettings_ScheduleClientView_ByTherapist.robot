** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ATHSettings_ClientSettings.ScheduleClientView_DisableView_ByTherapist
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Run Keyword if	"${TestEnv}" == "Secure" 	Settings.AccountSettings.Select SubMenu 	Groups Company Settings	ELSE	Settings.AccountSettings.Select SubMenu 	Client Settings
	Settings.CS.Click Schedule OnOff SubMenu
	Settings.CS.Verify Schedule Client Page Displayed
	Settings.CS.Schedule.Click Apply Button
	Settings.CS.Schedule.Set Provider Checkbox 	false
	Settings.CS.Schedule.Click Apply Button
	Settings.CS.Schedule.Verify View is Saved Successfully
	Logout from Application

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	${status}	Run Keyword and Return Status	Select Scheduling Menu
	Run Keyword and Continue on Failure 	Should not be True	${status}
	Logout from Application

ATHSettings_ClientSettings.ScheduleClientView_EnableView_ByTherapist
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Run Keyword if	"${TestEnv}" == "Secure" 	Settings.AccountSettings.Select SubMenu 	Groups Company Settings	ELSE	Settings.AccountSettings.Select SubMenu 	Client Settings
	Settings.CS.Click Schedule OnOff SubMenu
	Settings.CS.Schedule.Click Apply Button
	Settings.CS.Schedule.Set Provider Checkbox
	Settings.CS.Schedule.Click Apply Button
	Settings.CS.Schedule.Verify View is Saved Successfully
	Logout from Application

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	${status}	Run Keyword and Return Status	Select Scheduling Menu
	Run Keyword and Continue on Failure 	Should Be True	${status}
	Logout from Application