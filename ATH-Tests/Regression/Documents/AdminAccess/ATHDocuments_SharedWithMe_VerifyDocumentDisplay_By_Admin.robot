*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${ClientName}	Automation Therapist
${ClientName1}	Mary Ellis
${sharedFile}	dummy1.pdf
${Filesize}	12.95 KB

***Test Cases***
ATHDocuments_SharedWithMe_VerifyDocumentDisplay_By_Admin

	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}
	Perform Login Checks
	Select Documents Menu
	Documents.Select Shared with Me Menu
	Documents.Verify Header Column Display	Shared by
	ath verify element Is Visible	//th[text()="Document "]
	ath verify element Is Visible	//th[text()="Size "]
	Documents.Verify Header Column Display	Date Uploaded
	Documents.MyDocument.Verify File Uploaded Exists	${sharedFile}
	Run Keyword if	"${TestEnv}" == "Secure"	Documents.MyFolders.Verify Document Details Displayed	${ClientName1} 	ELSE	Documents.MyFolders.Verify Document Details Displayed	${ClientName}
	Documents.MyDocument.Verify Document Size	${sharedFile}	${Filesize}
	Capture Page Screenshot

ATHDocuments_SharedWithMe_SelectRecordsPerPage_By_Admin
	Documents.SharedWithMe.Select Records per Page Value 	100
	Capture Page Screenshot


ATHDocuments_SharedWithMe_SortSharedByColumn_By_Admin
	Documents.SharedWithMe.Sort Shared By Column
	Capture Page Screenshot

ATHDocuments_SharedWithMe_SortDocumentColumn_By_Admin
	Documents.SharedWithMe.Sort Document Column
	Capture Page Screenshot

ATHDocuments_SharedWithMe_SortSizeColumn_By_Admin
	Documents.SharedWithMe.Sort Size Column
	Capture Page Screenshot

ATHDocuments_SharedWithMe_SortDateUploadedColumn_By_Admin
	Documents.MyDocuments.Sort Date Uploaded Column
	Capture Page Screenshot

ATHDocuments_SharedWithMe_InputDocumentName_SearchCriteria_By_Admin
	Documents.MyDocuments.Input Search Criteria 	${sharedFile}
	${status}	Run Keyword and Return Status	Document.MyDocuments.Verify No Results found
	Should Not Be True	${status}

ATHDocuments_SharedWithMe_InputSharedByName_SearchCriteria_By_Admin
	Run Keyword if	"${TestEnv}" == "Secure"	Documents.MyDocuments.Input Search Criteria	${ClientName1} 	ELSE 	Documents.MyDocuments.Input Search Criteria	${ClientName}
	${status}	Run Keyword and Return Status	Document.MyDocuments.Verify No Results found
	Should Not Be True	${status}

ATHDocuments_SharedWithMe_VerifyPreviousNextPageExists_By_Admin
	ath_check_links_displayed 	Previous
	ath_check_links_displayed 	Next

	Logout from Application

