*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/OthersPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ATHTreatmentTeams_Display_By_Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Treatment Teams Menu
	ath verify element is visible 	xpath=//*[normalize-space()="Treatment Teams"]/following-sibling::div[1]/descendant::section
# 	Clients.Verify Search Input Is Visible
# 	Clients.Verify Record Per Page Dropdown Is Visible
# 	Check Link Existence	Assign a Team Member,testsupervisor

# ATHTreatmentTeams_MoveToNextPage_By_Admin
# 	Move to Next Page

# ATHTreatmentTeams_MoveToPreviousPage_By_Admin
# 	Move to Previous Page

# ATHTreatmentTeams_SelectPageNumber_By_Admin
# 	Select Page Number 	3

# ATHTreatmentTeams_SelectRecordsPerPageDisplay_By_Admin
# 	Clients.Select Records Per Page Value 	100
# 	Capture Page Screenshot

# ATHTreatmentTeams_InputSearchCriteria_By_Admin
# 	Dashboard.GroupsCompanyWidget.Input Search Criteria 	Ellis
# 	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
# 	Run Keyword and Continue on Failure	Should Not be True 	${status}
# 	Check Link Existence	Mary,Ellis

ATHTreatmentTeams_AssignTeam Member_By_Supervisor
	ath click link 	Assign a Team Member
	Check label Existence 	New Treatment Team Assignment,Select a 
	Check Link Existence 	Treatment Teams
	Clients.Verify Search Input Is Visible
	ath click link 	xpath=(//tr/td/h4/descendant::a)[1]
	ath set checkbox 	xpath=(//div[@class='main-wrap']//form[1]/descendant::ins)[1]
	ath click button 	Continue
	Capture Page Screenshot
	CHeck Label Existence 	Assign,To Client,Selected Client,Therapists
	Check Button Existence 	Cancel
	ath click button 	Confirm
	Logout from Application
