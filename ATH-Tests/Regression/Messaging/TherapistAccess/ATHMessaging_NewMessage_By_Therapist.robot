*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${Filelocation}	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf
${Recipient1}	Daniella Demoss
${Recipient2}	Meghan Ruiz
${Recipient3}	Automation Company_providers
${Recipient4}	Ginger Taylor

***Test Cases***
MessagingTherapist_001
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Messaging.Verify Alert Message Received
MessagingTherapist_002
	Select Messaging Menu
	Messaging.Verify Message Page Displayed
MessagingTherapist_003
	Messaging.Click New Message Button
	Messaging.Verify New Message Widget Displayed
	Check Label Existence	Send To,Documents,Subject,Message
MessagingTherapist_004
	Messaging.Click Send Message Button
	Messaging.Verify Send To Message Error Displayed
MessagingTherapist_005
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Click Send Message Button
	Messaging.Verify Subject Message Error Displayed
MessagingTherapist_006
	Messaging.Input Subject	Automation Message
	Messaging.Click Send Message Button
	Messaging.Verify Message Error Displayed
MessagingTherapist_007
	Messaging.Clear Recipient Contents
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	All Groups Company	ELSE	Messaging.Input Recipient	${Recipient3}
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Sleep 	15.0
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Automation Message
	Messaging.Sent.Verify Message is Sent	${DTToday}
	Logout from Application

MessagingTherapist_008
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Click New Message Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient4}	ELSE	Messaging.Input Recipient	${Recipient3}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Sleep 	15.0
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	${DTToday}
MessagingTherapist_009
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Click New Message Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Select Document Attachment	${Filename}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Sleep 	15.0
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Sent.Verify Message is Sent	${Recipient4}	ELSE	Messaging.Sent.Verify Message is Sent	${Recipient2}
	Messaging.Sent.Verify Message is Sent	${DTToday}
MessagingTherapist_010
	Messaging.Click New Message Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Select Document Attachment	${Filename}
	Messaging.Select Document Attachment	${Filename2}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Sleep 	15.0
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Sent.Verify Message is Sent	${Recipient4}	ELSE	Messaging.Sent.Verify Message is Sent	${Recipient2}
	Messaging.Sent.Verify Message is Sent	${DTToday}
MessagingTherapist_011
	Messaging.Click New Message Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Save to Draft Button
	Sleep 	15.0
	Messaging.Confirm Draft Message Saved successfully
	Messaging.Select Draft Menu
	${DTToday}	Generate Date and Time Today
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Sent.Verify Message is Sent	${Recipient1}	ELSE	Messaging.Sent.Verify Message is Sent	${Recipient2}
	Messaging.Sent.Verify Message is Sent	${DTToday}
MessagingTherapist_012
	Messaging.Click New Message Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Close Button
	Messaging.Verify New Message Widget Not Displayed
	Logout from Application