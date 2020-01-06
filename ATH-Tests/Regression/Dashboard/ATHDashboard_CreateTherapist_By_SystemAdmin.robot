*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/Dashboard_NewUserCreationPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers



***Test Cases***
Dashboard_CreateTherapist_By_SystemAdmin
#create client
	${Firstname}	Generate Random String	8	[LETTERS]
	${RegCode}	Generate Random String	10	[NUMBERS]

	Run Keyword if 	"${TestEnv}" == "Secure" 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin}	${TestEnv} 	ELSE 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin1}	${TestEnv}
	Wait for Nav Bar to display
	Dashboard.Click New Therapist Button
	Dashboard.NewUser.Input First Name	${FirstName}
	Dashboard.NewUser.Input Last Name	${LastName}
	Dashboard.NewUser.Input City	${City}
	Dashboard.NewUser.Input Address	${Address}
	Dashboard.NewUser.Input Zip	${Zip}
	Dashboard.NewUser.Input Email	${Firstname}@mailinator.com
	Dashboard.NewUser.Input NPI	${RegCode}
	Dashboard.NewUser.Input Registration Code	${RegCode}
	Dashboard.NewUser.Select Supervisor 	${Supervisor}
	Dashboard.NewUser.Select Gender	${Gender}
	Dashboard.NewUser.Click Set User Function button
	Dashboard.NewUser.Select Check/Uncheck All checkbox
	Capture Page Screenshot
	Dashboard.NewUser.SetUserFunction.Click Save Button
	Dashboard.NewUser.Click Add New Therapist Button
	Dashboard.NewUser.Verify Therapist saved successfully
	Dashboard.ProvidersWidget.Select Records per Page Value	100
	Dashboard.ProvidersWidget.Select Newly Created Provider	${Firstname}
	Dashboard.NewUser.Verify Is Assigned to Supervisor	${Supervisor}
	Go Back
	Wait for Nav Bar to display
	Logout from Application

	Login to Mailinator	${Firstname}@mailinator.com
	Continue User Invitation
	Select window	New
	Capture Page Screenshot
	Dashboard.NewUser.Enter New Password	${Password}
	Dashboard.NewUser.Input Confirm Password	${Password}
	Dashboard.NewUser.Click Update Password Button

	Open Browser	${URL}	${BROWSER}	ff_profile_dir=profiledir
	Maximize Browser Window
	Input Email Address 	${Firstname}@mailinator.com
	Input Password 	${Password}
	Click Login Button
	Capture Page Screenshot
	Dashboard.NewUser.Select I agree checkboxes
	Dashboard.NewUser.AgreementsPage.Input Full Name as Digital Signature	${Firstname} ${LastName}
	Dashboard.NewUser.AgreementsPage.Input TimeZone	${Timezone}
	Capture Page Screenshot
	Dashboard.NewUser.AgreementsPage.Click Submit Button
	Wait for Nav Bar to display
	Logout from Application