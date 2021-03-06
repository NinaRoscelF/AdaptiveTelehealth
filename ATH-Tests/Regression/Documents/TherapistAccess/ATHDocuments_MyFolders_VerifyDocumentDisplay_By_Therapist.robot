*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DocumentPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${ClientName1}	Automation IsClient
${ClientName}	Ginger Taylor
${sharedFile}	dummy1.pdf
${Filesize}	12.95 KB

***Test Cases***
ATHDocuments_MyFolders_VerifyDocumentDisplay_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Documents Menu
	Documents.Select My Folders Menu
	Documents.MyFolders.Select My Folders Icon
	Documents.MyFolders.Verify Column Existence	Name
	Documents.MyFolders.Verify Column Existence	Date Created
	Capture Page Screenshot

	Documents.MyFolders.Select Document To Display	${sharedFile}
	Sleep 	10.0
	Documents.MyFolders.Verify Unshare before delete Button Exists
	Check Label Existence	Share with:,Unshare Documents:
	Documents.Verify Header Column Display 	Size
	Documents.Verify Header Column Display 	Stored on
	Documents.Verify Header Column Display 	Owner
	Documents.Verify Header Column Display 	Date Created
	Documents.MyFolders.Verify Document Details Displayed	${Filesize}
	Run Keyword if	"${TestEnv}" == "Secure"	Documents.MyFolders.Verify Document Details Displayed	${ClientName} 	ELSE	Documents.MyFolders.Verify Document Details Displayed	${ClientName1}
	Logout from Application

