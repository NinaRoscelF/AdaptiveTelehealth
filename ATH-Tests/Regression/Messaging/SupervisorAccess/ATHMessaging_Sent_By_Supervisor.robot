*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
MessagingSupervisor_031
#Select one move to trash
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Sent Menu
	Sleep 	5.0
	ath wait until loaded 	30
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Select checkbox of first Message
	Messaging.Sent.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

MessagingSupervisor_032
#Select all move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Sent Menu
	Messaging.Sent.Select all Messages
	Messaging.Sent.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

# MessagingSupervisor_037
# #Sort From
# 	Messaging.Sort To Column

# MessagingSupervisor_038
# #Sort Subject
# 	Messaging.Sort Subject Column

# MessagingSupervisor_039
# #Sort Date
# 	Messaging.Sort Date Column

MessagingSupervisor_040
#Sort Time
	Messaging.Sort Time Column
MessagingSupervisor_033
	Messaging.Select Trash Menu
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Confirm Restore Action
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Sent Menu
	Messaging.Sent.Select all Messages
	Messaging.Sent.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

MessagingSupervisor_034
	Move to Next Page

MessagingSupervisor_035
#move to previous page
	Move to Previous Page

MessagingSupervisor_036
#move to selected page
	Select Page Number	2
	Logout from Application

