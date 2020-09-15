*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/ReportsPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${SupervisorSecure}	Ellis
${SupervisorLive}	Meghan
${DLDirectory}	C:\\ath.git\\AdaptiveTelehealth\\ATH-Resources\\Downloads


***Test Cases***
AATHReportsAndLogs_MonthlyTimer_ReportDisplay_By Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Reports and logs Menu
	Reports.Select Report Category	Monthly Timer
	sleep 	3.0
	ath wait until loaded 	30
	Capture Page Screenshot
#	ath click link 	xpath=//a[contains(text(),'<<<')]
	Reports.MonthlyTimerReport.Select Month 	March

AATHReportsAndLogs_MonthlyTimer_SelectRecordsPerPageDisplay_By_Supervisor
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Select Records Per Page Value 	100
	Sleep 	5.0
	ath wait until loaded 	30
	Capture Page Screenshot


AATHReportsAndLogs_MonthlyTimer_MoveToNextPage_By Supervisor
	Move to Next Page

AATHReportsAndLogs_MonthlyTimer_MoveToPreviousPage_By Supervisor
#move to previous page
	Move to Previous Page

AATHReportsAndLogs_MonthlyTimer_SelectPageNumber_By Supervisor
#move to selected page
	Select Page Number	2

AATHReportsAndLogs_MonthlyTimer_InputSearchCriteria_By_Supervisor
	Clients.Verify Search Input Is Visible
	Dashboard.GroupsCompanyWidget.Input Search Criteria 	Ginger Taylor
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should be True 	${status}
	Clear Search Criteria

AATHReportsAndLogs_MonthlyTimer_SaveReport_By Supervisor
	Remove Files 	${DLDirectory}/*.xlsx
	ath click icon	xpath=//input[@value="Save/Print"]
	Sleep 	10.0
	ath wait until loaded 	30
	Go Back
	Capture Page Screenshot
	Close Browser


