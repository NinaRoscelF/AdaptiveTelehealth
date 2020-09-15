*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Financial_BillsPayment_CreateInvoice_CancelCreation_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	${DtToday}	Generate Date and Time Today 	%d-%b-%Y
	${endDate}	ath_GetDateTime	<<SPECDATE end of curr month>>	%d-%b-%Y
	Set Suite variable 	${DtToday}

	Select Financial Menu
	ath click link 	Bills and Payment
	ath click link 	Create Invoice
	sleep 	3.0
	ath wait until loaded 	30
	Capture Page Screenshot
	ath click button 	xpath=(//*[contains(normalize-space(),'Select template')]/ancestor::div[@class="modal-dialog"]/descendant::button[contains(normalize-space(),'Close')])[2]
	Capture Page Screenshot
	Sleep 	5.0
	ath wait until loaded 	30

Financial_BillsPayment_CreateInvoice_ContinueCreation_By_Therapist
	ath click link 	Create Invoice
	sleep 	3.0
	ath wait until loaded 	30
	ath click icon 	xpath=//label[contains(text(),'invoice template')]/following::select[@name="template_id"]
	ath click icon 	xpath=//*[@name="template_id"]/option[contains(text(),'Generic Invoice')]
	ath click Button 	Continue
	Sleep 	5.0
	ath wait until loaded 	30
	Capture Page Screenshot
	check label existence 	Create Invoice
	ath verify element is visible 	xpath=//form[@id="invoice_form"]
	Capture Page Screenshot

Financial_BillsPayment_CreateInvoice_InputDetailsAndSave_By_Therapist
	${att}	Get Element Attribute	xpath=//label[contains(text(),'From')]/../../label[@id="provider_address"]@textContent
	Run Keyword and COntinue on Failure	Should be empty	${att}
	ath click icon 	xpath=//label[contains(text(),'From')]/following::select[@id="provider_name"]
	ath click icon 	xpath=//*[@id="provider_name"]/option[contains(text(),'Therapist')]
	${att}	Get Element Attribute	xpath=//label[contains(text(),'From')]/../../label[@id="provider_address"]@textContent
	Run Keyword and COntinue on Failure	Should not be empty	${att}
	Capture Page Screenshot
	ath_select_date_from_datepicker 	${DtToday}	xpath=//label[text()="Invoice Date"]/following-sibling::input[contains(@name,'invoice_data')]

	ath click icon 	xpath=//*[@id="appointment_status"]
	ath click icon 	xpath=//*[@id="appointment_status"]/option[contains(text(),'Attended')]
	ath input text value 	xpath=//*[@type="service_type"] 	AutoType
	${amt}	Generate Random String	chars=[NUMBERS]	length=3
	Set Suite variable 	${amt}
	ath input text value 	xpath=//*[@placeholder="$"] 	${amt}
	Capture Page Screenshot
	ath verify element is visible 	xpath=//*[contains(@class,'text-left amount-for-payor')]
	${isAmt}	Get Element Attribute	xpath=//*[contains(@class,'text-left amount-for-payor')]@textContent
	Run Keyword and COntinue on Failure	Should Contain 	${isAmt} 	${amt}
	ath click button 	Save
	Sleep 	2.0
	ath wait until loaded 	30
	Capture Page Screenshot
	Check Label Existence 	Invoice saved
	Check Label Existence 	Edit invoice
	ath click link 	Return to invoices
	ath verify element is visible 	xpath=//td[contains(normalize-space(),'${amt}')]

Financial_BillsPayment_CancelInvoice_CloseCancelInvoice_By_Therapist
	ath click link 	xpath=//td[contains(normalize-space(),'${amt}')]/following::td[4]/a[text()="Cancel Invoice"]
	ath click button 	xpath=(//*[contains(normalize-space(),'Cancellation Messages')]/ancestor::div[@class="modal-dialog"]/descendant::button[contains(normalize-space(),'Close')])[2]

Financial_BillsPayment_CancelInvoice_ContinueWithoutReason_By_Therapist
	ath click link 	xpath=//td[contains(normalize-space(),'${amt}')]/following::td[4]/a[text()="Cancel Invoice"]
	ath click button 	xpath=(//*[contains(normalize-space(),'Cancellation Messages')]/ancestor::div[@class="modal-dialog"]/descendant::input[@value="Continue"])
	Check Label Existence 	Please state reason for cancellation

Financial_BillsPayment_CancelInvoice_ContinueWithReason_By_Therapist
	ath click icon 	xpath=//*[@id="reason"]
	ath click icon 	xpath=//*[@id="reason"]/option[contains(text(),'Waive Cancellation Fee')]
	ath click button 	xpath=(//*[contains(normalize-space(),'Cancellation Messages')]/ancestor::div[@class="modal-dialog"]/descendant::input[@value="Continue"])
	Check label existence 	Invoice successfully cancelled.
	Sleep 	2.0
	ath verify element is visible 	xpath=//td[contains(normalize-space(),'${amt}')]/following::td[4]/a[text()="Cancel Invoice"]	false
	Logout from Application
