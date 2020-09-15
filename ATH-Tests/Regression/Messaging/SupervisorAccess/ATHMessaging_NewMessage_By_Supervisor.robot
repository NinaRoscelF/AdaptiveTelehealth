*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf
${Recipient1}	Random Automation Therapist
${Recipient2}	Mary Ellis

***Test Cases***
MessagingSupervisor_001

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Messaging.Verify Alert Message Received

MessagingSupervisor_002
	Select Messaging Menu
	Messaging.Verify Message Page Displayed

MessagingSupervisor_003
	Messaging.Click New Message Button
	Messaging.Verify New Message Widget Displayed
	Check Label Existence	Send To,Documents,Subject,Message

MessagingSupervisor_004
	Messaging.Click Send Message Button
	Messaging.Verify Send To Message Error Displayed

MessagingSupervisor_005
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Click Send Message Button
	Messaging.Verify Subject Message Error Displayed

MessagingSupervisor_006
	Messaging.Input Subject	Automation Message
	Messaging.Click Send Message Button
	Messaging.Verify Message Error Displayed

MessagingSupervisor_007
	Messaging.Clear Recipient Contents
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	All Group Therapist	ELSE	Messaging.Input Recipient	All Provider
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Sleep 	18.0
	ath wait until loaded	30
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Automation Message
	Logout from Application

MessagingSupervisor_008
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Click New Message Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	Groups testing_providers	ELSE	Messaging.Input Recipient	Automation Company_providers
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Sleep 	15.0
#	Messaging.Confirm Message Sent successfully
	Messaging.Select Sent Menu
	Sleep 	5.0
	ath wait until loaded	30
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Automation Message


# MessagingSupervisor_009
# 	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}
# 	Perform Login Checks
# 	Select Messaging Menu
# 	Messaging.Click New Message Button
# 	Messaging.Input Recipient	${Recipient1}
# 	Messaging.Select Document Attachment	${Filename}
# 	Messaging.Input Subject	Automation Message
# 	Messaging.Input Message	Automation Test Message
# 	Messaging.Click Send Message Button
# 	Messaging.Confirm Message Sent successfully
# 	Messaging.Select Sent Menu
# 	${DTToday}	Generate Date and Time Today
# 	Messaging.Sent.Verify Message is Sent	Mary Ellis
# 	Messaging.Sent.Verify Message is Sent	${DTToday}

# MessagingSupervisor_010
# 	Messaging.Click New Message Button
# 	Messaging.Input Recipient	${Recipient1}
# 	Messaging.Select Document Attachment	${Filename}
# 	Messaging.Select Document Attachment	${Filename2}
# 	Messaging.Input Subject	Automation Message
# 	Messaging.Input Message	Automation Test Message
# 	Messaging.Click Send Message Button
# 	Messaging.Confirm Message Sent successfully
# 	Messaging.Select Sent Menu
# 	${DTToday}	Generate Date and Time Today
# 	Messaging.Sent.Verify Message is Sent	Mary Ellis
# 	Messaging.Sent.Verify Message is Sent	${DTToday}


MessagingSupervisor_011
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Click New Message Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Save to Draft Button
	Sleep 	10.0
	Messaging.Confirm Draft Message Saved successfully
	Messaging.Select Draft Menu
	${DTToday}	Generate Date and Time Today
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Sent.Verify Message is Sent	${Recipient1}	ELSE	Messaging.Sent.Verify Message is Sent	${Recipient2}


MessagingSupervisor_012
	Messaging.Click New Message Button
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient1}	ELSE	Messaging.Input Recipient	${Recipient2}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Close Button
	Messaging.Verify New Message Widget Not Displayed
	Logout from Application