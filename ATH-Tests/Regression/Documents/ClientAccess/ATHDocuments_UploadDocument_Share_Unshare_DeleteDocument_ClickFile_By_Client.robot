*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${UploadFile}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\UploadtextFile.txt
${fileName}	UploadtextFile.txt
${client}	Mary Ellis
${client1}	Automation Therapist


***Test Cases***
ATHDocuments_UploadDocument_ShareDocumentWithProvider_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
##Pre-req Cleanup
	Documents.CleanUp	${fileName}
	Select Documents Menu
	Documents.Select Upload Document Menu
	Documents.ClientRole.Verify Upload Document Page Displayed
	Documents.Choose File	${UploadFile}
	Documents.Click Add Document button
	Sleep 	5.0
	ath wait until loaded 	30
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
#	Documents.Select Share Document With	Share with Provider	${client}
	Documents.Click Share Document
	Documents.Verify Document Shared successfully


ATHDocuments_UploadDocument_UnshareDocument_By_Client
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	Documents.MyDocument.Verify Unshare Button Exists
	Run Keyword if	"${TestEnv}" == "Secure"	Documents.MyDocument.Verify Document is Shared with Client	${client} 	ELSE 	Documents.MyDocument.Verify Document is Shared with Client	${client1}
	Documents.MyDocument.Verify Unshare first to delete Button Exists
	Documents.MyDocument.Verify Unshare First Button Exists for File	${fileName}
	Documents.MyDocument.Unshare Document	${fileName}
	Run Keyword and Ignore Error 	Perform Login Checks
	Documents.MyDocuments.Verify Document is Unshared	${fileName}

ATHDocuments_MyDocuments_Click File Link
	Run Keyword and Ignore Error 	Perform Login Checks
	Select Documents Menu
	Documents.Select My Documents Menu
	Document.MyDocuments.Click Document Filename	${fileName}
	Sleep 	3.0
	ath wait until loaded	30
	Select window 	New
	Document.MyDocuments.Verify Textfile opens in New Window
	Select window 	Main


ATHDocuments_MyDocuments_DeleteDocument_By_Client
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}
	Logout from Application


