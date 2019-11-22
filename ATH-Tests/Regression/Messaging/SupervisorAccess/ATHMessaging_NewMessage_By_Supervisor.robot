*** Settings ***
Resource	C:/Adaptive_Telehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:/Adaptive_Telehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf
${Recipient1}	Mary Ellis ( Group Therapist )


***Test Cases***
MessagingSupervisor_001

	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}
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
	Messaging.Input Recipient	${Recipient1}
	Messaging.Click Send Message Button
	Messaging.Verify Subject Message Error Displayed

MessagingSupervisor_006
	Messaging.Input Subject	Automation Message
	Messaging.Click Send Message Button
	Messaging.Verify Message Error Displayed

MessagingSupervisor_007
	Messaging.Clear Recipient Contents
	Messaging.Input Recipient	All Groups Company
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Messaging.Confirm Message Sent successfully
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Automation Message
	Messaging.Sent.Verify Message is Sent	${DTToday}
	ath Logout

MessagingSupervisor_008
	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Click New Message Button
	Messaging.Input Recipient	${Recipient1}
	Messaging.Input Recipient	Andrew Hall ( Groups Company ) 
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Send Message Button
	Messaging.Confirm Message Sent successfully
	Messaging.Select Sent Menu
	${DTToday}	Generate Date and Time Today
	Messaging.Sent.Verify Message is Sent	Mary Ellis
	Messaging.Sent.Verify Message is Sent	${DTToday}


MessagingSupervisor_009
	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
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

MessagingSupervisor_012
	Messaging.Click New Message Button
	Messaging.Input Recipient	${Recipient1}
	Messaging.Input Subject	Automation Message
	Messaging.Input Message	Automation Test Message
	Messaging.Click Close Button
	Messaging.Verify New Message Widget Not Displayed
	ath Logout