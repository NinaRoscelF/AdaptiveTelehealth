
*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers

***Variable***
${AttendeeSecure}	Emma Stoneage
${AttendeeLive}	Mary Ellis

***Test Cases***
Clients_DisplayClientsPage_By_Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Select Clients Menu
	ath verify element is visible 	xpath=//table[contains(@class,'dataTable')]/descendant::th[text()="First Name"]
	Check Label Existence	Profile image,First Name,Last Name,Last Login,Message Waiting,Call,Follow Up,Status,Search
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Clients.Verify Group Company Link Is Visible
	${status}	Run Keyword and Return Status 	ath click link	Groups Company Archive
	Run Keyword Unless 	${status}	ath click link 	Client Archive
	Sleep 	3.0
	ath wait until loaded 	30

Clients_ClientsPage_MoveToNextPage_By_Supervisor
	Move to Next Page

Clients_ClientsPage_MoveToPreviousPage_By_Supervisor
	Move to Previous Page

Clients_ClientsPage_SelectPageNumber_By_Supervisor
	Select Page Number 	3

Clients_ClientsPage_SelectRecordsPerPageDisplay_By_Supervisor
	Clients.Select Records Per Page Value 	100
	Sleep 	5.0
	ath wait until loaded 	30
	Capture Page Screenshot

Clients_ClientsPage_InputSearchCriteria_By_Supervisor
	Run Keyword if	"${TestEnv}" == "Secure"	Dashboard.GroupsCompanyWidget.Input Search Criteria 	${AttendeeSecure} 	ELSE 	Dashboard.GroupsCompanyWidget.Input Search Criteria 	${AttendeeLive}
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Not be True 	${status}
	Run Keyword if	"${TestEnv}" == "Secure"	Check Link Existence	Emma,Stoneage	ELSE 	Check Link Existence	Mary,Ellis

Clients_ClientsPage_VerifyClientArchive_By_Supervisor
#	Run Keyword if	"${TestEnv}" == "Secure"	ath click link 	Groups Company Archive 	ELSE 	ath click link 	Client Archive
	Check Label Existence	Client Archive
	ath verify element is visible 	xpath=//table[contains(@class,'dataTable')]/descendant::th[text()="First Name"]
	Check Label Existence	First Name,Last Name,Last Login,Message Waiting,Call,Status

Clients_CP.ClientArchive_SortFirstNameColumn_By_Supervisor
	Clients.Sort First Name Column

Clients_CP.ClientArchive_SortLastNameColumn_By_Supervisor
	Clients.Sort Last Name Column

# Clients_CP.ClientArchive_SortLastLoginColumn_By_Supervisor
# 	Clients.Sort Last Login Column
	Logout from Application
