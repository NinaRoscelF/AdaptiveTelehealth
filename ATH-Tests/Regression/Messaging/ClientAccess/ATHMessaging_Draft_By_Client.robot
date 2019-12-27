*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
#${Recipient2}	Meghan Ruiz ( Groups Supervisor )
${Recipient2}	Meghan Ruiz
${Recipient1}	Mary Ellis
${Recipient3}	testsupervisor adaptive

***Test Cases***

MessagingClient_044
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Draft Menu
	Move to Next Page

MessagingClient_045
#move to previous page
	Move to Previous Page

MessagingClient_046
#move to selected page
	Select Page Number	2
	Logout from Application

MessagingClient_041
#Select one move to trash
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Draft Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Draft.Select checkbox of first Message
	${mySubj}	Messaging.Draft.Get Subject Column of Selected Message
	Messaging.Draft.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu
	Messaging.Trash.Verify Message is Deleted	${mySubj}

MessagingClient_043
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Draft Menu
	Messaging.Draft.Select checkbox of first Message
	Messaging.Draft.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

MessagingClient_042
#Select all move to trash
	Messaging.Select Draft Menu
	Messaging.Draft.Select all Messages
	Messaging.Draft.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash

#Sort From
# MessagingClient_047
# #restore all msgs on page
# #Pre-req to restore deleted draft msgs
# 	Messaging.Select Trash Menu
# 	Messaging.Trash.Select all Messages
# 	Messaging.Trash.Click Restore Icon
# 	Messaging.Trash.Confirm Restore Action
# 	Messaging.Confirm Message is Restored
# 	Messaging.Select Draft Menu
# 	Messaging.Sort To Column

# MessagingClient_048
# #Sort Subject
# 	Messaging.Sort Subject Column

MessagingClient_049
#Sort Date
	Messaging.Sort Date Column

MessagingClient_050
#Sort Time
	Messaging.Sort Time Column


MessagingClient_051
#Expand Details
	Messaging.Draft.Expand First message
	Ath Verify Element Is Visible	//td[@class="my-details"]
	Capture Page Screenshot

MessagingClient_053
#Edit draft and close
	Messaging.Draft.Click Edit Button
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Close Button

MessagingClient_054
#Edit draft and save to draft
	Sleep 	2.0
	Messaging.Draft.Click Edit Button
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Save to Draft Button
	Messaging.Confirm Draft Message Saved successfully

MessagingClient_052
#Edit draft and send
	Messaging.Draft.Click Edit Button
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Send Message Button


	Logout from Application
