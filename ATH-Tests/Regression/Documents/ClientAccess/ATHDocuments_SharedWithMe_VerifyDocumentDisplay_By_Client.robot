*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${ClientName}	Mary
${sharedFile}	dummy1.pdf
${Filesize}	12.95 KB

***Test Cases***
ATHDocuments_SharedWithMe_VerifyDocumentDisplay_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Documents Menu
	Documents.Select Shared with Me Menu
	Documents.Verify Header Column Display	Shared by
	Documents.Verify Header Column Display	Documents
	Documents.Verify Header Column Display	Date Shared
	Documents.MyDocument.Verify File Uploaded Exists	${sharedFile}
	Documents.MyDocument.Verify Document is Shared with Client	${ClientName} 	${sharedFile}
	Capture Page Screenshot

	Logout from Application

