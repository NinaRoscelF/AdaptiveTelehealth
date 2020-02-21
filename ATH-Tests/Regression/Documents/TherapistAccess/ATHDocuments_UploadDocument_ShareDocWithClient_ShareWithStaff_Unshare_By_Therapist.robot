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
	Documents.Select Upload Document Menu
	Documents.Verify Upload Document Page Displayed
	Documents.Choose File	${UploadFile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select Share Document With	Share with Client	${client}
	Documents.Click Share Document
	Documents.Verify Document Shared successfully
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	Documents.MyDocument.Verify Unshare Button Exists
	Documents.MyDocument.Verify Document is Shared with Client	${client}

ATHDocuments_UploadDocument_ShareDocumentWithStaff_By_Therapist
	Documents.Select Upload Document Menu
	Documents.Select Share Document With	Share with Staff	${staff}
	Documents.Click Share Document
	Documents.Verify Document Shared successfully
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify Document is Shared with Client	${staff}

ATHDocuments_UploadDocument_UnshareDocument_By_Therapist
	Documents.MyDocument.Verify Unshare first to delete Button Exists
	Documents.MyDocument.Verify Unshare First Button Exists for File	${fileName}
	Documents.MyDocument.Unshare Document 	${fileName}
	Documents.MyDocuments.Verify Document is Unshared 	${fileName}
	Logout from Application

