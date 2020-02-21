*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Recipient1}	Mary Ellis
${Recipient2}	testsupervisor adaptive

***Test Cases***

DraftCreation
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${Client2}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	:FOR 	${idx}	IN RANGE	1	20
	\	Messaging.Click New Message Button
	\	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	\	Messaging.Input Subject	Automation Message
	\	Messaging.Input Message	Automation Test Message
	\	Messaging.Input Message	AutomationDraft Test Message
	\	Messaging.Click Save to Draft Button
	\	Sleep	15.0	wait for page to be loaded
	\	Capture Page Screenshot

	Logout from Application
