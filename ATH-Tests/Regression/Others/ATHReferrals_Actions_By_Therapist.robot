*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Referrals_DisplayReferralPage_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Referrals Menu
	ath verify element is visible 	xpath=//*[normalize-space()="Referral Dashboard"]/following-sibling::div[1]/descendant::section
	Check label Existence 	Referral Dashboard,Make a Referral,Referrals Received,Referrals Made
	Check Link Existence 	Referral Archive

Referrals_ReferralArchive_By_Therapist
	ath click link 	Referral Archive
	Check Label Existence 	Referrals Made - Archive
	ath verify element is visible 	xpath=//*[normalize-space()="Referrals"]/following-sibling::div[1]/descendant::section
	Capture Page Screenshot

Referrals_CancelSendReferral_By_Therapist
	Go back
	${patientFirst}	Generate Random String	8	[LETTERS]
	${patientLast}	Generate Random String	10	[LETTERS]
	Set Suite Variable 	${patientFirst}
	Set Suite Variable 	${patientLast}
	ath click link 	xpath=//a[text()="Automation Label"]
	ath input text value 	Patient First Name 	${patientFirst}
	ath input text value 	Patient last Name 	${patientLast}
	ath select drop down field value 	Refer to	testsupervisor adaptive
	ath select drop down field value 	Choose Patient Status 	Active
	Capture Page Screenshot
	ath click button 	Cancel
	Capture Page Screenshot

Referrals_SendReferral_By_Therapist
	ath click link 	xpath=//a[text()="Automation Label"]
	ath input text value 	Patient First Name 	${patientFirst}
	ath input text value 	Patient last Name 	${patientLast}
	ath select drop down field value 	Refer to	testsupervisor adaptive
	ath select drop down field value 	Choose Patient Status 	Active
	Capture Page Screenshot
	ath click button 	Send Referral
	Capture Page Screenshot

# ATHReferrals_SelectRecordsPerPage_By_Therapist
# 	Clients.Select Records Per Page Value 	100
# 	Referrals.Verify Referral Is Displayed in Table 	Referrals Made 	${patientFirst}
# 	Referrals.Verify Referral Is Displayed in Table	Made by Staff 	${patientFirst}
# 	Capture Page Screenshot

# ATHReferrals_InputSearchCriteria_WithResults_By_Therapist
# 	Input Search Criteria	${patientFirst}
# 	Dashboard.GroupsCompanyWidget.Verify No Results found 	false

# ATHReferrals_InputSearchCriteria_NoResults_By_Therapist
# 	Input Search Criteria	anything
# 	Dashboard.GroupsCompanyWidget.Verify No Results found
	Logout from Application
