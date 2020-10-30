*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/ReportsPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${SupervisorSecure}	Ellis
${SupervisorLive}	Meghan
${DLDirectory}	C:\\ath.git\\AdaptiveTelehealth\\ATH-Resources\\Downloads

***Test Cases***
ATHReportsAndLogs_MedicareReport_SelectDateSetForReport_DisplayBy Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Reports and logs Menu
	Reports.Select Report Category	Medicare Report
	sleep 	3.0
	ath wait until loaded 	30
	Capture Page Screenshot
	ath click button 	xpath=//button[contains(@id,'reload_data')]
	Reports.Verify Display Table Is Displayed

ATHReportsAndLogs_MedicareReport_CancelSavePrint_By Supervisor
#move to selected page
	Run Keyword and Ignore Error	Check Button Existence 	Save/Print
	Check Label Existence 	First Name,Last Name,Date of Birth,Spent,Group
	ath check Label 	xpath=(//b[contains(text(), "adaptive")])[1]

	Logout from Application


