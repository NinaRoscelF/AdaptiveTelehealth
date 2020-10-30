*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/OthersPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
x12Billing_DisplayProfilePage_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select x12Billing Menu
	check label existence 	x12 Billing,Profile,Contracts,Billing,Batches
	ath select drop down field value 	Profile 	Ginger Taylor
	ath verify element is visible 	xpath=//div[@class='box-body']
	check label existence	Diagnosis,Medicaid #,SS #,DOB,Gender,Marital Status,Street adress,City,State,Zip
	Check Button Existence 	Save

x12Billing_VerifyContractsPage_By_Therapist
	ath click link	Contracts
	Capture Page Screenshot
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Check Button Existence	New Contract
	Check Label Existence	Client,Date End,Date Begin,Batch,Auth #,Remaining,Units Charged,Amount,Created,Updated,Notes
	Move to Next Page
	Move to Previous Page

x12Billing_VerifyBillingPage_By_Therapist
	ath click link	xpath=(//a[normalize-space()="Billing"])[1]
	Capture Page Screenshot
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Check Button Existence	New Bill,Filter,Create x12
	Check Label Existence 	Select,Client,Service Date End,Service Date Begin,Batch,Auth #,Remaining,Units Charged,Amount,Created
	Move to Next Page
	Move to Previous Page
	Check Link Existence 	Billing Archive

x12Billing_VerifyFilesPage_By_Therapist
	Check Label Existence 	x12 Files,File Name,Created

x12Billing_VerifyBillingArchivePage_By_Therapist
	ath click link	Billing Archive
	Check Label Existence 	Archive
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Check Label Existence 	Client,Service Date End,Service Date Begin,Batch,Auth #,Remaining,Units Charged,Amount,Create
	Move to Next Page
	Move to Previous Page
	Check Link Existence 	Billing
	ath click link	Billing
	Sleep 	5.0
	ath wait until loaded 	30

x12Billing_DisplayBatchesPage_By_Therapist
	ath click link	Batches
	Capture Page Screenshot
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Check Button Existence	New Batch
	Check Label Existence 	Name,Created
	Move to Next Page
	Move to Previous Page
	Logout from Application
