*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf

***Test Cases***
MessagingClient_013
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Inbox Menu
#Select an unread and verify
	Messaging.Inbox.Reply To Unread Nessage	Automation Message
	Messaging.Inbox.Verify Message Details and Reply Button Is Visible
	Messaging.Inbox.Verify Font is Normal Style


MessagingClient_030
#reply close window
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Close button

MessagingClient_029
#reply save to draft window
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Save to Draft button
	Messaging.Confirm Draft Message Saved successfully


MessagingClient_028
#reply send
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Send button
	Run Keyword and Ignore Error	Messaging.Confirm Message Sent successfully


MessagingClient_016
#Select all and tag all
	Sleep 	2.0
	${isUnread}	Messaging.Inbox.Get Read/Unread Messages Count	Read
	Capture Page Screenshot
	Messaging.Inbox.Select all Messages

	Messaging.Inbox.Click Read/Unread Icon

	Sleep 	5.0
	${isnewUnread}	Messaging.Inbox.Verify Messages were read/unread	${isUnread}


MessagingClient_014
#Select unread and tag as read
	${isUnread}	Messaging.Inbox.Get Read/Unread Messages Count 	Unread
	Capture Page Screenshot
	RUn Keyword If 	${isunread} == 0 	Messaging.Inbox.Select Read message	ELSE	Messaging.Inbox.Select Unread message
	RUn Keyword If 	${isunread} == 0 	Messaging.Inbox.Select Read message	Read	True	2	ELSE	Messaging.Inbox.Select Unread message	Unread	True	2
	RUn Keyword If 	${isunread} == 0 	Messaging.Inbox.Select Read message	Read	True	3	ELSE	Messaging.Inbox.Select Unread message	Unread	True	3

	Capture Page Screenshot
	Messaging.Inbox.Click Read/Unread Icon
	Capture Page Screenshot
	Sleep 	5.0
	Messaging.Inbox.Verify Messages were read/unread	${isUnread}	Unread


MessagingClient_015
#Select read adn tag as unread
	${isRead}	Messaging.Inbox.Get Read/Unread Messages Count	Read
	RUn Keyword If 	${isRead} == 0 	Messaging.Inbox.Select Unread message	ELSE	Messaging.Inbox.Select Read message
	RUn Keyword If 	${isRead} == 0 	Messaging.Inbox.Select Unread message	Unread	True	2	ELSE	Messaging.Inbox.Select Read message	Read	True	2
	RUn Keyword If 	${isRead} == 0 	Messaging.Inbox.Select Unread message	Unread	True	3	ELSE	Messaging.Inbox.Select Read message	Read	True	3
	Capture Page Screenshot
	Messaging.Inbox.Click Read/Unread Icon
	Capture Page Screenshot
	Sleep 	5.0
	${isnewUnread}	Messaging.Inbox.Verify Messages were read/unread	${isRead}	Read


MessagingClient_017
#Select one move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Inbox.Select checkbox of first Message
	Messaging.Inbox.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu

MessagingClient_018
#Select all move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Inbox Menu
	Messaging.Inbox.Select all Messages
	Messaging.Inbox.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu

MessagingClient_019
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Inbox Menu
	Messaging.Inbox.Select all Messages
	Messaging.Inbox.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

# # # MessagingClient_023
# # # #Sort From
# # # 	Messaging.Sort From Column

# # # MessagingClient_024
# # # #Sort Subject
# # # 	Messaging.Sort Subject Column

# # MessagingClient_025
# # #Sort Date
# # 	Messaging.Sort Date Column

MessagingClient_026
#Sort Time
	Messaging.Sort Time Column

MessagingClient_027
#Sort Status
	Messaging.Sort Status Column

MessagingClient_022
#move to next page
#Pre-req ensure inbox has multiple records
	Reload Page
	Messaging.Select Trash Menu
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Confirm Restore Action
	Messaging.Select Inbox Menu
	Select Page Number	2

MessagingClient_021
#move to previous page
	ath wait until loaded	30
	Move to Previous Page

MessagingClient_020
#move to selected page
	Move to Next Page
	Logout from Application