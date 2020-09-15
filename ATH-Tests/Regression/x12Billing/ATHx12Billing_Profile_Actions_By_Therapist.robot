*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
x12Billing_VerifyContractDetailsField_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select x12Billing Menu
	ath click link	Contracts
	Capture Page Screenshot
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	ath click button	New Contract
	Check Label Existence 	New Contract,Contract details,X12 Data
	Check Label Existence 	Client/Patient,Authorization #,Time frame,Billing rate,Unit limit,Contract code,Product Service ID,Provider,Notes
	ath verify element is visible 	xpath=//b[text()="Contract details"]/ancestor::div[1]/../descendant::div[contains(@class,'form-group row')]

x12Billing_VerifyEnvelopDetailsField_By_Therapist
	Check Label Existence 	Sender Company Name,Sender Company ID,Receiver Company Name,Receiver Company ID
	ath verify element is visible 	xpath=//*[text()="Envelop"]/ancestor::div[1]/../descendant::div[contains(@class,'form-group row')]

x12Billing_VerifySenderDetailsField_By_Therapist
	Check Label Existence 	Submiter Address,Submiter City,Submiter State,Submiter Zip,Info Contact Phone,Provider Tax ID
	ath verify element is visible 	xpath=//*[normalize-space()="Sender details"]/ancestor::div[1]/../descendant::div[contains(@class,'form-group row')]
	Logout from Application
