** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/OthersPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${fnameSecure} 	Ginger
${fnameLive} 	Automation
${lnameSecure} 	Taylor
${lnameLive} 	IsClient

***Test Cases***
ATHProfile_VerifyClientDisplayProfile_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Profile Menu
	ClientProfile.Verify Change Password button is visible
	Check link existence 	View My Agreements
	Check Label Existence 	Status,Profile image,Extra Information
	Check Button Existence 	Choose File,Add
	Check Button Existence	xpath=//input[@value="Update Information"]
	Run Keyword if	"${TestEnv}" == "Secure"	ClientProfile.Verify Client's First Name 	${fnameSecure} 	ELSE 	ClientProfile.Verify Client's First Name 	${fnameLive}
	Run Keyword if	"${TestEnv}" == "Secure"	ClientProfile.Verify Client's Last Name	${lnameSecure}	ELSE 	ClientProfile.Verify Client's Last Name	${lnameLive}
	Run Keyword if	"${TestEnv}" == "Secure"	ClientProfile.Verify Client's Email	${AutoClient}	ELSE 	ClientProfile.Verify Client's Email	${AutoClient1}
	ClientProfile.Click Vitals tab
	ClientProfile.Verify Vital Info tab Displayed
	ClientProfile.Click RX and Allergy tab
	ClientProfile.Verify Rx and Allergy Info tab Displayed
	Logout from Application




	# ath_verify_textbox_value	Last Name:	Ellis
	# ath_verify_textbox_value	Phone Number:	5241346
	# ath_verify_textbox_value	Email / Username:	ninaf+client@adaptivetelehealth.com