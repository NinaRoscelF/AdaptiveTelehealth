*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers




***Test Cases***
Dashboard_CreateSupervisor_By_SystemAdmin
#create supervisor
	${Firstname}	Generate Random String	8	[LETTERS]
	${RegCode}	Generate Random String	10	[NUMBERS]

	Run Keyword if 	"${TestEnv}" == "Secure" 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin}	${TestEnv} 	ELSE 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin1}	${TestEnv}
	Wait for Nav Bar to display
	Dashboard.Click New Supervisor Button
	Sleep 	3.0
	ath input text value	//*[@id="addNewSupervisor"]/descendant::input[@name="first_name"]	${FirstName}
	ath input text value	//*[@id="addNewSupervisor"]/descendant::input[@name="last_name"]	${LastName}
	ath input text value	//*[@id="addNewSupervisor"]/descendant::input[@name="city"]	${City}
	ath input text value	//*[@id="addNewSupervisor"]/descendant::input[@name="address"]	${Address}
	ath input text value	//*[@id="addNewSupervisor"]/descendant::input[@name="zip"]	${Zip}
	ath input text value	//*[@id="addNewSupervisor"]/descendant::input[@name="email"]	${Firstname}@mailinator.com
	ath select drop down field value	//div[@class='names']//select[@name='gender']	${Gender}
	ath input text value	//*[@id="addNewSupervisor"]/descendant::input[@name="NPI"]	${RegCode}
	Run Keyword if 	"${TestEnv}" == "Secure" 	Dashboard.NewUser.Is Read Only Supervisor	Yes: Viewing as Supervisor Automation Automation 	ELSE 	Dashboard.NewUser.Is Read Only Supervisor	Yes: Viewing as Meghan Ruiz 
	Dashboard.NewUser.Is Super Care Coordinator	No

	Dashboard.NewUser.Click Set User Function button
	ath click icon	xpath=//div[@id='newSupervisor']//span[contains(text(),'×')]
	Dashboard.NewUser.Select Check/Uncheck All checkbox
	Capture Page Screenshot
	Dashboard.NewUser.SetUserFunction.Click Save Button
	Dashboard.NewUser.Click Add New Supervisor Button
	Dashboard.NewUser.Verify Supervisor Is saved successfully
	Sleep 	3.0
	Dashboard.CareCoordinatorsWidget.Select Records per Page Value 	100
	Dashboard.ProvidersWidget.Select Newly Created Care Coordinators	${Firstname}
	Dashboard.NewUser.Verify Supervisor Profile is Created
	ath_verify_textbox_value	//input[@name='email']	${Firstname}@mailinator.com
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
	Wait for Nav Bar to display
	Capture Page Screenshot
	Logout from Application
