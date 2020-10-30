** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/NotepadPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${NotepadBody}	automation client note
${ProviderLive}	Automation IsClient
${ProviderSecure}	Ginger Taylor
${NotepadBody2}	automation Note2

***Test Cases***
ATHSettings_Notepad_VerifyNotepadPageDisplay_ByClient

	${date}	Generate Date and Time Today
	${dateadd} 	Add/Subtract Days from Input Date 	${date} 	ADD 	0
	${yr}	${month}	${day}	split string 	${dateadd}	separator=-
	${iszero}	Fetch From Left 	${day}	0
	${stringFrom}	Run Keyword if	"${iszero}" == "${EMPTY}"	Replace String	${day}	0	${EMPTY}	ELSE	Set Variable	${day}
	Set Suite variable 	${stringFrom}

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Sleep 	20.0
	Select Notepad Menu
	ath click link 	Notes Page
	ClientRole.Verify Notepad Page Displayed

# ATHSettings_Notepad_CreateNotes_SharedWithProvider_ByClient
# 	Notepad.Input New Note Details	${NotepadBody}
# 	Notepad.Click Save Note
# 	Notepad.Verify Notepad Details Displayed in Table 	${NotepadBody}
# 	Run Keyword if	"${TestEnv}" == "Secure"	Notepad.SharedWithProvider.Verify Provider Name Is displayed 	${ProviderSecure} 	${NotepadBody} 	ELSE 	Notepad.SharedWithProvider.Verify Provider Name Is displayed 	${ProviderLive} 	${NotepadBody}
# 	Notepad.SharedWithProvider.Verify Note Details Is displayed	${NotepadBody}


# ATHSettings_Notepad_EditSavedNote_ByClient
# 	Notepad.Edit Saved Notepad Detail	${NotepadBody}
# 	Notepad.Verify Edit Notepad Widget Displayed
# 	${editInput}	Generate Random String	8	[LETTERS][NUMBERS]
# 	Notepad.ClientRole.Input Edit Notepad Entry	${editInput}
# 	Notepad.Click Save Note
# 	Notepad.Verify Notepad Details Displayed in Table 	${editInput}
# 	Notepad.Edit Saved Notepad Detail	${editInput}
# 	${string}	Notepad.ClientRole.Get Edited Text from Notepad
# 	Set Suite Variable	${string}

# ATHSettings_Notepad_CreateNotes_uncheckSharedWithProvider_ByClient
# 	Select Dashboard Menu
# 	Select Notepad Menu
# 	ath click link 	Notes Page
# 	Notepad.Input New Note Details	${NotepadBody2}
# 	Notepad.Check Share this Note with Provider checkbox
# 	Capture Page Screenshot
# 	Notepad.Click Save Note
# 	Notepad.Verify Notepad Details Displayed in Table 	${NotepadBody2}
# 	${status}	Run Keyword and Return Status	Run Keyword if	"${TestEnv}" == "Secure"	Notepad.SharedWithProvider.Verify Provider Name Is displayed 	${ProviderSecure}	${NotepadBody2}	ELSE 	Notepad.SharedWithProvider.Verify Provider Name Is displayed 	${ProviderLive} 	${NotepadBody2}
# 	Run Keyword and Continue on Failure 	Should not be True 	${status}
# 	Capture Page Screenshot

# ATHSettings_Notepad_SelectRecordsPerPage_ByClient
# 	Notepad.MyNotes.Select Records per Page 	100
# 	Capture Page Screenshot


# ATHSettings_Notepad_NextAndPreviousDisplayed_ByClient
# 	Move to Next Page
# 	Move to Previous Page

# ATHSettings_Notepad_VerifyMyNotesColumnDisplay_ByClient
# 	Notepad.MyNotes.Verify Header Column Display 	Note
# 	Notepad.MyNotes.Verify Header Column Display 	Created
# 	Notepad.MyNotes.Verify Header Column Display 	Actions

# ATHSettings_Notepad_SortNoteColumn_ByClient
# 	Notepad.MyNotes.Sort Note Column

# ATHSettings_Notepad_SortCreatedColumn_ByClient
# 	Notepad.MyNotes.Sort Created Column


# ATHSettings_Notepad_DeleteSavedNote_ByClient
# 	Notepad.Delete Saved Notepad Detail 	${NotepadBody2}
# 	Notepad.Verify Notepad deleted successfully

# ATHSettings_Notepad_SearchNotepadEntry_ByClient
# 	#cleanup
# 	Notepad.MyNotes.Input Search Criteria	${string}
# 	${status}	Run Keyword and Return Status 	Notepad.Verify Notepad Data Table is Empty
# 	Run Keyword and Continue on Failure 	Should not be True 	${status}
# 	Notepad.Delete Saved Notepad Detail 	${string}
# 	Notepad.Verify Notepad deleted successfully
# 	Notepad.Verify Notepad Data Table is Empty
# 	Capture Page Screenshot
# 	Logout from Application
