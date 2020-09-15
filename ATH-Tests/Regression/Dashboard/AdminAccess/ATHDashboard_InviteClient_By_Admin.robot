*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Test Cases***
Dashboard_InviteClient_By_Admin

	${Firstname}	Generate Random String	8	[LETTERS]
	${RegCode}	Generate Random String	10	[NUMBERS]
	Set Suite Variable	${Firstname}

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Perform Login Checks
	Dashboard.Click Invite Client Button
	${status}	Run Keyword and Return Status	ath select drop down field value 	xpath=//select[@name='therapist_id']/optgroup	Mary Ellis
	#xpath=//select[@name='therapist_id']/optgroup/option[normalize-space()="Mary Ellis"]
	Capture Page Screenshot
	Run Keyword Unless 	${status}	ath select drop down field value 	xpath=//select[@name='therapist_id']	Mary Ellis
	Capture Page Screenshot
	Run Keyword if 	"${TestEnv}" == "Secure" 	Dashboard.NewClient.Input Group Company Email	${Firstname}@mailinator.com	ELSE 	Dashboard.NewClient.Input Client Email	${Firstname}@mailinator.com

	Run Keyword if 	"${TestEnv}" == "Secure"	Dashboard.NewClient.Click Invite Groups Company Button	ELSE	Dashboard.NewClient.Click Invite Client Button
	Sleep 	3.0
	Dashboard.NewClient.Verify Client is Invited	${Firstname}@mailinator.com
	Sleep 	3.0
	Dashboard.Click back to Dashboard link
	Dashboard.AdminRole.ClientsWidget.Select Records per Page Value	100
	Sleep	15.0	Wait until widget is loaded
	ath wait until loaded	60
	Capture Page Screenshot


	Login to Mailinator	${Firstname}@mailinator.com
	Continue User Invitation
	Select window	New
	Capture Page Screenshot
	Complete registration Process	${Firstname}	Automation	${Firstname}@mailinator.com

	Logout from Application