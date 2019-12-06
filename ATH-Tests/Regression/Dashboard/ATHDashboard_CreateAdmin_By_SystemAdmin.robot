*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/Dashboard_NewUserCreationPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Variable***
${Gender}	Female
${Supervisor}	Meghan Ruiz

***Test Cases***
Dashboard_CreateAdmin_By_SystemAdmin
#create supervisor
	${Firstname}	Generate Random String	8	[LETTERS]
	${RegCode}	Generate Random String	10	[NUMBERS]

	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin}	${TestEnv}
	Wait for Nav Bar to display
	Dashboard.Click New Admin Button
	Sleep 	3.0
	ath input text value	//*[@id="addNewAdmin"]/descendant::input[@name="first_name"]	${FirstName}
	ath input text value	//*[@id="addNewAdmin"]/descendant::input[@name="last_name"]	${LastName}
	ath input text value	//*[@id="addNewAdmin"]/descendant::input[@name="city"]	${City}
	ath input text value	//*[@id="addNewAdmin"]/descendant::input[@name="address"]	${Address}
	ath input text value	//*[@id="addNewAdmin"]/descendant::input[@name="zip"]	${Zip}
	ath input text value	//*[@id="addNewAdmin"]/descendant::input[@name="email"]	${Firstname}@mailinator.com
	ath input text value	//*[@id="addNewAdmin"]/descendant::input[@name="registrationCode"]	${RegCode}
	Dashboard.NewUser.Is Biller Role 	No
	Dashboard.NewUser.AssignSupervisor to Admin	${Supervisor}
	ath select drop down field value	//*[@id="addNewAdmin"]/descendant::select[@name="gender"]	${Gender}
	Capture Page Screenshot
	Dashboard.NewUser.Click Add New User Button
	Dashboard.NewUser.Verify User Is saved successfully
	Sleep 	3.0
	Dashboard.AdminsWidget.Select Newly Created Admin	${Firstname}
	Dashboard.NewUser.Verify Admin Data Displayed	${Firstname}
	Dashboard.NewUser.Verify Supervisor Assigned to Admin	${Supervisor}
	Go Back
	Wait for Nav Bar to display
	Logout from Application