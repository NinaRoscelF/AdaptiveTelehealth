*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/ReportsPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${SupervisorSecure}	Ellis
${SupervisorLive}	testsupervisor


***Test Cases***
ATHReportsAndLogs_SchedulingStatus_VerifyReportDisplay_By Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Reports and logs Menu
	Run Keyword if	"${TestEnv}" == "Secure" 	Reports.Select Report Category	Scheduling Status 	ELSE 	Reports.Select Report Category	Satisfaction Report
	Run Keyword if	"${TestEnv}" == "Secure" 	Check Label Existence 	Scheduling Report 	ELSE 	Check Label Existence 	Satisfaction Report
	Check Label Existence 	Reporting Period:,Select a start date:
	# Run Keyword if	"${TestEnv}" == "Secure"	Check Label existence 	${SupervisorSecure} 	ELSE 	Check Label existence 	${SupervisorLive}
	Check Button Existence 	Set

ATHReportsAndLogs_SchedulingStatus_SelectDateSetForReport_By Supervisor
	${DtToday}	Generate Date and Time Today 	%d-%B-%Y
	${currday} 	${currmonth}	${year} 	Split String 	${DtToday} 	separator=-
	Reports.Select Month Start	January
	Reports.Input Start Date	1
	Reports.Input Start Year	${year}
	Reports.Click Set Button

	${status}	Run Keyword and Return Status	Check Label Existence 	Scheduling Report
	Run Keyword Unless	${status}	Check Label Existence 	Satisfaction Report
	Check Label Existence 	Reporting Period:,Select an end date:
	#end Date
	Reports.Select Month End	${currmonth}
	Reports.Input Start Date	${currday}
	Reports.Input Start Year 	${year}
	Reports.Click Set Button

ATHReportsAndLogs_SchedulingStatus_SelectProvider_DisplayProviderReports_By Supervisor
	Run Keyword if	"${TestEnv}" == "Secure"	Reports.Select Report Provider 	${SupervisorSecure} 	ELSE 	Reports.Select Report Provider 	${SupervisorLive}
	Reports.Verify Display Table Is Displayed
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Capture Page Screenshot

ATHReportsAndLogs_SchedulingStatus_MoveToNextPage_By Supervisor
	Move to Next Page

ATHReportsAndLogs_SchedulingStatus_MoveToPreviousPage_By Supervisor
#move to previous page
	Move to Previous Page

ATHReportsAndLogs_SchedulingStatus_SelectPageNumber_By Supervisor
#move to selected page
	Select Page Number	2

ATHReportsAndLogs_SchedulingStatus_SelectRecordsPerPageDisplay_By_Supervisor
	Clients.Select Records Per Page Value 	100
	Sleep 	5.0
	ath wait until loaded 	30
	Capture Page Screenshot

ATHReportsAndLogs_SchedulingStatus_InputSearchCriteria_By_Supervisor
	Dashboard.GroupsCompanyWidget.Input Search Criteria 	Ginger Taylor
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword if	"${TestEnv}" == "Secure" 	Run Keyword and Continue on Failure	Should Not be True 	${status} 	ELSE 	Run Keyword and Continue on Failure	Should be True 	${status} 

ATHReportsAndLogs_SchedulingStatus_CancelSavePrint_By Supervisor
#move to selected page
	Check Button Existence 	Save/Print
	Reports.Click Save/Print Button
	Reports.Click Cancel Button

ATHReportsAndLogs_SchedulingStatus_ProceedSavePrint_By Supervisor
	Reports.Click Save/Print Button
	Reports.Input Print Reason	automation
	Reports.SchedulingReport.Click Proceed Button
	Check Label Existence 	Provider:
	${status}	Run Keyword and Return Status	Check Label Existence	${SupervisorSecure} 
	Run Keyword Unless	${status}	Check Label Existence	${SupervisorLive} 
	Go Back
	Logout from Application


