*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/ReportsPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${SupervisorSecure}	Ellis
${SupervisorLive}	Meghan
${DLDirectory}	C:\\ath.git\\AdaptiveTelehealth\\ATH-Resources\\Downloads


***Test Cases***
ATHReportsAndLogs_ProviderReport_SelectDateSetForReport_DisplayBy Supervisor
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Reports and logs Menu
	Reports.Select Report Category	Provider Report
	sleep 	3.0
	ath wait until loaded 	30
	Capture Page Screenshot
	Run Keyword and Ignore Error	ath click button 	OK
	${startDate}	ath_GetDateTime	<<jan 1st of curr yr>>	%d-%b-%Y
	${DtToday}	Generate Date and Time Today 	%d-%B-%Y
	${currday} 	${currmonth}	${year} 	Split String 	${DtToday} 	separator=-
	Reports.Select Report Provider 	Automation

	#For date selection, do not remove
	# ath click icon 	xpath=//input[@name='date-from']

	# :FOR 	${index}	IN RANGE	0	10
	# \	${idx}	Evaluate	${index} + 1
	# \	Sleep 	2.0
	# \	ath wait until loaded 	30
	# \	Execute Javascript	var element = document.evaluate("//a[@class='ui-datepicker-prev ui-corner-all']" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue;if (element != null) {element.click();}
	# \	${status } 	Run Keyword and Return Status	ath verify element is visible 	xpath=//span[@class='ui-datepicker-month'][normalize-space()="January"]
	# \	Run Keyword If 	${status}	Exit For Loop
	# \	Capture Page Screenshot
	# ath click icon 	xpath=//td[@data-handler="selectDay"]/a[text()="1"]
	#EOC

	Capture Page Screenshot
	ath click button 	Generate Report
	Sleep 	30.0
	ath wait until loaded 	30
	Reports.Verify Display Table Is Displayed


ATHReportsAndLogs_ProviderReport_MoveToNextPage_By Supervisor
	Move to Next Page

ATHReportsAndLogs_ProviderReport_MoveToPreviousPage_By Supervisor
#move to previous page
	Move to Previous Page

ATHReportsAndLogs_ProviderReport_SelectPageNumber_By Supervisor
#move to selected page
	Select Page Number	2

ATHReportsAndLogs_ProviderReport_SelectRecordsPerPageDisplay_By_Supervisor
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Select Records Per Page Value 	100
	Sleep 	5.0
	ath wait until loaded 	30
	Capture Page Screenshot

ATHReportsAndLogs_InputSearchCriteria_By_Supervisor
	Clients.Verify Search Input Is Visible
	Dashboard.GroupsCompanyWidget.Input Search Criteria 	Ginger Taylor
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Not be True 	${status}
	Clear Search Criteria

ATHReportsAndLogs_ProviderReport_CancelPrintReport_By Supervisor
	Reports.ClinicData.Click Save Button
	Reports.Click Cancel Button

ATHReportsAndLogs_ProviderReport_ProceedPrintReport_By Supervisor
	Remove Files 	${DLDirectory}/*.xlsx
	Reports.ClinicData.Click Save Button
	Reports.Input Print Reason 	automation reason
	${status}	Run Keyword and Return Status	Reports.Click Proceed Button
	Run Keyword Unless 	${status}	Reports.SchedulingReport.Click Proceed Button
	Sleep 	10.0
	ath wait until loaded 	30
	Select window	New
	Capture Page Screenshot
	Go Back
	Logout from Application


