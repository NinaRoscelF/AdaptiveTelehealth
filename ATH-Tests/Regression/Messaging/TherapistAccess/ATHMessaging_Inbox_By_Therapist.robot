*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf

***Test Cases***
MessagingTherapist_013
#Select an unread and verify
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Inbox Menu
	# ${status}	Run Keyword and Return Status	Messaging.Inbox.Read Nessage	unread
	# Run Keyword unless	${status}	Messaging.Inbox.Select Read message
	# Run Keyword unless	${status}	Messaging.Inbox.Click Read/Unread Icon
	# Run Keyword unless	${status}	Messaging.Inbox.Read Nessage	unread
	Messaging.Inbox.Reply To Unread Nessage	Automation Message
	Messaging.Inbox.Verify Message Details and Reply Button Is Visible
	Messaging.Inbox.Verify Font is Normal Style
	Capture Page Screenshot

MessagingTherapist_030
#reply close window
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Close button

MessagingTherapist_029
#reply save to draft window
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Save to Draft button
	Sleep 	15.0 	wait for confirmation message
	ath wait until loaded	30
	Messaging.Confirm Draft Message Saved successfully


MessagingTherapist_028
#reply send
	Messaging.Inbox.Click Reply Button
	Messaging.Reply.Input Reply Message	Auto Reply Message
	Messaging.Reply.Click Send button
	Sleep 	15.0 	wait for confirmation message
	ath wait until loaded	30
	Messaging.Confirm Message Sent successfully


MessagingTherapist_016
#Select all and tag all
	${isUnread}	Messaging.Inbox.Get Read/Unread Messages Count	read
	Capture Page Screenshot
	Messaging.Inbox.Select all Messages
	Capture Page Screenshot
#	ath click icon	xpath=//div[@id='Inbox']//button[2]
	ath click icon	xpath=(//i[@class="fa fa-envelope"])[2]
	Capture Page Screenshot
	Sleep 	60.0	wait for confirmation message
	ath wait until loaded	30
	${isnewUnread}	Messaging.Inbox.Verify Messages were read/unread	${isUnread}
	Capture Page Screenshot

MessagingTherapist_014
#Select unread and tag as read
	${isUnread}	Messaging.Inbox.Get Read/Unread Messages Count 	unread
	Capture Page Screenshot
	RUn Keyword If 	${isunread} == 0 	Messaging.Inbox.Select Read message	ELSE	Messaging.Inbox.Select Unread message
	RUn Keyword If 	${isunread} == 0 	Messaging.Inbox.Select Read message	read	True	2	ELSE	Messaging.Inbox.Select Unread message	unread	True	2
	RUn Keyword If 	${isunread} == 0 	Messaging.Inbox.Select Read message	read	True	3	ELSE	Messaging.Inbox.Select Unread message	unread	True	3

	Capture Page Screenshot
#	Messaging.Inbox.Click Read/Unread Icon
	ath click icon	xpath=(//i[@class="fa fa-envelope"])[2]
	Capture Page Screenshot
	Sleep 	60.0	wait for confirmation message
	ath wait until loaded	30
	Messaging.Inbox.Verify Messages were read/unread	${isUnread}	unread


MessagingTherapist_015
#Select read adn tag as unread
	${isRead}	Messaging.Inbox.Get Read/Unread Messages Count	read
	RUn Keyword If 	${isRead} == 0 	Messaging.Inbox.Select Unread message	ELSE	Messaging.Inbox.Select Read message
	RUn Keyword If 	${isRead} == 0 	Messaging.Inbox.Select Unread message	uread	True	2	ELSE	Messaging.Inbox.Select Read message	read	True	2
	RUn Keyword If 	${isRead} == 0 	Messaging.Inbox.Select Unread message	uread	True	3	ELSE	Messaging.Inbox.Select Read message	read	True	3
	Capture Page Screenshot
	ath click icon	xpath=(//i[@class="fa fa-envelope"])[2]
	Capture Page Screenshot
	Sleep 	60.0	wait for confirmation message
	ath wait until loaded	30
	${isnewUnread}	Messaging.Inbox.Verify Messages were read/unread	${isRead}	read


MessagingTherapist_017
#Select one move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Inbox.Select checkbox of first Message
	Messaging.Inbox.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

MessagingTherapist_018
#Select all move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Inbox Menu
	Messaging.Inbox.Select all Messages
	Messaging.Inbox.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu


MessagingTherapist_019
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Inbox Menu
	Messaging.Inbox.Select all Messages
	Messaging.Inbox.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

MessagingTherapist_025
#Sort Date
	Messaging.Sort Date Column

MessagingTherapist_026
#Sort Time
	Messaging.Sort Time Column

MessagingTherapist_027
#Sort Status
	Messaging.Sort Status Column
MessagingTherapist_022
#move to selected page
#Pre-req ensure inbox has multiple records
	Reload Page
	Messaging.Select Trash Menu
	Messaging.Trash.Select all Messages
	Messaging.Trash.Click Restore Icon
	Messaging.Trash.Confirm Restore Action
	Messaging.Select Inbox Menu
	Select Page Number	2

MessagingTherapist_021
#move to previous page
	ath wait until loaded	30
	Move to Previous Page

MessagingTherapist_020
#move to next page
	Move to Next Page

# MessagingTherapist_023
# #Sort From
# 	Messaging.Sort From Column

# MessagingTherapist_024
# #Sort Subject
# 	Messaging.Sort Subject Column

	Logout from Application