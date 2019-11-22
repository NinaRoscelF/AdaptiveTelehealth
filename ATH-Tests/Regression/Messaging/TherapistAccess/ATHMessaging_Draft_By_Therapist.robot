*** Settings ***
Resource	C:/Adaptive_Telehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***


***Test Cases***
MessagingTherapist_041
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

MessagingTherapist_043
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Draft Menu
	Messaging.Draft.Select checkbox of first Message
	Messaging.Draft.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

MessagingTherapist_042
#Select all move to trash
	Messaging.Select Draft Menu
	Messaging.Draft.Select all Messages
	Messaging.Draft.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash

#Sort From
# MessagingTherapist_047
# #restore all msgs on page
# #Pre-req to restore deleted draft msgs
# 	Messaging.Select Trash Menu
# 	Messaging.Trash.Select all Messages
# 	Messaging.Trash.Click Restore Icon
# 	Messaging.Trash.Confirm Restore Action
# 	Messaging.Confirm Message is Restored
# 	Messaging.Select Draft Menu
# 	Messaging.Sort To Column

# MessagingTherapist_048
# #Sort Subject
# 	Messaging.Sort Subject Column

MessagingTherapist_049
#Sort Date
	Messaging.Sort Date Column

MessagingTherapist_050
#Sort Time
	Messaging.Sort Time Column

MessagingTherapist_051
#Expand Details
	Messaging.Draft.Read Message	Ginger Taylor
	Ath Verify Element Is Visible	//td[@class="my-details"]
	Capture Page Screenshot

MessagingTherapist_053
#Edit draft and close
	Messaging.Draft.Click Edit Button
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Close Button

MessagingTherapist_054
#Edit draft and save to draft
	Messaging.Draft.Click Edit Button
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Save to Draft Button
	Messaging.Confirm Draft Message Saved successfully

MessagingTherapist_052
#Edit draft and send
	Messaging.Draft.Click Edit Button
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Send Message Button


MessagingTherapist_044
	Move to Next Page

MessagingTherapist_045
#move to previous page
	Move to Previous Page

MessagingTherapist_046
#move to selected page
	Select Page Number	2
	Logout from Application
