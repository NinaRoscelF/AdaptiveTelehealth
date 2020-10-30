** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/DashboardPage_res.txt
Variables	${EXECDIR}../../ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Test Cases***
ATHSettings_CS.IU_InviteClient_EmailRequired_ByTherapist
	${FirstName}	Generate Random String	7	[LETTERS]
	Set Suite Variable	${Firstname}
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Run Keyword if	"${TestEnv}" == "Secure" 	Settings.AccountSettings.Select SubMenu 	Groups Company Settings	ELSE	Settings.AccountSettings.Select SubMenu 	Client Settings
	Settings.AccountSettings.Select SubMenu 	Invite Users
	Settings.IU.Click Invite Client Button
	Run Keyword if 	"${TestEnv}" == "Secure" 	ath set text area value	Enter Groups Company's Invitation Message 	${AutomationMessage}	ELSE	ath set text area value	Enter Client's Invitation Message 	${AutomationMessage}
	Run Keyword if 	"${TestEnv}" == "Secure"	Dashboard.NewClient.Click Invite Groups Company Button	ELSE	Dashboard.NewClient.Click Invite Client Button
	Settings.IU.InviteClient.Verify Email Required
	Settings.IU.InviteClient.Close Email Warning Popup

ATHSettings_CS.IU_InviteClient_EmailPreview_ByTherapist
	Run Keyword if 	"${TestEnv}" == "Secure" 	Dashboard.NewClient.Input Group Company Email	${Firstname}@mailinator.com	ELSE 	Dashboard.NewClient.Input Client Email	${Firstname}@mailinator.com
	Run Keyword if 	"${TestEnv}" == "Secure" 	ath set text area value	Enter Groups Company's Invitation Message 	${AutomationMessage}	ELSE	ath set text area value	Enter Client's Invitation Message 	${AutomationMessage}
	Capture Page Screenshot
	Settings.IU.Click Email Preview Button
	RUn Keyword and Ignore error	Settings.IU.InviteClient.EmailPreviewPopup.Verify Invite Message	${AutomationMessage}
	RUn Keyword and Ignore error	Settings.IU.InviteClient.EmailPreviewPopup.Verify Email Recipient	${FirstName}@mailinator.com
	Settings.SP.ConsentForm.Close Preview Popup


ATHSettings_CS.IU_InviteClient_ByTherapist
	Run Keyword if 	"${TestEnv}" == "Secure"	Dashboard.NewClient.Click Invite Groups Company Button	ELSE	Dashboard.NewClient.Click Invite Client Button
#	Dashboard.NewClient.Verify Client is Invited 	${FirstName}@mailinator.com
	Dashboard.Click back to Dashboard link
	Dashboard.Click Invite Client Button
	Dashboard.InvitationsWidget.Select Records per Page Value	100
	Sleep	30.0	Wait until widget is loaded
	ath wait until loaded	60
	Capture Page Screenshot
	Dashboard.ClientsWidget.Verify Newly Created Client Is Displayed 	${Firstname}

	Login to Mailinator	${Firstname}@mailinator.com
	Continue User Invitation
	Select window	New
	Capture Page Screenshot
	Complete registration Process	${Firstname}	Automation	${Firstname}@mailinator.com
	Open Browser	${URL}	${BROWSER}	ff_profile_dir=profiledir
	Maximize Browser Window
	Input Email Address 	${Firstname}@mailinator.com
	Input Password	${Password}
	Click Login Button
	Verify Login Error Is Visible


