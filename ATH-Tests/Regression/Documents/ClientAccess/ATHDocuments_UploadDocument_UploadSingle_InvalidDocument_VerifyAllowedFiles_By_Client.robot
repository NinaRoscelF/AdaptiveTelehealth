*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\
${PDFFile}	dummy1.pdf
${HtmlFile}	InvalidFile.html
${FileType}	pdf


***Test Cases***
ATHDocuments_UploadDocument_UploadSingleDocument_By_Client

	@{FileList}	List Files In Directory	${Filelocation}	*.${FileType}
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	5
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	dummy${occnumber}
	Remove Files	${Filelocation}/*.${FileType}
	${PDFCreated}	Create PDF File	${Filelocation} 	${newfile}
	${uploadfile}	Catenate	${Filelocation}${newfile}.${FileType}
	${filename}	Catenate	${newfile}.${FileType}

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Documents Menu
	Documents.Select Upload Document Menu
	Documents.ClientRole.Verify Upload Document Page Displayed
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}

ATHDocuments_UploadDocument_NoFileSelectedForUpload_By_Client
	Documents.Click Add Document button
	Documents.Verify No Document Is Uploaded

ATHDocuments_UploadDocument_UploadInvalidDocument_By_Client
	Documents.Choose File	${Filelocation}${HtmlFile}
	Documents.Click Add Document button
	Documents.Verify Document is an Invalid filetype
	Capture Page Screenshot

ATHDocuments_UploadDocument_VerifyAllowedFiles_By_Client
	ath click link	xpath=(//*[normalize-space()="File extensions allowed"])[1]
	Documents.Verify Allowed file details
	Logout from Application

