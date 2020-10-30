*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${ClientName}	Ginger
${sharedFile}	dummy1.pdf
${Filesize}	12.95 KB

***Test Cases***
ATHDocuments_UploadedByClients_VerifyDocumentDisplay_By_Admin

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Perform Login Checks
	Select Documents Menu
	Documents.Select Uploaded by Clients Menu
	Documents.Verify Header Column Display	Client
	Documents.Verify Header Column Display	Shared with
	Documents.Verify Header Column Display	Document
	Documents.Verify Header Column Display	Size
	Documents.Verify Header Column Display	Date Uploaded
	Document.MyDocuments.Select Records per Page	100
	Documents.MyDocument.Verify File Uploaded Exists	${sharedFile}
	Documents.MyDocument.Verify Document is Shared with Client	${ClientName}
	Documents.UploadedByClients.Verify Document Size	${sharedFile}	${Filesize}
	Capture Page Screenshot

ATHDocuments_UploadedByClients_SelectRecordsPerPage_By_Admin
	Documents.UploadedByClients.Select Records per Page Value	100
	Capture Page Screenshot


ATHDocuments_UploadedByClients_SortDocumentColumn_By_Admin
	Documents.SharedWithMe.Sort Document Column
	Capture Page Screenshot

ATHDocuments_UploadedByClients_SortSizeColumn_By_Admin
	Documents.SharedWithMe.Sort Size Column
	Capture Page Screenshot

ATHDocuments_UploadedByClients_SortDateUploadedColumn_By_Admin
	Documents.MyDocuments.Sort Date Uploaded Column
	Capture Page Screenshot

ATHDocuments_UploadedByClients_InputDocumentName_SearchCriteria_By_Admin
	Documents.MyDocuments.Input Search Criteria 	${sharedFile}
	${status}	Run Keyword and Return Status	Document.MyDocuments.Verify No Results found
	Should Not Be True	${status}

ATHDocuments_UploadedByClients_InputSharedByName_SearchCriteria_By_Admin
	Documents.MyDocuments.Input Search Criteria 	${ClientName}
	${status}	Run Keyword and Return Status	Document.MyDocuments.Verify No Results found
	Should Not Be True	${status}

ATHDocuments_UploadedByClients_VerifyPreviousNextPageExists_By_Admin
	ath_check_links_displayed 	Previous
	ath_check_links_displayed 	Next

	Logout from Application

