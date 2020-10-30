*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DashboardPage_res.txt
Variables	${EXECDIR}../../ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Test Cases***
Dashboard_SortColumns_AndSearch_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Dashboard.Select 3rd Column Display	Email
	Dashboard.Verify Header Column Display Applied	Email
	Dashboard.Select 5th Column Display	Gender
	Dashboard.Verify Header Column Display Applied	Gender
	#Revert to orig display
	Dashboard.Select 3rd Column Display	Middle Name
	Dashboard.Verify Header Column Display Applied	Middle Name
	Dashboard.Select 5th Column Display	City
	Dashboard.Verify Header Column Display Applied	City
	Dashboard.ClientsWidget.Select Records per Page Value	100
	Sleep	30.0	Wait until widget is loaded
	ath wait until loaded	60
#	Run Keyword and Ignore Error	Dashboard.ClientWidget.Sort First Name Column
#	Run Keyword and Ignore Error	Dashboard.ClientWidget.Sort Last Name Column
#	Dashboard.ClientsWidget.Select Records per Page Value	10
	Dashboard.GroupsCompanyWidget.Input Search Criteria	Beyonce
	ath launch via shortcut keys	ENTER	//div[@id='therapist_clients_filter']//input
#	Sleep 	20.0
	ath wait until loaded	60
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	RUn Keyword and Ignore Error	Should Not Be True	${status}
	Move to Next Page
	Move to Previous Page
	Select Page Number 	4
	Logout from Application