*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHDashboard_CreateTherapist_By_SystemAdmin.py
Suite Teardown	Close All Browsers


***Variable***
${AttendeeSecure}	Stoneage
${AttendeeLive}	Democlient
${AttendeeNoEmail}	Stoneage
${AttNoEmailSecure}	Barstow
#Failed for LIVE

***Test Cases***
VideoOnDemand_CreateMeetingWithClient_WithEmail_By_Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Select Video on Demand Menu
	Check Label Existence 	Online Video Meeting,Provide optional topic
	Run Keyword if	"${TestEnv}" == "Secure"	Check Label Existence 	Set-up an instant meeting with a Groups Company or with a Guest	ELSE 	Check Label Existence 	Set-up an instant meeting with a Client or with a Guest
	VideoOnDemand.Verify Warning Message is Displayed
	VideoOnDemand.Input Optional Topic	Automation Topic
	Run Keyword if	"${TestEnv}" == "Secure"	VideoOnDemand.Select Meeting Attendee	${AttendeeSecure}	ELSE	VideoOnDemand.Select Meeting Attendee	${AttendeeLive}
	VideoOnDemand.Click Create Meeting Button
	Run Keyword if	"${TestEnv}" == "Secure"	VideoOnDemand.Verify Meeting Details of Client With Email	${AttendeeSecure}	ELSE	VideoOnDemand.Verify Meeting Details of Client With Email	${AttendeeLive}
	VideoOnDemand.Verify Join the Meeting Button exists
	VideoOnDemand.Click Join the Meeting Button
	VideoOnDemand.Select Meeting window
	Select window	main

VideoOnDemand_CreateMeetingWithClient_WithoutEmail_By_Supervisor
	Select Video on Demand Menu
	VideoOnDemand.Input Optional Topic	Automation Topic
	Run Keyword if	"${TestEnv}" == "Secure"	VideoOnDemand.Select Meeting Attendee	${AttNoEmailSecure}	ELSE 	VideoOnDemand.Select Meeting Attendee	${AttendeeNoEmail}
	VideoOnDemand.Click Create Meeting Button
	Run Keyword if	"${TestEnv}" == "Secure"	VideoOnDemand.Verify Meeting Details of Client Without Email 	${AttNoEmailSecure}	ELSE	VideoOnDemand.Verify Meeting Details of Client Without Email 	${AttendeeNoEmail}
	VideoOnDemand.Verify Join the Meeting Button exists
	VideoOnDemand.Click Join the Meeting Button
	VideoOnDemand.Select Meeting window
	Select window	main

# VideoOnDemand_CreateMeetingWithClient_WithoutAttendee_By_Supervisor
# 	Select Video on Demand Menu
# 	VideoOnDemand.Click Create Meeting Button
# 	VideoOnDemand.Verify Meeting Details without Attendee selected
# 	VideoOnDemand.Verify Join the Meeting Button exists
# 	VideoOnDemand.Click Join the Meeting Button
# 	VideoOnDemand.Select Meeting window
# 	Select window	main
	Logout from Application