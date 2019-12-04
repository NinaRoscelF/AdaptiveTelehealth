*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/Dashboard_NewUserCreationPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Variable***
${Gender}	Male


***Test Cases***
Dashboard_CreateSupervisor_By_SystemAdmin
#create client not working
	${Firstname}	Generate Random String	8	[LETTERS]
	${RegCode}	Generate Random String	10	[NUMBERS]

	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin}	${TestEnv}
	Wait for Nav Bar to display
	Dashboard.Click New Supervisor Button
	Sleep 	3.0
#	Select Frame	//div[@id='newSupervisor']//div[@class='modal-content']
	Dashboard.NewUser.Input First Name	${FirstName}
	Dashboard.NewUser.Input Last Name	${LastName}
	Dashboard.NewUser.Input City	${City}
	Dashboard.NewUser.Input Address	${Address}
	Dashboard.NewUser.Input Zip	${Zip}
	Dashboard.NewUser.Input Email	${Firstname}@mailinator.com
	Dashboard.NewUser.Select Gender	${Gender}
	Dashboard.NewUser.Input NPI	${RegCode}
	Dashboard.NewUser.Input Registration Code	${RegCode}
	Dashboard.NewUser.Is Read Only Supervisor	No
	Dashboard.NewUser.Is Super Care Coordinator	No
	Dashboard.NewUser.Click Set User Function button
	Dashboard.NewUser.Select Check/Uncheck All checkbox
	Capture Page Screenshot
	Dashboard.NewUser.SetUserFunction.Click Save Button
	Dashboard.NewUser.Click Add New Supervisor Button
	Dashboard.NewUser.Verify Supervisor Is saved successfully
	Dashboard.ProvidersWidget.Select Newly Created Provider	${Firstname}
	Dashboard.NewUser.Verify Supervisor Profile is Created
	Go Back
	Wait for Nav Bar to display
	Logout from Application