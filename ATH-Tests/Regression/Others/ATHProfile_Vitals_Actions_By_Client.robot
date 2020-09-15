** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Suite Teardown	Close All Browsers



***Test Cases***
ATHProfile_Vitals_VerifyPageDisplay_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Profile Menu
	ClientProfile.Click Vitals tab
	ClientProfile.Verify Vital Info tab Displayed
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Check Label Existence 	Vitals,Create,Weight,Height,Heart Rate,Temperature,BP Left,BP Right,BMI,Updated By
	Move to Next Page
	Move to Previous Page

ATHProfile_RxAndAllergy_VerifyPageDisplay_By_Client
	ClientProfile.Click RX and Allergy tab
	ClientProfile.Verify Rx and Allergy Info tab Displayed
	ath check label	xpath=(//h3[contains(normalize-space(),'Medications (Rx)')])[1]
	Check Label Existence	Allergies,Status,Name,Dose,Frequency,Updated
	ClientProfile.Verify Vital Info tab Displayed
	Clients.Verify Record Per Page Dropdown Is Visible
	Move to Next Page
	Move to Previous Page
	Logout from Application

