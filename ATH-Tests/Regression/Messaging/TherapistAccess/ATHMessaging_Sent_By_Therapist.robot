*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	${EXECDIR}../../ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf

***Test Cases***
MessagingTherapist_031
#Select one move to trash
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Select checkbox of first Message
	Messaging.Sent.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

MessagingTherapist_032
#Select all move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Sent Menu
	Messaging.Sent.Select all Messages
	Messaging.Sent.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

MessagingTherapist_033
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Sent Menu
	Messaging.Sent.Select all Messages
	Messaging.Sent.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

# MessagingTherapist_037
# #Sort From
# 	Messaging.Sort To Column

# MessagingTherapist_038
# #Sort Subject
# 	Messaging.Sort Subject Column

# MessagingTherapist_039
# #Sort Date
# 	Messaging.Sort Date Column

MessagingTherapist_040
#Sort Time
	Messaging.Sort Time Column

MessagingTherapist_034
	Move to Next Page

MessagingTherapist_035
#move to previous page
	Move to Previous Page

MessagingTherapist_036
#move to selected page
	Select Page Number	2
	Logout from Application

