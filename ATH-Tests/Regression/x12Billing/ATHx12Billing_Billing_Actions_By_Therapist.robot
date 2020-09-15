*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers

***variables***
${DownloadDir}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\Downloads

***Test Cases***
x12Billing_VerifyNewBillDetailsPage_By_Therapist

	Remove Files	${DownloadDir}/*.txt
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select x12Billing Menu
	ath click link	xpath=(//a[normalize-space()="Billing"])[1]
	ath click button	New Bill
	Check Label Existence 	Batch,Contract,Units Charged,Service Date
	ath verify element is visible 	xpath=//*[text()="New Bill"]/ancestor::div[1]/../descendant::div[contains(@class,'form-group row')]
	Check Button Existence 	Save
	Capture Page Screenshot

x12Billing_CreateNewBill_By_Therapist
	ath select drop down field value 	xpath=(//*[@name="batch_id"])[2]	Automation Batch
	Capture Page Screenshot
	ath select drop down field value 	xpath=(//*[@name="contract_id"])[1]	Automation IsClient (2020-05-06 10:32:35)
	ath select drop down field value 	xpath=(//*[@name="unit_charged"])[1]	5
	ath click icon	xpath=(//*[@placeholder="m/d/Y"])[1]
	ath select date_from_datepicker 	7-May-2020 	xpath=//*[@name="service_date_from"][@placeholder="m/d/Y"]
	ath click icon	xpath=(//*[@placeholder="m/d/Y"])[2]
	ath select date_from_datepicker 	8-May-2020 	xpath=//*[@name="service_date_to"][@placeholder="m/d/Y"]
	ath click button 	Save
	Capture Page Screenshot

x12Billing_Createx12Billing_By_Therapist
	ath click button	Create x12
	ath verify element is visible 	xpath=//*[contains(normalize-space(),'Select Bills')]/ancestor::div[@class="modal-dialog"]
	ath click button 	xpath=//*[contains(normalize-space(),'Select Bills')]/ancestor::div[@class="modal-dialog"]/descendant::button[contains(normalize-space(),'Ok')]
	Select Dashboard Menu
	Select x12Billing Menu
	ath click link	xpath=(//a[normalize-space()="Billing"])[1]
	ath_set_checkbox	IsClient
	Capture Page Screenshot
	ath click button	Create x12
	Sleep 	10.0
	ath wait until loaded 	30
	${File}	List Files In Directory	${DownloadDir}	*.*
	Run Keyword and Continue On Failure	File Should Exist	${DownloadDir}\\*.txt
	${FileStringRaw}	Convert To String	@{File}[0]
	${FileString}	Fetch From Left	${FileStringRaw}	.
	Clients.Select Records Per Page Value 	100 	2
	Sleep 	3.0
	ath wait until loaded 	30
	ath verify element is visible 	xpath=//tbody/descendant::a[normalize-space()="${FileString}"]
	Capture Page Screenshot

x12Billing_BillingArchive_SelectRecordsPerPage_By_Therapist
	ath click link 	Billing Archive
	ath verify element is visible 	xpath=//section[@class="section x12billing"]/descendant::table
	Clients.Select Records Per Page Value 	100
	Capture Page Screenshot

x12Billing_BillingArchive_InputSearchCriteria_WithReults_By_Therapist
	Input Search Criteria 	75
	x12Billing.Verify Table Contains Results

x12Billing_BillingArchive_InputSearchCriteria_NoReults_By_Therapist
	Input Search Criteria 	33
	x12Billing.Verify Table Contains Results 	true
	Logout from Application
