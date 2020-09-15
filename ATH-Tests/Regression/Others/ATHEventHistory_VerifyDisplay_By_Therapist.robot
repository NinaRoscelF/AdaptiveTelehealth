*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Test Cases***
EventHistory_DisplayEventHistoryPage_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Select Event History Menu
	ath verify element is visible 	xpath=//*[@id="company_list"]/descendant::h3[contains(normalize-space(),'Event logs')]
	Check Label Existence	Actions,Pages,From,To,User Full Name,Action,Page,Comment,Date
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible

EventHistory_MoveToNextPage_By_Therapist
	Move to Next Page

EventHistory_MoveToPreviousPage_By_Therapist
	Move to Previous Page

EventHistory_SelectPageNumber_By_Therapist
	Select Page Number 	3

EventHistory_SelectRecordsPerPageDisplay_By_Therapist
	Clients.Select Records Per Page Value 	100
	Capture Page Screenshot

EventHistory_SelectActionsFromDropdown_By_Therapist
	ath select drop down field value 	Actions	file upload
	Sleep 	10.0
	ath wait until loaded 	30
	ath verify element is visible 	xpath=(//tr/td[text()="file upload"])[1]
	Capture page Screenshot
	ath select drop down field value	Actions	- Select Action -
	Sleep 	10.0
	ath wait until loaded 	30


EventHistory_SelectPagesFromDropdown_By_Therapist
	ath select drop down field value 	Pages	Notepad
	Sleep 	10.0
	ath wait until loaded 	30
	ath verify element is visible 	xpath=(//tr/td[text()="notepad note created"])[1]
	Capture page Screenshot
	ath select drop down field value	Pages	- Select Page -
	Sleep 	10.0
	ath wait until loaded 	30


EventHistory_InputSearchCriteria_By_Therapist
	ath input text value	xpath=//label[contains(text(),'Search')]//input	Update
	Sleep 	10.0
	ath wait until loaded 	30
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Not be True 	${status}
	ath verify element is visible 	xpath=(//tr/td[text()="meeting update"])[1]
	Capture page Screenshot
	Clear Element Text	xpath=//label[contains(text(),'Search')]//input


EventHistory_SortUserFullNameColumn_By_Therapist
	Clients.Select Records Per Page Value 	25
	EventHistory.Sort User Full Name Column
	Capture page Screenshot

EventHistory_SortActionColumn_By_Therapist
	EventHistory.Sort Action Column
	Capture page Screenshot

EventHistory_SortLastLoginColumn_By_Therapist
	EventHistory.Sort Page Column
	Logout from Application
