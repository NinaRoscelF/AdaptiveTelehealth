** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/NotepadPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${NotepadBody}	automation client note
${ProviderLive}	Automation IsClient
${ProviderSecure}	Ginger Taylor
${NotepadBody2}	automation Note2

***Test Cases***
ATHNotepad_VerifyNotepadPageDisplay_ByClient

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Notepad Menu
	ClientRole.Select New Note link
	ClientRole.Verify New Note Page Displayed
	Check Link Existence	Proceed to Notes Page
	ClientRole.NewNotes.Verify Add Note button Exists

ATHNotepad_CancelInputNewNote_ByClient
	ClientRole.NewNotes.Cancel New Note Creation
	Capture Page Screenshot

ATHNotepad_InputNewNote_ByClient
#	Select Notepad Menu
	ClientRole.Select New Note link
	${stringFrom}	generate Random String
	Set Suite Variable	${stringFrom}
	ClientRole.NewNotes.Input a Note 	${stringFrom}
	ClientRole.NewNotes.Click Add a Note Button
	Capture Page Screenshot

ATHNotepad_ProceedToNotesPage_ByClient
	ClientRole.NewNotes.Click to Proceed to Notes Page link
	ClientRole.Verify Notepad Page Displayed
	Notepad.Verify Notepad Details Displayed in Table 	${stringFrom}
	Notepad.Delete Saved Notepad Detail 	${stringFrom}
	Notepad.Verify Notepad deleted successfully
	Logout from Application
