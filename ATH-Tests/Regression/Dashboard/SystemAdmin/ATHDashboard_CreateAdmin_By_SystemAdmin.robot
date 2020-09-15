*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Variable***
${Supervisor}	Meghan Ruiz


***Test Cases***
Dashboard_CreateAdmin_By_SystemAdmin
#create supervisor
	${Firstname}	Generate Random String	8	[LETTERS]
	${RegCode}	Generate Random String	10	[NUMBERS]

	Run Keyword if 	"${TestEnv}" == "Secure" 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin}	${TestEnv} 	ELSE 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin1}	${TestEnv}
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
	Dashboard.AdminsWidget.Select Records per Page Value 	100
	Sleep 	10.0
	ath wait until loaded 	30
	Dashboard.AdminsWidget.Select Newly Created Admin	${Firstname}
	Dashboard.NewUser.Verify Admin Data Displayed	${Firstname}
	Dashboard.NewUser.Verify Supervisor Assigned to Admin	${Supervisor}
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
	Run Keyword and Ignore Error	ath click button	xpath=//*[contains(normalize-space(),'Please contact support to activate')]/ancestor::div[@class="modal-dialog"]/descendant::div[@class="modal-footer"]/descendant::button[normalize-space()="OK"]
	Capture Page Screenshot
	Dashboard.NewUser.Select I agree checkboxes
	Dashboard.NewUser.AgreementsPage.Input Full Name as Digital Signature	${Firstname} ${LastName}
	Dashboard.NewUser.AgreementsPage.Input TimeZone	${Timezone}
	Capture Page Screenshot
	Dashboard.NewUser.AgreementsPage.Click Submit Button
	Wait for Nav Bar to display
	Logout from Application