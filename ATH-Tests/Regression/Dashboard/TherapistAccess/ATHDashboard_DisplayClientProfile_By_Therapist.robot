*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Test Cases***
Dashboard_DisplayClientProfile_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	ath click icon	(//i[contains(@class,'user text')])[2]
	Dashboard.ClientProfile.Verify Client Details Displayed
	Dashboard.ClientProfile.Verify Client Label Display	Messages
	Dashboard.ClientProfile.Verify Client Label Display	Client Data
	Dashboard.ClientProfile.Verify Client Label Display	Client Profile
	Dashboard.ClientProfile.Verify Client Label Display	Clinical Notes
	Dashboard.ClientProfile.Verify Client Label Display	Time Spent Log
	Dashboard.ClientProfile.Verify Client Label Display	Client Status
	Dashboard.ClientProfile.Verify Client Label Display	Profile info
	Dashboard.ClientProfile.Verify Client Label Display	Treatment Plan
	Dashboard.ClientProfile.Verify Client Label Display	Forms
	Dashboard.ClientProfile.Verify Client Label Display	Homework
	Dashboard.ClientProfile.Verify Client Label Display	Completed DSM-V
	Dashboard.ClientProfile.Verify Client Label Display	Notepad Notes
	Select Dashboard Menu
	ath click icon	xpath=(//*[@id="therapist_clients"]/descendant::tr/td[1]/a)[2]
	ath verify element is visible 	//div[@id='dashboard_therapist']
	ath verify element is visible	//h3[contains(normalize-space(),'Time Spent Log')]
	ath_check_links_displayed	Time Log Archive
	Logout from Application