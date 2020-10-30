*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/OthersPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ParentalConsent_DisplayConsentPage_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Parental Consent Menu
	ath verify element is visible 	xpath=//*[contains(@id,'parental-consent')]/descendant::table
	ath verify element is visible 	xpath=//*[contains(@id,'right-send-parental-consent')]/descendant::form
	Check Label Existence	Parental Consent,SEND PARENTAL CONSENT,First Name,Last Name,Phone Number,Sent,Received,Resent,Instructions
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Check Button Existence 	PRINT,RESEND,SEND

ParentalConsent_ConsentPage_SelectRecordsPerPageDisplay_By_Therapist
	Clients.Select Records Per Page Value 	100
	Capture Page Screenshot

ParentalConsent_ConsentPage_InputSearchCriteria_By_Therapist
	ath input text value 	xpath=(//label[contains(text(),"Search ")])/input	Emma Stoneage
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Be True 	${status}

ParentalConsent_ConsentPage_DisplayInstructions_By_Therapist
	ath click icon 	xpath=//img[contains(@src,'/resize')]
	ath verify element is visible 	xpath=//*[contains(@id,'parental-consent')]/descendant::span[@class="list-numbering"]
	Logout from Application
