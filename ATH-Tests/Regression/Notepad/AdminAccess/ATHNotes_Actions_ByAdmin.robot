** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/NotepadPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${NotepadBody}	Automation Body Notepad
${NotepadBody2}	FullDetail Notepad

***Test Cases***
ATHSettings_Notepad_VerifyNotepadPageDisplay_ByAdmin

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Select Notepad Menu
	TherapistRole.Verify Notepad Page Displayed
	Capture Page Screenshot
	${date}	Generate Date and Time Today
	${dateadd} 	Add/Subtract Days from Input Date 	${date} 	ADD 	1
	${yr}	${month}	${day}	split string 	${dateadd}	separator=-
	${iszero}	Fetch From Left 	${day}	0
	${stringFrom}	Run Keyword if	"${iszero}" == "${EMPTY}"	Replace String	${day}	0	${EMPTY}	ELSE	Set Variable	${day}
	Set Suite variable 	${stringFrom}

ATHSettings_Notepad_Verify Create Notepad Elements_ByAdmin
	Notepad.Verify Notepad Detail Inputs

ATHSettings_Notepad_SaveEmptyNote_ByAdmin
	Notepad.Click Save Note
	check label existence	The Note field is required

ATHSettings_Notepad_SaveNoteWithoutField_ByAdmin
	Notepad.Input New Note Title 	Automation Note Title
	Notepad.Click Save Note
	check label existence	The Note field is required

ATHSettings_Notepad_SaveNoteWithoutTitle_ByAdmin
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

ATHSettings_Notepad_EditSavedNote_ByClient
	${editInput}	Generate Random String	8	[LETTERS][NUMBERS]
	Set Suite Variable	${editInput}

	Notepad.Edit Saved Notepad Detail	${NotepadBody}
	Notepad.Verify Edit Notepad Widget Displayed
	Notepad.Input Edit Note Title	${editInput}
	Notepad.Input Reminder Alert Date	${stringFrom}
	Notepad.Click Save Note
	Go Back
	Notepad.Verify Notepad Details Displayed in Table 	${editInput}
	Notepad.Edit Saved Notepad Detail	${editInput}

	# ${string}	Notepad.Get Edited Text from Notepad
	# Set Suite Variable	${string}


ATHSettings_Notepad_SaveNoteWithAllFields_ByAdmin
	Select Dashboard Menu
	Select Notepad Menu
	Notepad.Input New Note Title 	Automation Note Title
	Notepad.Input New Note Body 	${NotepadBody2}
	Notepad.Input Reminder Alert Date	${stringFrom}
	Run Keyword if	"${TestEnv}" == "Secure"	Notepad.Input Tags 	trial 	ELSE 	Notepad.Input Tags	tags
	${inputTag}	Generate Random String	8	[LETTERS]
	Notepad.Input New Tags 	${inputTag}
	Capture Page Screenshot
	Notepad.Click Save Note
	Notepad.Verify Notepad Details Displayed in Table 	${NotepadBody2}
	Capture Page Screenshot


ATHSettings_Notepad_SelectRecordsPerPage_ByAdmin
	Notepad.MyNotes.Select Records per Page 	100
	Capture Page Screenshot


ATHSettings_Notepad_NextAndPreviousDisplayed_ByAdmin
	Move to Next Page
	Move to Previous Page

ATHSettings_Notepad_VerifyMyNotesColumnDisplay_ByClient
	Notepad.MyNotes.Verify Header Column Display 	Note
	Notepad.MyNotes.Verify Header Column Display 	Created
	Notepad.MyNotes.Verify Header Column Display 	Actions

ATHSettings_Notepad_SortNoteColumn_ByClient
	Notepad.MyNotes.Sort Note Column

ATHSettings_Notepad_SortCreatedColumn_ByClient
	Notepad.MyNotes.Sort Created Column

ATHSettings_Notepad_DeleteCreatedNote_ByAdmin
	Notepad.Delete Saved Notepad Detail 	${editInput}
	Notepad.Verify Notepad deleted successfully
	Capture Page Screenshot
#cleanup
ATHSettings_Notepad_SearchNotepadEntry_ByAdmin
	#cleanup
	Notepad.MyNotes.Input Search Criteria	${NotepadBody2}
	${status}	Run Keyword and Return Status 	Notepad.Verify Notepad Data Table is Empty
	Run Keyword and Continue on Failure 	Should not be True 	${status}
	Notepad.Delete Saved Notepad Detail	${NotepadBody2}
	Notepad.Verify Notepad deleted successfully
	Notepad.Verify Notepad Data Table is Empty
	Capture Page Screenshot

	Logout from Application
