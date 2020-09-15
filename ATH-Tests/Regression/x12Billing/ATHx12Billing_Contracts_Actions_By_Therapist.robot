*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers

***variables***
${Client}	Beyonce Halo
${therapist}	Automation Therapist

***Test Cases***
x12Billing_Contract_CreateNew_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select x12Billing Menu
	ath click link	Contracts
	ath click button 	New Contract
	Check BUtton Existence 	Save & New,Save,Save & Bill
	ath select drop down field value 	Client/Patient: 	${Client}
	ath select drop down field value 	Provider: 	${therapist}
	ath set text area value 	Notes: 	Automation Testing
	ath click button 	Save
	Ath Verify Element Is Visible	xpath=//*[@class="alert alert-success"][contains(normalize-space(),'New contract successfully created')]
	Ath Verify Element Is Visible	xpath=//tbody/descendant::a[normalize-space()="${Client}"]

x12Billing_Contract_DisplayDetailsWidget_By_Therapist
	ath click link 	${Client}
	Ath Verify Element Is Visible	xpath=//*[contains(normalize-space(),'Halo')][@id="new_contract"]
	ath verify element is visible 	xpath=//b[text()="Contract details"]/ancestor::div[1]/../descendant::div[contains(@class,'form-group row')]
	ath verify element is visible 	xpath=//*[text()="Envelop"]/ancestor::div[1]/../descendant::div[contains(@class,'form-group row')]
	ath verify element is visible 	xpath=//*[normalize-space()="details"]/ancestor::div[1]/../descendant::div[contains(@class,'form-group row')]

x12Billing_Contract_SelectRecordsPerPage_By_Therapist
	Clients.Select Records Per Page Value 	100
	Capture Page Screenshot

x12Billing_Contract_InputSearchCriteria_WithReults_By_Therapist
	Input Search Criteria 	${Client}
	x12Billing.Verify Table Contains Results

x12Billing_Contract_InputSearchCriteria_NoReults_By_Therapist
	Input Search Criteria 	75
	x12Billing.Verify Table Contains Results 	true
	Logout from Application
