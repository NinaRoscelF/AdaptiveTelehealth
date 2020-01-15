*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Recipient1}	Random Automation Therapist ( Group Therapist )
${Recipient2}	Mary Ellis

***Test Cases***
MessagingSupervisor_041
#Select one move to trash
	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Draft Menu
	Sleep	3.0
	ath wait until loaded	30
	${DTToday}	Generate Date and Time Today
	Messaging.Draft.Select checkbox of first Message
	${mySubj}	Messaging.Draft.Get Subject Column of Selected Message
	Messaging.Draft.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash
	Messaging.Select Trash Menu
	Messaging.Trash.Verify Message is Deleted	${mySubj}

MessagingSupervisor_043
#Cancel move to trash
	${DTToday}	Generate Date and Time Today
	Messaging.Select Draft Menu
	Sleep	3.0
	ath wait until loaded	30
	Messaging.Draft.Select checkbox of first Message
	Messaging.Draft.Move to Trash Icon
	Messaging.Cancel Move to Trash Action

MessagingSupervisor_042
#Select all move to trash
	Messaging.Select Draft Menu
	Sleep	3.0
	ath wait until loaded	30
	Messaging.Draft.Select all Messages
	Messaging.Draft.Move to Trash Icon
	Messaging.Confirm Move to Trash Action
	Messaging.Confirm Message Moved to Trash

# #Sort From
# MessagingSupervisor_047
# #restore all msgs on page
# #Pre-req to restore deleted draft msgs
# 	Messaging.Select Trash Menu
# 	Messaging.Trash.Select all Messages
# 	Messaging.Trash.Click Restore Icon
# 	Messaging.Trash.Confirm Restore Action
# 	Messaging.Confirm Message is Restored
# 	Messaging.Select Draft Menu
# 	Messaging.Sort To Column

# MessagingSupervisor_048
# #Sort Subject
# 	Messaging.Sort Subject Column

MessagingSupervisor_049
#Sort Date
	Messaging.Sort Date Column

MessagingSupervisor_050
#Sort Time
	Messaging.Sort Time Column


MessagingSupervisor_051
#Expand Details
	Messaging.Draft.Expand First message
	Ath Verify Element Is Visible	//td[@class="my-details"]
	Capture Page Screenshot

MessagingSupervisor_053
#Edit draft and close
	Messaging.Draft.Click Edit Button
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Close Button

MessagingSupervisor_054
#Edit draft and save to draft
	Messaging.Draft.Click Edit Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Save to Draft Button
	Messaging.Confirm Draft Message Saved successfully

MessagingSupervisor_052
#Edit draft and send
	Messaging.Draft.Click Edit Button
	Messaging.Input Message	AutomationDraft Test Message
	Messaging.Click Send Message Button


MessagingSupervisor_044
	:FOR 	${idx}	IN RANGE	1	11
	\	Messaging.Click New Message Button
	\	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	\	Messaging.Input Subject	Automation Message
	\	Messaging.Input Message	Automation Test Message
	\	Messaging.Input Message	AutomationDraft Test Message
	\	Messaging.Click Save to Draft Button

	Move to Next Page

MessagingSupervisor_045
#move to previous page
	Move to Previous Page

MessagingSupervisor_046
#move to selected page
	Select Page Number	2
	Logout from Application
