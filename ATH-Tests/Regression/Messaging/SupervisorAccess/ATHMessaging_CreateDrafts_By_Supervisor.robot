*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Recipient1}	Random Automation Therapist
${Recipient2}	Mary Ellis

***Test Cases***

DraftCreation
#Select one move to trash 
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Sleep	10.0
	Select Messaging Menu
	:FOR 	${idx}	IN RANGE	1	11
	\	Messaging.Click New Message Button
	\	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	\	Messaging.Input Subject	Automation Message
	\	Messaging.Input Message	Automation Test Message
	\	Messaging.Input Message	AutomationDraft Test Message
	\	Messaging.Click Save to Draft Button
	\	Sleep 	15.0
	Logout from Application
