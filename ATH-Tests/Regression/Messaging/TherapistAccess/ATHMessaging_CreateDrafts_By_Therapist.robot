*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
#${Recipient1}	Random Automation Therapist
${Recipient2}	testsupervisor adaptive

***Test Cases***

DraftCreation
#Select one move to trash
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	:FOR 	${idx}	IN RANGE	1	20
	\	Messaging.Click New Message Button
	# \	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	
	\	Messaging.Input Recipient	${Recipient2}
	\	Messaging.Input Subject	Automation Message
	\	Messaging.Input Message	Automation Test Message
	\	Messaging.Input Message	AutomationDraft Test Message
	\	Messaging.Click Save to Draft Button
	\	Sleep 	15.0
	Logout from Application

