*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/Scheduling_ConfirmationCancellationTimeZonePage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/${TestEnv}_ATHScheduling_Scheduling_SelectFromInbox_By_Therapist.py
Suite Teardown	Close All Browsers



***Test Cases***
SchedulingTherapist_033
# #Approve Patient's appointment
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${Client2}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	Run Keyword and Ignore Error	ath click button	xpath=//button[@id='different-timezone-no']
	${DTToday}	Generate Date and Time Today
	${DateFormat}	Generate Date and Time Today	%m-%d-%Y
	${DateAdd}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%Y-%m-%d
	${DateAddFormat}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%m-%d-%Y
	Scheduling.Select Appointment DateTime	${DateAdd}	${Time1}
	Scheduling.Select Appointment Type 	${ApptType1}	${DateAdd}	${Time1}
	Scheduling.Input Message	${Description}
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify Online Appointment is in Calendar	${Time2}
	Logout from Application

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	Scheduling.Calendar.Verify Calendar Meeting is Displayed
	Messaging.Verify Alert Message Received


SchedulingTherapist_034
#View calendar of patient's appointment
	Select Messaging Menu
	Messaging.Inbox.Read Nessage	New meeting
	Messaging.Inbox.Click View Calendar link
	Scheduling.Calendar.Verify Client Calendar Meeting Display
	${status}	Run Keyword and Return Status	Scheduling.Calendar.Verify Meeting is displayed in Calendar	${Time2}	${MyPatient}
	Run Keyword Unless 	${status}	Scheduling.Calendar.Verify Meeting is displayed in Calendar	${Time2}	${MyPatient3}
	Logout from Application

SchedulingTherapist_035
#confirm patient's appointment -pre req for confimr button to appear
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient2}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient3}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	${DTToday}	Generate Date and Time Today
	${DateFormat}	Generate Date and Time Today	%m-%d-%Y
	${DateAdd}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%Y-%m-%d
	${DateAddFormat}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%m-%d-%Y
	Scheduling.Select Appointment DateTime	${DateAdd}	${TimeConfirm}
	Scheduling.Select Appointment Type 	${ApptType1}	${DateAdd}	${TimeConfirm}
	Scheduling.Input Message	${Description}
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify Online Appointment is in Calendar	${TimeConfirm2}
	Logout from Application

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Inbox.Read Nessage	New meeting
	Messaging.Inbox.Click Confirm Button
	Messaging.Inbox.Close Message Response Button
	Select Scheduling Menu
	Scheduling. Verify Online Appointment is in Calendar	${TimeConfirm2}
	Reload Page


SchedulingTherapist_041
#Add Participant of Meeting (from Schedule Date) - without zoom id
	Scheduling.Calendar.Select Meeting from Calendar	${TimeConfirm2}	${MyPatient2}
	Scheduling.Calendar.Appointment Popup.Verify Participant Name	${MyPatient2}
	Scheduling.Calendar.Appointment Popup.Verify Time Schedule 	${TimeFrom}	${TimeTo}
	Scheduling.Calendar.Appointment Popup.Select Status Dropdown	Confirmed
	Scheduling.Calendar.Appointment Popup.Click Edit Meeting
	Scheduling.Calendar.EditMeetingPopup.Input description	${Description}
	${status}	Run Keyword and Return Status	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpWithoutZoom}
	Run Keyword Unless 	${status}	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName}
	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
	ath_verify_element_is_visible	xpath=//*[contains(@class,'cg-notify-message-danger')]

SchedulingTherapist_042
#delete
	Reload Page
	Scheduling.Calendar.Select Meeting from Calendar	${TimeConfirm2}	Multiple Clients
	Scheduling.Calendar.Appointment Popup.Click Delete Meeting
	Scheduling.Calendar.Appointment.DeletePopup.Click Continue
	Scheduling.Calendar.Verify Meeting is Reopened in Calendar 	${TimeConfirm2}
	Reload Page
#	OPen email


SchedulingTherapist_046
#Php Error on System Preferences
#	Scheduling.Calendar.Close Edit Appointment Popup
	Select System Preferences icon
	Verify System Preferences page displayed
	Logout from Application

# SchedulingTherapist_047
# #Past schedule slots are still open - expected error
# 	Scheduling.TherapistRole.Move Calendar Display to Previous Page
# 	${status}	Run Keyword and Return Status	Scheduling.Calendar.Select Any Open Meeting
# 	Run Keyword If 	${status}	Fail


# SchedulingTherapist_051
# #Client cancels on the day of appointment - expected error
# 	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
# 	Perform Login Checks
# 	Select Scheduling Menu
# 	${DTToday}	Generate Date and Time Today
# 	${DateFormat}	Generate Date and Time Today	%m-%d-%Y
# 	${DateAdd}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%Y-%m-%d
# 	${DateAddFormat}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%m-%d-%Y
# 	Scheduling.Select Appointment DateTime	${DateAdd}	${Time1}
# 	Scheduling.Select Appointment Type 	${ApptType1}	${DateAdd}	${Time1}
# 	Scheduling.Input Message	${Description}
# 	Scheduling.Select Schedule appointment Checkbox
# 	Scheduling.Click OK Button
# 	Scheduling. Verify Online Appointment is in Calendar	${Time2}

# 	Scheduling.Select Meeting from Calendar	${Time1}
# 	Scheduling.CancelMeeting.Click Continue Cancellation
# 	Scheduling.CancelMeeting.Click OK from Reschedule popup
# 	Scheduling.CancelMeeting.Cancellation Message Displayed	Cancellation Message for the same day
# 	Logout from Application




# SchedulingTherapist_038
# #add participant
# 	Scheduling.Calendar.EditMeetingPopup.Input description 	${Description}
# 	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName}
# 	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
# 	Select Scheduling Menu
# 	Scheduling.Calendar.Select Meeting from Calendar	${Time2}	${MyPatient}

# # SchedulingTherapist_039
# # #edit meeting without ZOOM ID
# # 	Select Messaging Menu
# # 	Messaging.Inbox.Read Nessage	New meeting
# # 	ath click button	Confirm
# 	Scheduling.Calendar.Appointment Popup.Click Edit Meeting
# 	Scheduling.Calendar.Verify Edit Meeting Popup displayed	${MyPatient}

# SchedulingTherapist_040
# #cannot add without zoom
# 	Scheduling.Calendar.EditMeetingPopup.Input description 	${Description}
# 	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpWithoutZoom}
# 	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
# 	# Scheduling.Calendar.Select Meeting from Calendar	${Time2}	${MyPatient}