** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ATHSettings_TemplatesFieldAndFormDisplay_BySupervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Templates, Fields and Forms
	Settings.AccountSettings.Select SubMenu 	Groups and Programs
	Check Label Existence	Groups and Programs,Groups,Members
	Run Keyword if	"${TestEnv}" == "Live"	Check Label Existence	Assign User To Group,Create New Group
	Run Keyword if	"${TestEnv}" == "Live"	Check Button Existence	Create,Assign,Change,Remove,Rename
	Settings.CS.Status.Verify Header Column Display 	Member
	Settings.CS.Status.Verify Header Column Display 	Group
	Settings.CS.Status.Verify Header Column Display 	Members
	Settings.CS.Status.Verify Header Column Display 	Group name
	Run Keyword if	"${TestEnv}" == "Live"	Settings.CS.Status.Verify Header Column Display 	Change
	Run Keyword if	"${TestEnv}" == "Live"	Settings.CS.Status.Verify Header Column Display 	Remove
	Check Link Existence	Previous,Next

	Run Keyword if	"${TestEnv}" == "Secure"	Settings.AccountSettings.Select SubMenu 	Clinical Templates
	Run Keyword if	"${TestEnv}" == "Secure"	Settings.TFF.Verify Clinical Template Page Displayed

	Run Keyword if	"${TestEnv}" == "Secure"	Settings.AccountSettings.Select SubMenu 	Referral Form Template
	Run Keyword if	"${TestEnv}" == "Secure"	Settings.TFF.Verify Referral Form Template Page Displayed


ATHSettings_PasswordPageDisplay_BySupervisor
	Settings.AccountSettings.Select SubMenu 	Password
	Check Label Existence	Change Password,New Password,Confirm Password
	Check Button Existence	Change Password
	Capture Page Screenshot

ATHSettings_SystemPreference_Input Change Password Details_BySupervisor
	Settings.SP.Password.Input New Password Value 	Password123
	Settings.SP.Password.Click Unmask New Password Input
	Settings.SP.Password.Input Confirm Password Value 	Password123
	Settings.SP.Password.Click Unmask Confirm Password Input

# ATHSettings_OfflineChatPageDisplay_BySupervisor
# 	Settings.AccountSettings.Select SubMenu 	Offline Chat Notifications
# 	Check Button Existence 	Turn Off,Turn On - Save Changes
# 	Check Label Existence	Offline Chat Notifications,Current Status,Custom Message for your Clients

	Logout from Application
