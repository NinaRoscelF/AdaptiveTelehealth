*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Test Cases***
Clients_DisplayClientsPage_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Clients Menu
	ath verify element is visible 	xpath=//table[contains(@class,'data-table-sort-column dataTable')]
	Check Label Existence	Profile image,First Name,Last Name,All User Time,Last Login,Message Waiting,Call,Follow Up,Status,Search
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Clients.Verify Group Company Link Is Visible

Clients_ClientsPage_MoveToNextPage_By_Therapist
	Move to Next Page

Clients_ClientsPage_MoveToPreviousPage_By_Therapist
	Move to Previous Page

Clients_ClientsPage_SelectPageNumber_By_Therapist
	Select Page Number 	3

Clients_ClientsPage_SelectRecordsPerPageDisplay_By_Therapist
	Clients.Select Records Per Page Value 	100
	Capture Page Screenshot

Clients_ClientsPage_InputSearchCriteria_By_Therapist
	Dashboard.GroupsCompanyWidget.Input Search Criteria 	Emma Stoneage
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Not be True 	${status}
	Check Link Existence	Emma,Stoneage

Clients_ClientsPage_VerifyClientArchive_By_Therapist
	Run Keyword if	"${TestEnv}" == "Secure"	ath click link 	Groups Company Archive 	ELSE 	ath click link 	Client Archive 
	Check Label Existence	Client Archive
	ath verify element is visible 	xpath=//table[@id='client_archive']
	Check Label Existence	First Name,Last Name,Last Login,Message Waiting,Call,Status

Clients_CP.ClientArchive_SortFirstNameColumn_By_Therapist
	Clients.Sort First Name Column

Clients_CP.ClientArchive_SortLastNameColumn_By_Therapist
	Clients.Sort Last Name Column

Clients_CP.ClientArchive_SortLastLoginColumn_By_Therapist
	Clients.Sort Last Login Column
	Logout from Application
