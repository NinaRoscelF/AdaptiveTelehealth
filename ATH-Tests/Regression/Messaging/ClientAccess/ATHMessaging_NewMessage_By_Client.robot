*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf
${Recipient1}	Mary Ellis
${Recipient2}	Meghan Ruiz
${Recipient3}	testsupervisor adaptive

***Test Cases***
MessagingClient_001
#Alert Message - Dashboard
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Messaging.Verify Alert Message Received

MessagingClient_002
#Messaging Page Display
	Select Messaging Menu
	Messaging.Verify Message Page Displayed

MessagingClient_003
#New Message Panel Display
	Messaging.Click New Message Button
	Messaging.Verify New Message Widget Displayed
	Check Label Existence	Send To,Documents,Subject,Message

MessagingClient_004
#Send with empty fields
	Messaging.Click Send Message Button
	Messaging.Verify Send To Message Error Displayed

MessagingClient_005
#Send with empty Subject field
	Messaging.Input Recipient	${Recipient1}
	Messaging.Click Send Message Button
	Messaging.Verify Subject Message Error Displayed

MessagingClient_006
#Send with empty Message field
	Messaging.Input Subject	Automation Message
	Messaging.Click Send Message Button
	Messaging.Verify Message Error Displayed

MessagingClient_007
#Send Message to any of the following: All Staff/All Group Therpaist/All Guest/All Group Company
	Messaging.Clear Recipient Contents
	Messaging.Input Recipient	${Recipient1}
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Messaging.Confirm Message Sent successfully
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Automation Message
	Messaging.Sent.Verify Message is Sent	${DTToday}
	ath Logout

MessagingClient_008
#Send Message to multiple receipients
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Click New Message Button
	Messaging.Input Recipient	${Recipient1}
	Run Keyword if	"${TestEnv}" == "Secure"	Messaging.Input Recipient	${Recipient2}	ELSE	Messaging.Input Recipient	${Recipient3}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Messaging.Confirm Message Sent successfully
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Mary Ellis
	Messaging.Sent.Verify Message is Sent	${DTToday}


MessagingClient_009
#Send Message with an attachment
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Click New Message Button
	Messaging.Input Recipient	${Recipient1}
	Messaging.Select Document Attachment	${Filename}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Messaging.Confirm Message Sent successfully
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Mary Ellis
	Messaging.Sent.Verify Message is Sent	${DTToday}

MessagingClient_010
#Send Message with multiple attachments
	Messaging.Click New Message Button
	Messaging.Input Recipient	${Recipient1}
	Messaging.Select Document Attachment	${Filename}
	Messaging.Select Document Attachment	${Filename2}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Messaging.Confirm Message Sent successfully
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Mary Ellis
	Messaging.Sent.Verify Message is Sent	${DTToday}


MessagingClient_011
#Create a Save to Draft Message
	Messaging.Click New Message Button
	Messaging.Input Recipient	${Recipient1}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Save to Draft Button
	Messaging.Confirm Draft Message Saved successfully
	Messaging.Select Draft Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Mary Ellis
	Messaging.Sent.Verify Message is Sent	${DTToday}

MessagingClient_012
#Close message
	Messaging.Click New Message Button
	Messaging.Input Recipient	${Recipient1}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Close Button
	Messaging.Verify New Message Widget Not Displayed
	ath Logout