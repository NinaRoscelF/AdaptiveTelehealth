*** Settings ***
Resource	C:/Adaptive_Telehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***


***Test Cases***
MessagingTherapist_055
#Select one move to trash
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Trash Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Trash.Select checkbox of first Message
	Messaging.Trash.Click Delete Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted


MessagingTherapist_056
#Select all move to trash
#	Pre-req
	Messaging.Select Inbox Menu
	Messaging.Inbox.Select all Messages
	Messaging.Inbox.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash


	${DTToday}	Generate Date and Time Today
	Messaging.Select Trash Menu
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Delete Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Permanently Deleted


MessagingTherapist_057
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Trash Menu
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Delete Icon
	Messaging.Cancel Delete Action


MessagingTherapist_068
#restore and cancel
	Messaging.Trash.Select checkbox of first Message
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Cancel Restore Action


MessagingTherapist_066
#continue restore on selected
	Messaging.Trash.Select checkbox of first Message
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Confirm Restore Action
	Messaging.Confirm Message is Restored

MessagingTherapist_067
#restore all msgs on page
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Confirm Restore Action
	Messaging.Confirm Message is Restored

# MessagingTherapist_061
# #Sort From
# 	Messaging.Sort To Column

# MessagingTherapist_062
# #Sort Subject
# 	Messaging.Sort Subject Column

MessagingTherapist_063
#Sort Date
	Messaging.Sort Date Column

MessagingTherapist_064
#Sort Time
	Messaging.Sort Time Column

MessagingTherapist_065
#Sort Status
	Messaging.Sort Status Column

MessagingTherapist_058
	Move to Next Page

MessagingTherapist_059
#move to previous page
	Move to Previous Page

MessagingTherapist_060
#move to selected page
	Select Page Number	2

	Logout from Application



