*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
MessagingSupervisor_055
#Select one move to trash
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Trash Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Trash.Select checkbox of first Message
	Messaging.Trash.Click Delete Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted


MessagingSupervisor_056
#Select all move to trash
#	Pre-req
	Messaging.Select Sent Menu
	Messaging.Sent.Select all Messages
	Messaging.Sent.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted

	Messaging.Select Trash Menu
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Delete Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted


MessagingSupervisor_057
#Cancel move to trash

	Messaging.Select Trash Menu
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Delete Icon
	Messaging.Cancel Delete Action


MessagingSupervisor_068
#restore and cancel
	Messaging.Trash.Select checkbox of first Message
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Cancel Restore Action


MessagingSupervisor_066
#continue restore on selected
	Messaging.Trash.Select all Messages
	Messaging.Trash.Select checkbox of first Message
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Confirm Restore Action
	Messaging.Confirm Message is Restored

MessagingSupervisor_067
#restore all msgs on page
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Confirm Restore Action
	Messaging.Confirm Message is Restored

# MessagingSupervisor_061
# #Sort From
# 	Messaging.Sort To Column

# MessagingSupervisor_062
# #Sort Subject
# 	Messaging.Sort Subject Column

# MessagingSupervisor_063
# #Sort Date
# 	Messaging.Sort Date Column

MessagingSupervisor_064
#Sort Time
	Messaging.Sort Time Column

MessagingSupervisor_065
#Sort Status
	Messaging.Sort Status Column

MessagingSupervisor_058
	Move to Next Page

MessagingSupervisor_059
#move to previous page
	Move to Previous Page

MessagingSupervisor_060
#move to selected page
	Select Page Number	2
	Logout from Application



