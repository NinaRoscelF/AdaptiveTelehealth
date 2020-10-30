*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/ReportsPage_res.txt
Suite Teardown	Close All Browsers
Force Tags	System:Secure


***Variable***
${SupervisorSecure}	Ellis
${SupervisorLive}	Meghan
${DLDirectory}	C:\\ath.git\\AdaptiveTelehealth\\ATH-Resources\\Downloads


***Test Cases***
ATHReportsAndLogs_GroupTherapist_VerifyReportDisplay_By Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Reports and logs Menu
	Reports.Select Report Category	Group Therapist
	sleep 	3.0
	ath wait until loaded 	30
	Capture Page Screenshot
	Reports.Select Report Provider 	Ellis
	ath click button 	Generate Report
	Sleep 	30.0
	ath wait until loaded 	30
	Run Keyword and Ignore Error 	ath verify element is visible 	xpath=//table[contains(@id,'storage-report')]/tbody/tr

ATHReportsAndLogs_ClinicData_MoveToNextPage_By Supervisor
	Move to Next Page

ATHReportsAndLogs_ClinicData_MoveToPreviousPage_By Supervisor
#move to previous page
	Move to Previous Page

ATHReportsAndLogs_ClinicData_SelectPageNumber_By Supervisor
#move to selected page
	Select Page Number	2

ATHReportsAndLogs_ClinicData_SelectRecordsPerPageDisplay_By_Supervisor
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Select Records Per Page Value 	100
	Sleep 	5.0
	ath wait until loaded 	30
	Capture Page Screenshot

ATHReportsAndLogs_ClinicData_InputSearchCriteria_By_Supervisor
	Clients.Verify Search Input Is Visible
	Dashboard.GroupsCompanyWidget.Input Search Criteria 	Ginger Taylor
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Not be True 	${status}

ATHReportsAndLogs_ClinicData_CancelPrintReport_By Supervisor
	Reports.ClinicData.Click Save Button
	Reports.Input Print Reason 	automation reason
	Reports.Click Cancel Button

ATHReportsAndLogs_ClinicData_ProceedPrintReport_By Supervisor
	Reports.ClinicData.Click Save Button
	Reports.Input Print Reason 	automation reason
	Reports.SchedulingReport.Click Proceed Button
	Sleep 	10.0
	Capture Page Screenshot
	Go Back
	Logout from Application


