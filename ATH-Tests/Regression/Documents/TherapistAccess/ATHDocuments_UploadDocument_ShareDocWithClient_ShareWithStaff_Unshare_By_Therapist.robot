*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${UploadFile}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\UploadtextFile.txt
${fileName}	UploadtextFile.txt
${client}	Beyonce
${staff}	Admin

***Test Cases***
ATHDocuments_UploadDocument_ShareDocumentWithClient_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Documents.CleanUp	${fileName}
	Select Documents Menu
	ath click link 	Upload Document
	Documents.Verify Upload Document Page Displayed
	Documents.Choose File	${UploadFile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	ath select radio button	Share with Client
	ath click icon	//*[@name="client_id[]"]/option[contains(text(),'${client}')]
	ath click button 	Share Document
	ath verify element is visible 	//*[@class="alert alert-success"][contains(text(),'File successfully shared: Notification sent.')]
	ath click link 	My Documents
	ath_check_links_displayed	${fileName}
	ath check button existence	Unshare
	ath_check_links_displayed	${client}

ATHDocuments_UploadDocument_ShareDocumentWithStaff_By_Therapist
	ath click link 	Upload Document
	ath select radio button	Share with Staff
	ath click icon	//*[@name="client_id[]"]/option[contains(text(),'${staff}')]
	ath click button 	Share Document
	ath verify element is visible 	//*[@class="alert alert-success"][contains(text(),'File successfully shared: Notification sent.')]
	ath click link 	My Documents
	ath_check_links_displayed	${staff}

ATHDocuments_UploadDocument_UnshareDocument_By_Therapist
	ath check button existence	Unshare first to delete
	ath verify element is visible	//*[text()="${fileName}"]/ancestor::tr/descendant::button[contains(text(),'Unshare first')][@disabled]
	${shareCount}	Get Matching Xpath Count	//*[text()="${fileName}"]/ancestor::tr/descendant::button[normalize-space()="Unshare"]
	:FOR 	${idx}	IN RANGE 	1	${shareCount} + 1
	\	ath click button	//*[text()="${fileName}"]/ancestor::tr/descendant::button[normalize-space()="Unshare"]
	\	Sleep 	2.0
	\	ath wait until loaded 	30
	\	Capture Page Screenshot
	${status}	run Keyword and return status	ath verify element is visible	//*[text()="${fileName}"]/ancestor::tr/descendant::button[contains(text(),'Unshare first')]
	Should not be true	${status}
	Logout from Application

