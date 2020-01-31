*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\
${PDFFile}	dummy1.pdf
${TxtFile}	textFile.txt
${JpegFile}	JPEGFile.jpg
${HtmlFile}	InvalidFile.html
${FileType}	pdf


***Test Cases***
ATHDocuments_UploadDocument_By_Therapist

	@{FileList}	List Files In Directory	${Filelocation}	*.${FileType}
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	5
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	dummy${occnumber}
	Remove Files	${Filelocation}/*.${FileType}
	${isfile}	Create File	${Filelocation}/${newfile}.${FileType}	3\nlines\nhere\nDummy PDF File
#	AH.Document.Create PDF File 	${Filelocation} 	${newfile}
	${uploadfile}	Catenate	${Filelocation}${newfile}.${FileType}
	${filename}	Catenate	${newfile}.${FileType}
	Set Suite Variable	${uploadfile}
	Set Suite Variable	${filename}

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Documents Menu
	ath click link 	Upload Document
	Documents.Verify Upload Document Page Displayed
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot

ATHDocuments_UploadMultipleDocument_By_Therapist
	Documents.Choose File	${uploadfile}
	Documents.Choose File	${Filelocation}${TxtFile}
	Documents.Choose File	${Filelocation}${JpegFile}
	Capture Page Screenshot
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}, ${TxtFile}, ${JpegFile}

ATHDocuments_UploadInvalidDocument_By_Therapist
	Documents.Choose File	${Filelocation}${HtmlFile}
	Documents.Click Add Document button
	Documents.Verify Document is an Invalid filetype
	Capture Page Screenshot
	Logout from Application

