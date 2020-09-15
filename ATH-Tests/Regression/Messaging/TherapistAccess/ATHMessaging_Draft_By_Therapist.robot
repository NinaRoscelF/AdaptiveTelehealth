*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
MessagingTherapist_041
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Draft Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Draft.Select checkbox of first Message
	${mySubj}	Messaging.Draft.Get Subject Column of Selected Message
	Set Suite Variable	${mySubj}
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

# MessagingTherapist_049
# #Sort Date
# 	Messaging.Sort Date Column

MessagingTherapist_050
#Sort Time
	Messaging.Sort Time Column

MessagingTherapist_051
#Expand Details
	Messaging.Draft.Expand First message
	Check Label Existence 	${mySubj}
	${status}	Run Keyword and Return Status	Ath Verify Element Is Visible	xpath=//*[contains(@id,'callout-alerts')]/descendant::p[normalize-space()="AutomationDraft Test Message"]
	Run Keyword UNless 	${status}	Ath Verify Element Is Visible	xpath=//*[contains(@id,'callout-alerts')]/descendant::p[normalize-space()="Automation Test Message"]
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
	Sleep 	15.0
	ath wait until loaded	60
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
