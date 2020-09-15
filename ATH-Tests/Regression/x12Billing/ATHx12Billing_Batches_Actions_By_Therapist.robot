*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
x12Billing_Contract_BatchersCreateNew_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select x12Billing Menu
	ath click link	Batches
	ath click button 	New Batch
	Check BUtton Existence 	Save
	ath input text value	Name:	Automation Batch Testing
	ath click button 	Save
	Ath Verify Element Is Visible	xpath=//*[@class="alert alert-success"][contains(normalize-space(),'New batch successfully created')]
	Ath Verify Element Is Visible	xpath=//tbody/descendant::*[normalize-space()="Automation Batch Testing"]


x12Billing_Contract_BatchesSelectRecordsPerPage_By_Therapist
	Clients.Select Records Per Page Value 	100
	Capture Page Screenshot

x12Billing_Contract_BatchesInputSearchCriteria_WithReults_By_Therapist
	Input Search Criteria 	Automation Batch Testing
	x12Billing.Verify Table Contains Results

x12Billing_Contract_BatchesInputSearchCriteria_NoReults_By_Therapist
	Input Search Criteria 	75
	x12Billing.Verify Table Contains Results 	true
	Logout from Application
