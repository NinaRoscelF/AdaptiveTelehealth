** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/NotepadPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${NotepadBody}	Automation Body Notepad
${NotepadBody2}	FullDetail Notepad

***Test Cases***
ATHSettings_Notepad_VerifyNotepadPageDisplay_ByTherapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Select Notepad Menu
	TherapistRole.Verify Notepad Page Displayed
	Capture Page Screenshot
	${date}	Generate Date and Time Today
	${dateadd} 	Add/Subtract Days from Input Date 	${date} 	ADD 	2
	${yr}	${month}	${day}	split string 	${dateadd}	separator=-
	${iszero}	Fetch From Left 	${day}	0
	${stringFrom}	Run Keyword if	"${iszero}" == "${EMPTY}"	Replace String	${day}	0	${EMPTY}	ELSE	Set Variable	${day}
	Set Suite variable 	${stringFrom}

ATHSettings_Notepad_Verify Create Notepad Elements_ByTherapist
	Notepad.Verify Notepad Detail Inputs

ATHSettings_Notepad_SaveEmptyNote_ByTherapist
	Notepad.Click Save Note
	check label existence	The Note field is required

ATHSettings_Notepad_SaveNoteWithoutField_ByTherapist
	Notepad.Input New Note Title 	Automation Note Title
	Notepad.Click Save Note
	check label existence	The Note field is required

ATHSettings_Notepad_SaveNoteWithoutTitle_ByTherapist
	sleep 	3.0
	Clear Element Text 	xpath=//input[@id='notes_title']
	Capture Page Screenshot
	Reload Page
	Notepad.Input Reminder Alert Date	${stringFrom}
	Notepad.Input New Note Body	${NotepadBody}
	${inputTag}	Generate Random String	8	[LETTERS]
	Notepad.Input New Tags 	${inputTag}
	Notepad.Click Save Note
	Capture Page Screenshot
	Sleep 	15.0
	ath wait until loaded 	30
	Notepad.Verify Notepad Details Displayed in Table 	${NotepadBody}
	Capture Page Screenshot

ATHSettings_Notepad_DeleteCreatedNote_ByTherapist
	Notepad.Delete Saved Notepad Detail 	${NotepadBody}
	Notepad.Verify Notepad deleted successfully
	Notepad.Verify Notepad Data Table is Empty
	Capture Page Screenshot

ATHSettings_Notepad_SaveNoteWithAllFields_ByTherapist

	Notepad.Input New Note Title 	Automation Note Title
	Notepad.Input New Note Body 	${NotepadBody2}
	Notepad.Input Reminder Alert Date	${stringFrom}
	Notepad.Input Tags 	Automation New tag
	${inputTag}	Generate Random String	8	[LETTERS]
	Notepad.Input New Tags 	${inputTag}
	Capture Page Screenshot
	Notepad.Click Save Note
	Notepad.Verify Notepad Details Displayed in Table 	${NotepadBody2}
	Capture Page Screenshot

ATHSettings_Notepad_SearchNotepadEntry_ByTherapist
	#cleanup
	Notepad.MyNotes.Input Search Criteria	${NotepadBody2}
	${status}	Run Keyword and Return Status 	Notepad.Verify Notepad Data Table is Empty
	Run Keyword and Continue on Failure 	Should not be True 	${status}

ATHSettings_Notepad_SelectRecordsPerPage_ByTherapist
	Notepad.MyNotes.Select Records per Page 	100
	Capture Page Screenshot


ATHSettings_Notepad_NextAndPreviousDisplayed_ByTherapist
	Move to Next Page
	Move to Previous Page

#cleanup
	Notepad.Delete Saved Notepad Detail	${NotepadBody2}
	Notepad.Verify Notepad deleted successfully
	Notepad.Verify Notepad Data Table is Empty
	Capture Page Screenshot

	Logout from Application
