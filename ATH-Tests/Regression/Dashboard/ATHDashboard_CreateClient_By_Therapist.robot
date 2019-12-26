*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/Dashboard_NewUserCreationPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers




***Test Cases***
Dashboard_CreateClient_By_Therapist
#create client

	${Firstname}	Generate Random String	8	[LETTERS]
	${RegCode}	Generate Random String	10	[NUMBERS]

	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}
	Perform Login Checks
	Dashboard.Click New Client Button
	Run Keyword if 	"${TestEnv}" == "Secure" 	Dashboard.NewClient.Input Group Company Email	${Firstname}@mailinator.com	ELSE 	Dashboard.NewClient.Input Client Email	${Firstname}@mailinator.com

	Run Keyword if 	"${TestEnv}" == "Secure"	Dashboard.NewClient.Click Invite Groups Company Button	ELSE	Dashboard.NewClient.Click Invite Client Button
	Sleep 	3.0
	Dashboard.NewClient.Verify Client is Invited	${Firstname}@mailinator.com
	Sleep 	3.0
	Dashboard.Click back to Dashboard link
	Dashboard.Click New Client Button
	Dashboard.InvitationsWidget.Select Records per Page Value	100
	Dashboard.ClientsWidget.Verify Newly Created Client Is Displayed 	${Firstname}

	Login to Mailinator	${Firstname}@mailinator.com
	Continue User Invitation
	Select window	New
	Capture Page Screenshot
	Complete registration Process	${Firstname}	Automation	${Firstname}@mailinator.com


	Open Browser	${URL}	${BROWSER}	ff_profile_dir=profiledir
	Maximize Browser Window
	Input Email Address	${Firstname}@mailinator.com
	Input Password	${Password}
	Click Login Button
	Verify Login Error Is Visible
	Capture Page Screenshot


# 	Dashboard.NewUser.Input City	${City}
# 	Dashboard.NewUser.Input Address	${Address}
# 	Dashboard.NewUser.Input Phone Number1	${PhoneNo}
# 	Dashboard.NewUser.Select I agree checkboxes
# 	Dashboard.NewUser.Input Full Name	${Firstname} ${LastName}
# #	Run keyword and ignore error	Mouse up	xpath=//canvas[@id='dd_canvas']
# 	Run Keyword and Expect Error	*	Dashboard.NewUser.Click OK button
# 	Logout from Application
