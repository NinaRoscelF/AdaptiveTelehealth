*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\
${ClientName}	Beyonce
${TxtFile}	textFile.txt


***Test Cases***
ATHDocuments_UploadDocument_StoreinFileUser_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Documents.CleanUp	${TxtFile}
	Select Documents Menu
	Documents.Select Upload Document Menu
	Documents.Verify Upload Document Page Displayed
	Documents.Choose File	${Filelocation}${TxtFile}
	Documents.Select Store in File User	${ClientName}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${TxtFile}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${TxtFile}

	Select Documents Menu
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${TxtFile}
	Documents.Verify Stored on Column	${TxtFile}
	Capture Page Screenshot

ATHDocuments_MyDocuments_SortColumn_By_Therapist
	Documents.MyDocuments.Sort Documents Column
	Documents.MyDocuments.Sort Date Uploaded Column

ATHDocuments_MyDocuments_InputSearchCriteria_By_Therapist
	Documents.MyDocuments.Input Search Criteria	${TxtFile}
	Documents.MyDocuments.Click Enter to Search
	${status}	Run Keyword and Return Status	Document.MyDocuments.Verify No Results found
	Run Keyword and Continue on Failure	Should Not Be True	${status}

ATHDocuments_MyDocuments_Click File Link
	Document.MyDocuments.Click Document Filename	${TxtFile}
	Sleep 	3.0
	ath wait until loaded	30
	Select window 	New
	Document.MyDocuments.Verify Textfile opens in New Window
	Select window 	Main

ATHDocuments_MyDocuments_Select Records per Page
	Document.MyDocuments.Select Records per Page 	100
	Capture page Screenshot

ATHDocuments_MyDocuments_DeleteDocument_By_Therapist
	${DateFormat}	Generate Date and Time Today
	${DateAdd}	Add/Subtract Days from Input Date 	${DateFormat}	ADD	1 	%m/%d/%Y
	Documents.Click Delete button for Selected Document	${TxtFile}
	Documents.Confirm Deletion of Document	${TxtFile}
	Logout from Application

