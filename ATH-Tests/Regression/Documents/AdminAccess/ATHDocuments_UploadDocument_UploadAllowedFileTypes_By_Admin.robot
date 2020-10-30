*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\FileTypes\\
#txt, pdf, doc, docx, dot, dotx
#png, bmp, gif, jpg, jpeg, tif, tiff, wav, mov, mp4, webm

***Test Cases***
ATHDocuments_UploadDocument_UploadAllowedFileTypes_By_Admin

	@{FileList}	List Files In Directory	${Filelocation}	*.pdf
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	PDFFile_${occnumber}
	Remove Files	${Filelocation}/*.pdf
	${PDFCreated}	Create PDF File	${Filelocation} 	${newfile}
	${uploadfile}	Catenate	${Filelocation}${newfile}.pdf
	${filename}	Catenate	${newfile}.pdf


	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Perform Login Checks
	Select Documents Menu
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}

	@{FileList}	List Files In Directory	${Filelocation}	*.txt
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	9
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	textFile_${occnumber}
	Remove Files	${Filelocation}/*.txt
	${PDFCreated}	Create Sample File	${Filelocation} 	${newfile} 	txt
	${uploadfile}	Catenate	${Filelocation}${newfile}.txt
	${filename}	Catenate	${newfile}.txt
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}

	@{FileList}	List Files In Directory	${Filelocation}	*.doc
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	DocFile_${occnumber}
	${PDFCreated}	Create Sample File	${Filelocation} 	${newfile} 	doc
	${uploadfile}	Catenate	${Filelocation}${newfile}.doc
	${filename}	Catenate	${newfile}.doc
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}

	@{FileList}	List Files In Directory	${Filelocation}	*.docx
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	9
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	DocXFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile}
	${uploadfile}	Catenate	${Filelocation}${newfile}.docx
	${filename}	Catenate	${newfile}.docx
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}


	@{FileList}	List Files In Directory	${Filelocation}	*.png
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	PNGFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.png
	${filename}	Catenate	${newfile}.png
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}

	@{FileList}	List Files In Directory	${Filelocation}	*.bmp
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	BMPFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.bmp
	${filename}	Catenate	${newfile}.bmp
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}


	@{FileList}	List Files In Directory	${Filelocation}	*.gif
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	GIFFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.gif
	${filename}	Catenate	${newfile}.gif
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}


	@{FileList}	List Files In Directory	${Filelocation}	*.jpg
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	9
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	JPEGFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.jpg
	${filename}	Catenate	${newfile}.jpg
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}


	@{FileList}	List Files In Directory	${Filelocation}	*.tif
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	TifFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.tif
	${filename}	Catenate	${newfile}.tif
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}


	@{FileList}	List Files In Directory	${Filelocation}	*.wav
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	WAVFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.wav
	${filename}	Catenate	${newfile}.wav
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}


	@{FileList}	List Files In Directory	${Filelocation}	*.webm
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	9
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	WEBMFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.webm
	${filename}	Catenate	${newfile}.webm
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}


	@{FileList}	List Files In Directory	${Filelocation}	*.mp4
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	MP4File_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.mp4
	${filename}	Catenate	${newfile}.mp4
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}


	@{FileList}	List Files In Directory	${Filelocation}	*.mov
	${lastModifiedFile}	Get From List	${FileList}	0
	${stripfile}	${ext}	Split String	${lastModifiedFile}	separator=.
	${number}	Get Substring	${stripfile}	8
	${occnumber}	Evaluate	${number} + 1
	${newfile}	Set Variable	MOVFile_${occnumber}
	${Refilename}	Rename BOD Files	${Filelocation}	${lastModifiedFile}	${newfile} 	True
	${uploadfile}	Catenate	${Filelocation}${newfile}.mov
	${filename}	Catenate	${newfile}.mov
	Documents.Select Upload Document Menu
	Documents.Choose File	${uploadfile}
	Documents.Click Add Document button
	Documents.Verify Document is Uploaded Successfully	${filename}
	Capture Page Screenshot
	Documents.Verify Document is Available in dropdown	${filename}
	Documents.Select My Documents Menu
	Documents.MyDocument.Verify File Uploaded Exists	${fileName}
	#cleanup
	Documents.Click Delete button for Selected Document	${fileName}
	Documents.Confirm Deletion of Document	${fileName}

	Logout from Application

