*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Recipient2}	Meghan Ruiz
${Recipient1}	Mary Ellis
${Recipient3}	testsupervisor adaptive

***Test Cases***

DraftCreation
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
#	Select Messaging Menu
#	Messaging.Select Draft Menu
#	:FOR 	${idx}	IN RANGE	1	11
#	\	Messaging.Draft.Click New Message Button
#	\	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient2}	ELSE	Messaging.Input Recipient	${Recipient3}
#	\	Messaging.Input Subject	Automation Message
#	\	Messaging.Input Message	Automation Test Message
#	\	Messaging.Input Message	AutomationDraft Test Message
#	\	Messaging.Click Save to Draft Button
#	\	Sleep	15.0	wait for page to be loaded
#	\	Capture Page Screenshot
#	\	Reload Page
#	\	Sleep 	3.0
#	\	ath wait until loaded 	30
#	\	Messaging.Select Draft Menu

#	Logout from Application
