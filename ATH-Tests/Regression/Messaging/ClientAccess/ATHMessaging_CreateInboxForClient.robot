*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Recipient1}	Ginger Taylor
${Recipient2}	Automation IsClient


***Test Cases***

InboxCreation
#Select one move to trash
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	:FOR 	${idx}	IN RANGE	1	15
	\	Messaging.Click New Message Button
	\	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	\	Messaging.Input Subject	Automation Message
	\	Messaging.Input Message	Automation Test Message
	\	Messaging.Click Send Message Button
	\	Sleep 	15.0
	Logout from Application
