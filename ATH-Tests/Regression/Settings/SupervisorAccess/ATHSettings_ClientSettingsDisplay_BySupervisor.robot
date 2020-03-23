** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***variables***



***Test Cases***
ATHSettings_ClientSettingsDisplay_BySupervisor

	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Run Keyword if	"${TestEnv}" == "Secure" 	Settings.AccountSettings.Select SubMenu 	Groups Company Settings	ELSE	Settings.AccountSettings.Select SubMenu 	Client Settings
	Run Keyword if	"${TestEnv}" == "Live"	Settings.AccountSettings.Select SubMenu 	Invite Users
	Run Keyword if	"${TestEnv}" == "Live"	Settings.CS.Verify Invite Users Page Displayed
	Settings.AccountSettings.Select SubMenu	Display Authorization Code
	Check Label Existence	Display Authorization Code
	Settings.AccountSettings.Select SubMenu 	Status
	Check Label Existence	Status,equals to
	Settings.CS.Status.Verify Header Column Display 	Sort
	Settings.CS.Status.Verify Header Column Display 	Name
	Settings.CS.Status.Verify Header Column Display 	equals to
	Settings.CS.Status.Verify Header Column Display 	Type
	Settings.CS.Status.Verify Header Column Display 	Active
	Settings.CS.Status.Verify Header Column Display 	Action
	ath check button existence 	Add
	Logout from Application
