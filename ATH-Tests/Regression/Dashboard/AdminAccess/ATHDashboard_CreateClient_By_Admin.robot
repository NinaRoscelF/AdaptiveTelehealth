*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DashboardPage_res.txt
Variables	${EXECDIR}../../ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers



***Test Cases***
Dashboard_CreateClient_By_Admin
#create client
	${Firstname}	Generate Random String	8	[LETTERS]
	${RegCode}	Generate Random String	10	[NUMBERS]

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Perform Login Checks
	Dashboard.Click Create Client Button
	Dashboard.Confirm Create Client File Button
	Dashboard.NewClient.Input Client First Name 	${Firstname}
	Dashboard.NewClient.Input Client Last Name 	Automation
	Dashboard.NewClient.Click Create Client File Button
	Sleep 	3.0
	ath wait until loaded 	60
	Messaging.Verify Client File Created
	Reload Page
	Dashboard.AdminRole.ClientsWidget.Select Records per Page Value	100
	Sleep	30.0	Wait until widget is loaded
	ath wait until loaded	60
	Capture Page Screenshot
	Dashboard.GroupsCompanyWidget.Input Search Criteria 	${Firstname}
	Dashboard.AdminRole.ClientsWidget.Verify Created File is Visible	${Firstname}
	Dashboard.AdminRole.ClientsWidget.Select Newly Created Client	${Firstname}
	Dashboard.NewUser.Click Update Client Information link
	Sleep	5.0
	ath wait until loaded	60
	Dashboard.NewUser.ClientInfo.Input Email address	${Firstname}@mailinator.com
	Dashboard.NewUser.ClientInfo.Click Invite Button

	Login to Mailinator	${Firstname}@mailinator.com
	Continue User Invitation
	Select window	New
	Capture Page Screenshot
	Complete registration Process	${Firstname}	Automation	${Firstname}@mailinator.com

	Verify Live Login	${FirstName}	${Password}	${URL}	${BROWSER}
	Logout from Application


**** Keywords ****
Verify Live Login
	[Arguments]	${FirstName}	${Password}	${URL}	${BROWSER}
	Open Browser	${URL}	${BROWSER}	ff_profile_dir=profiledir
	Maximize Browser Window
	Input Email Address	${Firstname}@mailinator.com
	Input Password	${Password}
	Click Login Button
	sleep 	2.0
	ath wait until loaded 	30
	Verify Login Error Is Visible

Verify Secure Login
	[Arguments]	${FirstName}	${Password}	${URL}	${BROWSER}
	Open Browser	${URL}	${BROWSER}	ff_profile_dir=profiledir
	Maximize Browser Window
	Input Email Address 	${Firstname}@mailinator.com
	Input Password	${Password}
	Click Login Button
	Select Timezone for Newly Created User	(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi
	Capture Page Screenshot
	Close Upload Image Popup

Input Employee Details
	[Arguments]	${City}	${Address}	${PhoneNo}	${FirstName}	${LastName}
	Dashboard.NewUser.Input City	${City}
	Dashboard.NewUser.Input Address	${Address}
	Dashboard.NewUser.Input Phone Number1	${PhoneNo}
	Dashboard.NewUser.Select I agree checkboxes
	Dashboard.NewUser.Input Full Name	${Firstname} ${LastName}
	Run Keyword and Expect Error	*	Dashboard.NewUser.Click OK button




