*** Settings ***
Resource	C:/Adaptive_Telehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:/Adaptive_Telehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf

***Test Cases***
MessagingClient_031
#Select one move to trash
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Select checkbox of first Message
	Messaging.Sent.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

MessagingClient_032
#Select all move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Sent Menu
	Messaging.Sent.Select all Messages
	Messaging.Sent.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu
#	Messaging.Sent.Verify Message is Moved to Trash	${DTToday}

# MessagingClient_037
# #Sort From
# 	Messaging.Sort To Column

# MessagingClient_038
# #Sort Subject
# 	Messaging.Sort Subject Column

MessagingClient_039
#Sort Date
	Messaging.Sort Date Column

MessagingClient_040
#Sort Time
	Messaging.Sort Time Column
MessagingClient_033
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Sent Menu
	Messaging.Sent.Select all Messages
	Messaging.Sent.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

MessagingClient_034
	Move to Next Page

MessagingClient_035
#move to previous page
	Move to Previous Page

MessagingClient_036
#move to selected page
	Select Page Number	2
	Logout from Application

