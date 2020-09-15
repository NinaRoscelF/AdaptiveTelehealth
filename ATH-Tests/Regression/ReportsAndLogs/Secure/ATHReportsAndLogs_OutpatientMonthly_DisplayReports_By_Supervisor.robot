*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/ReportsPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${SupervisorSecure}	Ellis
${SupervisorLive}	Meghan
${DLDirectory}	C:\\ath.git\\AdaptiveTelehealth\\ATH-Resources\\Downloads


***Test Cases***
ATHReportsAndLogs_ClinicData_VerifyReportDisplay_By Supervisor
	[tags]	Secure
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Reports and logs Menu
	Reports.Select Report Category	Monthly
	sleep 	3.0
	ath wait until loaded 	30
	Capture Page Screenshot
	Run Keyword and Ignore Error	ath click button 	OK
	${startDate}	ath_GetDateTime	<<jan 1st of curr yr>>	%d-%b-%Y
	${DtToday}	Generate Date and Time Today 	%d-%B-%Y
	${currday} 	${currmonth}	${year} 	Split String 	${DtToday} 	separator=-

	ath click icon 	xpath=//input[@name='date-from']
	ath click icon 	xpath=//*[contains(@class,'datepicker-month')]
	ath click icon 	xpath=//*[contains(@class,'datepicker-month')]/option[normalize-space()="Mar"]
	${status } 	Run Keyword and Return Status	ath verify element is visible 	xpath=//*[contains(@class,'datepicker-month')]/option[normalize-space()="Jan"]
	ath click icon 	xpath=//td[@data-handler="selectDay"]/a[text()="1"]

	Capture Page Screenshot
	ath click button 	Generate Report
	Sleep 	30.0
	ath wait until loaded 	30
	Reload Page
	ath click button 	OK
	ath verify element is visible 	xpath=//table[contains(@id,'storage-report')]/tbody/tr 	false


ATHReportsAndLogs_ClinicData_MoveToNextPage_By Supervisor
	Move to Next Page

ATHReportsAndLogs_ClinicData_MoveToPreviousPage_By Supervisor
#move to previous page
	Move to Previous Page

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
	Run Keyword and Continue on Failure	Should be True 	${status}


ATHReportsAndLogs_ClinicData_SaveReport_NoData_By Supervisor
	Remove Files 	${DLDirectory}/*.xlsx
	ath click button 	Save
	ath click button 	OK

ATHReportsAndLogs_ClinicData_PrintReport__NoData_By Supervisor
	ath click button 	Print
	ath click button 	OK

ATHReportsAndLogs_ClinicData_CloseReportScreen_By Supervisor
	ath click button 	Close
	Sleep 	10.0
	Capture Page Screenshot
	Logout from Application


