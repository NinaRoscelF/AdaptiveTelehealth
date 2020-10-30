** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***variables***



***Test Cases***
ATHSettings_TemplatesFieldAndFormDisplay_ByTherapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Templates, Fields and Forms
	Settings.AccountSettings.Select SubMenu 	Display as open by default
	Check Label Existence	Display as open by, Show column text preview
	ath check button existence 	Apply
	Settings.AccountSettings.Select SubMenu 	Form Templates
	Check Label Existence	Form Templates
	Settings.CS.Status.Verify Header Column Display 	Order
	Settings.CS.Status.Verify Header Column Display 	Name
	Settings.CS.Status.Verify Header Column Display 	Draft
	Settings.CS.Status.Verify Header Column Display 	Date Created
	Settings.CS.Status.Verify Header Column Display 	Date Last Update
	Settings.CS.Status.Verify Header Column Display 	Prompt on next login
	Settings.CS.Status.Verify Header Column Display 	Prompt on first login
	ath check button existence 	Create New
	Run Keyword if	"${TestEnv}" == "Live"	ath check links displayed	Form Template DEMO

	Settings.AccountSettings.Select SubMenu 	Homework Templates
	Check Label Existence	Homework Templates
	Settings.CS.Status.Verify Header Column Display 	Order
	Settings.CS.Status.Verify Header Column Display 	Name
	Settings.CS.Status.Verify Header Column Display 	Draft
	Settings.CS.Status.Verify Header Column Display 	Date Created
	Settings.CS.Status.Verify Header Column Display 	Date Last Update
	Settings.CS.Status.Verify Header Column Display 	Prompt on next login
	Settings.CS.Status.Verify Header Column Display 	Prompt on first login
	ath check button existence 	Create New

	Settings.AccountSettings.Select SubMenu 	Clinical Templates
	Check Label Existence	Clinical Templates
	Settings.CS.Status.Verify Header Column Display 	Order
	Settings.CS.Status.Verify Header Column Display 	Name
	Settings.CS.Status.Verify Header Column Display 	Draft
	Settings.CS.Status.Verify Header Column Display 	Date Created
	Settings.CS.Status.Verify Header Column Display 	Date Last Update
	Run Keyword if	"${TestEnv}" == "Live"	ath check links displayed	Clinical Template DEMO
	ath check button existence 	Create New

ATHSettings_PasswordPageDisplay_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Password
	Check Label Existence	Change Password,New Password,Confirm Password
	Check Button Existence	Change Password
	Capture Page Screenshot

ATHSettings_SystemPreference_Input Change Password Details_ByTherapist
	Settings.SP.Password.Input New Password Value 	Password123
	Settings.SP.Password.Click Unmask New Password Input
	Settings.SP.Password.Input Confirm Password Value 	Password123
	Settings.SP.Password.Click Unmask Confirm Password Input

# ATHSettings_OfflineChatPageDisplay_ByTherapist
# 	Settings.AccountSettings.Select SubMenu 	Offline Chat Notifications
# 	Check Button Existence 	Turn Off,Turn On-Save Changes
# 	Check Label Existence	Offline Chat Notifications,Current Status,Custom Message for your Clients
	Logout from Application
