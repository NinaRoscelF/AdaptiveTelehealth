*** Settings ***
Resource	C:/Adaptive_Telehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:/Adaptive_Telehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf

***Test Cases***
MessagingSupervisor_013
#Select an unread and verify
	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Inbox Menu
	${status}	Run Keyword and Return Status	Messaging.Inbox.Read Nessage	unread
	Run Keyword unless	${status}	Messaging.Inbox.Select Read message
	Run Keyword unless	${status}	Messaging.Inbox.Click Read/Unread Icon
	Run Keyword unless	${status}	Messaging.Inbox.Read Nessage	unread
	Messaging.Inbox.Verify Message Details and Reply Button Is Visible
	Messaging.Inbox.Verify Font is Normal Style
	Capture Page Screenshot

MessagingSupervisor_030
#reply close window
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Close button

MessagingSupervisor_029
#reply save to draft window
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Save to Draft button
	Messaging.Confirm Draft Message Saved successfully


MessagingSupervisor_028
#reply send
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Send button
	Messaging.Confirm Message Sent successfully


MessagingSupervisor_016
#Select all and tag all
	${isUnread}	Messaging.Inbox.Get Read/Unread Messages Count	read
	Capture Page Screenshot
	Messaging.Inbox.Select all Messages
	Messaging.Inbox.Click Read/Unread Icon
	${isnewUnread}	Messaging.Inbox.Verify Messages were read/unread	${isUnread}


MessagingSupervisor_014
#Select unread and tag as read
	${isUnread}	Messaging.Inbox.Get Read/Unread Messages Count 	unread
	Messaging.Inbox.Select Unread message
	Messaging.Inbox.Select Unread message	index=2
	Messaging.Inbox.Select Unread message	index=3
	Capture Page Screenshot
	Messaging.Inbox.Click Read/Unread Icon
	Messaging.Inbox.Verify Messages were read/unread	${isUnread}	unread


MessagingSupervisor_015
#Select read adn tag as unread
	${isUnread}	Messaging.Inbox.Get Read/Unread Messages Count	read
	Messaging.Inbox.Select Read message
	Messaging.Inbox.Select Read message	index=2
	Messaging.Inbox.Select Read message	index=3
	Capture Page Screenshot
	Messaging.Inbox.Click Read/Unread Icon
	${isnewUnread}	Messaging.Inbox.Verify Messages were read/unread	${isUnread} 	read


MessagingSupervisor_017
#Select one move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Inbox.Select checkbox of first Message
	Messaging.Inbox.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

MessagingSupervisor_018
#Select all move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Inbox Menu
	Messaging.Inbox.Select all Messages
	Messaging.Inbox.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

MessagingSupervisor_019
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Inbox Menu
	Messaging.Inbox.Select all Messages
	Messaging.Inbox.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

# MessagingSupervisor_023
# #Sort From
# 	Messaging.Sort From Column

# MessagingSupervisor_024
# #Sort Subject
# 	Messaging.Sort Subject Column

MessagingSupervisor_025
#Sort Date
	Messaging.Sort Date Column

MessagingSupervisor_026
#Sort Time
	Messaging.Sort Time Column

MessagingSupervisor_027
#Sort Status
	Messaging.Sort Status Column

MessagingSupervisor_022
#move to next page
#Pre-req ensure inbox has multiple records
	Reload Page
	Messaging.Select Trash Menu
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Confirm Restore Action
	Messaging.Select Inbox Menu
	Select Page Number	2

MessagingSupervisor_021
#move to previous page
	ath wait until loaded	30
	Move to Previous Page

MessagingSupervisor_020
#move to next page
	Move to Next Page
	Logout from Application