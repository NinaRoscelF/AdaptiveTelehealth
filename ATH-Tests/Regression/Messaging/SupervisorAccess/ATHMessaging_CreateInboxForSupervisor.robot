*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Recipient1}	Mary Ellis
${Recipient2}	testsupervisor adaptive

***Test Cases***

InboxCreation
#Select one move to trash
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${Client2}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	:FOR 	${idx}	IN RANGE	1	11
	\	Messaging.Click New Message Button
	\	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	\	Messaging.Input Subject	Automation Message
	\	Messaging.Input Message	Automation Test Message
	\	Messaging.Click Send Message Button
	\	Sleep 	15.0
	Logout from Application
