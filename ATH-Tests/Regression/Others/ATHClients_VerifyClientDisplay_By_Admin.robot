*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Test Cases***
Clients_DisplayClientsPage_By_Admin

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Perform Login Checks
	Select Clients Menu
	ath verify element is visible 	xpath=//table[contains(@class,'dataTable')]/descendant::th[text()="First Name"]
	Check Label Existence	First Name,Last Name,ast Login,Message Waiting,Call,Follow Up,Status,Groups,Assign,Search
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Clients.Verify Group Company Link Is Visible

Clients_ClientsPage_SortFirstNameColumn_By_Admin
	Clients.Sort First Name Column

Clients_ClientsPage_SortLastNameColumn_By_Admin
	Clients.Sort Last Name Column

CClients_ClientsPage_SortLastLoginColumn_By_Admin
	Clients.Sort Last Login Column

Clients_ClientsPage_MoveToNextPage_By_Admin
	Move to Next Page

Clients_ClientsPage_MoveToPreviousPage_By_Admin
	Move to Previous Page

Clients_ClientsPage_SelectPageNumber_By_Admin
	Select Page Number 	3

Clients_ClientsPage_SelectRecordsPerPageDisplay_By_Admin
	Clients.Select Records Per Page Value 	100
	Capture Page Screenshot

Clients_ClientsPage_InputSearchCriteria_By_Admin
	Dashboard.GroupsCompanyWidget.Input Search Criteria 	Emma Stoneage
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Not be True 	${status}
	Check Link Existence	Emma,Stoneage

Clients_ClientsPage_VerifyClientArchive_By_Admin
	ath click link	See Client Archive
	Check Label Existence	Patient Archive
	Check Label Existence	First Name,Last Name,Last Login,Message Waiting,Community Last Login,Flagged,Therapist,Status
	Logout from Application
