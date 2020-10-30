*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/OthersPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
DSM5_DisplayDSM5Page_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select DSM5 Menu
	check label existence 	Clinical Assessment Grids,Search DSM-5,Search By
	Check button existence 	Find
	${status}	Run keyword and Return Status	Check button existence	Create Groups Company File
	Run Keyword Unless	${status}	Check button existence	Create Client File
	Check Link Existence 	DSM-5 Archive
	DSM5.Verify DSM5 Page Contents

DSM5_SearchFromGrid_NoResults_By_Therapist
	DSM5.Input Search First Criteria	JPEGFile
	ath click button 	Find
	DSM5.Close Information Search Popup

DSM5_ClickDSM5Archive_By_Therapist
	ath click link 	DSM-5 Archive
	Check Label Existence 	Forms not found,DSM-V Archive,Package

DSM5_CreateClient_By_Therapist
	Select DSM5 Menu
	${Firstname}	Generate Random String	8	[LETTERS]
	${status}	Run keyword and Return Status	ath click button 	Create Groups Company File
	Run Keyword Unless	${status}	ath click button 	Create Client File
	Dashboard.Confirm Create Client File Button
	Dashboard.NewClient.Input Client First Name 	${Firstname}
	Dashboard.NewClient.Input Client Last Name 	Automation
	Capture Page Screenshot
	ath click button 	xpath=//button[@class='btn btn-success'][contains(text(),'Create Client File')]
	Sleep 	3.0
	ath wait until loaded 	60
	Messaging.Verify Client File Created
	Capture Page Screenshot
	Logout from Application
