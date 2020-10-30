*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/ReportsPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${SupervisorSecure}	Ellis
${SupervisorLive}	Meghan
${DLDirectory}	C:\\ath.git\\AdaptiveTelehealth\\ATH-Resources\\Downloads


***Test Cases***
ATHReportsAndLogs_ClinicData_VerifyReportDisplay_By Supervisor
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Reports and logs Menu
	Reports.Select Report Category	Clinic Data
	sleep 	3.0
	ath wait until loaded 	30

	Capture Page Screenshot

	Run Keyword and Ignore Error	ath click button 	OK
	${startDate}	ath_GetDateTime	<<jan 1st of curr yr>>	%d-%b-%Y
	${DtToday}	Generate Date and Time Today 	%d-%B-%Y
	${currday} 	${currmonth}	${year} 	Split String 	${DtToday} 	separator=-

	ath click icon 	xpath=//input[@name='date-from']
	ath click icon 	xpath=//*[contains(@class,'datepicker-month')]
	ath click icon 	xpath=//*[contains(@class,'datepicker-month')]/option[normalize-space()="Jan"]
	${status } 	Run Keyword and Return Status	ath verify element is visible 	xpath=//*[contains(@class,'datepicker-month')]/option[normalize-space()="Jan"]
	# :FOR 	${index}	IN RANGE	0	10
	# \	${idx}	Evaluate	${index} + 1
	# \	Sleep 	2.0
	# \	ath wait until loaded 	30
	# \ 	ath click icon 	xpath=//a[@class='ui-datepicker-prev ui-corner-all']
	# \	${status } 	Run Keyword and Return Status	ath verify element is visible 	xpath=//span[@class='ui-datepicker-month'][normalize-space()="January"]
	# \	Run Keyword If 	${status}	Exit For Loop
	# \	Capture Page Screenshot

	ath click icon 	xpath=//td[@data-handler="selectDay"]/a[text()="1"]

	Capture Page Screenshot
	ath click button 	Generate Report
	Sleep 	30.0
	ath wait until loaded 	30
	ath verify element is visible 	xpath=//table[contains(@id,'storage-report')]/tbody/tr


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

ATHReportsAndLogs_ClinicData_VerifyDisplayGraph_By Supervisor
	ath verify element is visible 	xpath=//canvas[@name='myChart1']
	ath verify element is visible 	xpath=//canvas[@name='myChart2']
	ath verify element is visible 	xpath=//canvas[@name='myChart3']

ATHReportsAndLogs_ClinicData_SaveReport_By Supervisor
	Remove Files 	${DLDirectory}/*.xlsx
	ath click button 	xpath=//button[contains(normalize-space(),'Save')][contains(@id,'storage-save')]
	Sleep 	10.0
	ath wait until loaded 	30
	Reports.Verify Downloaded Event Document 	${DLDirectory}

ATHReportsAndLogs_ClinicData_CancelPrintReport_By Supervisor
	Reports.ClinicData.Click Print Button
	Reports.Input Print Reason 	automation reason
	Reports.Click Cancel Button

ATHReportsAndLogs_ClinicData_ProceedPrintReport_By Supervisor
	Reports.ClinicData.Click Print Button
	Reports.Input Print Reason 	automation reason
	Reports.Click Proceed Button
	Sleep 	10.0
	Capture Page Screenshot
	Go Back
	Logout from Application


