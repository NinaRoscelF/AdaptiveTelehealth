*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${UploadFile}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\UploadtextFile.txt
${fileName}	UploadtextFile.txt
${client}	Beyonce
${staff}	Therapist

***Test Cases***
ATHDocuments_UploadDocument_ShareDocumentWithClient_By_Admin

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
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
	ath select radio button	Share with Client
	ath click icon	(//*[@name="client_id[]"]/descendant::option[contains(text(),'${client}')])[1]
	Documents.Click Share Document
	Documents.Verify Document Shared successfully
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	Documents.MyDocument.Verify Unshare Button Exists
	Documents.MyDocument.Verify Document is Shared with Client	${client}

ATHDocuments_UploadDocument_ShareDocumentWithStaff_By_Admin
	Documents.Select Upload Document Menu
	Documents.Select Share Document With	Share with Staff 	${staff}
	${sharedwith}	Get Element Attribute 	xpath=(//*[@name="client_id[]"]/option[contains(text(),'${staff}')])[1]@textContent
	${firstname}	Fetch From Left	${sharedwith} 	${SPACE}
	Documents.Click Share Document
	Documents.Verify Document Shared successfully
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify Document is Shared with Client	${firstname}

ATHDocuments_UploadDocument_UnshareDocument_By_Admin
	Documents.MyDocument.Verify Unshare first to delete Button Exists
	Documents.MyDocument.Verify Unshare First Button Exists for File	${fileName}
	Documents.MyDocument.Unshare Document 	${fileName}
	Documents.MyDocuments.Verify Document is Unshared 	${fileName}

	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}

	Logout from Application

