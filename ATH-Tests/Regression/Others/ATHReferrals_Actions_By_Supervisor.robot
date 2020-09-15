*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Referrals_DisplayReferralPage_By_Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Referrals Menu
	ath verify element is visible 	xpath=//*[normalize-space()="Referral Dashboard"]/following-sibling::div[1]/descendant::section
	Check label Existence 	Referral Dashboard,Make a Referral,Referrals Received,Referrals Made
	Check Link Existence 	Referral Archive

Referrals_ReferralArchive_By_Supervisor
	ath click link 	Referral Archive
	Check Label Existence 	Referrals Made - Archive
	ath verify element is visible 	xpath=//*[normalize-space()="Referrals"]/following-sibling::div[1]/descendant::section
	Capture Page Screenshot
	Go back

Referrals_MakeReferral_By_Supervisor
	${patientFirst}	Generate Random String	8	[LETTERS]
	${patientLast}	Generate Random String	10	[LETTERS]
	Set Suite Variable 	${patientFirst}
	ath click link 	xpath=//a[text()="Automation Label"]
	ath input text value 	Patient First Name 	${patientFirst}
	ath input text value 	Patient last Name 	${patientLast}
	ath select drop down field value 	Choose Patient Status 	Active
	Capture Page Screenshot
	ath click button 	Send Referral
	Capture Page Screenshot


Referrals_SelectRecordsPerPage_By_Supervisor
	Clients.Select Records Per Page Value 	100 	2
	Referrals.Verify Referral Is Displayed in Table 	Referrals Made 	${patientFirst}
	Capture Page Screenshot

Referrals_InputSearchCriteria_WithResults_By_Supervisor
	Input Search Criteria	${patientFirst} 	2
	Dashboard.GroupsCompanyWidget.Verify No Results found 	false

Referrals_InputSearchCriteria_NoResults_By_Supervisor
	Input Search Criteria	anything 	2
	Dashboard.GroupsCompanyWidget.Verify No Results found

	Logout from Application


