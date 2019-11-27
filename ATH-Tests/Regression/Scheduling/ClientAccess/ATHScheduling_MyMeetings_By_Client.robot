*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Time3}	02:00 - 03:00 PM
${Time2}	02:00PM - 03:00PM

***Test Cases***
SchedulingClient_012
#my meetings widget
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu

	${DTToday}	Generate Date and Time Today
	${DateAdd}	Add/Subtract Days from Input Date	${DTToday}	ADD	2	%m-%d-%Y
	${DateInCal}	Add/Subtract Days from Input Date	${DTToday}	ADD	2	%Y-%m-%d
	Set Suite Variable	${DateAdd}
	Set Suite Variable	${DateInCal}

	Scheduling.Select Appointment DateTime	${DateAdd}	${Time2}
	Scheduling.Select Appointment Type	${ApptType2}	${DateAdd}	${Time2}
	Scheduling.Input Message	For prerequisite
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify Online Appointment is in Calendar	${Time2}
	Scheduling.MyMeetings.Verify Meetings Display
	Scheduling.MyMeetings.Verify Columns Display	Day,Time,Type,Status,Actions



SchedulingClient_013
#record per page
	Scheduling.MyMeetings.Select Records per Page dropdown 	10
	Scheduling.MyMeetings.Verify Table Row same as Records per Page	10

SchedulingClient_020
#Sort Subject
	Messaging.Sort Day Column

SchedulingClient_021
#Sort Date
	Messaging.Sort Time Column

SchedulingClient_022
#Sort Time
	Messaging.Sort Type Column

SchedulingClient_023
#Status
	Messaging.Sort Status Column

SchedulingClient_024
#Sort Time
	Messaging.Sort Actions Column

SchedulingClient_014
#move to next page
	Move to Next Page

SchedulingClient_015
#move to previous page
	Move to Previous Page

SchedulingClient_016
#select page number
	Select Page Number 	2
	Move to Previous Page

SchedulingClient_018
#cancel meeting
	Scheduling.MyMeetings.Select Records per Page dropdown 	50

	Scheduling.MyMeetings.Click Cancel Button
	Scheduling.CancelMeeting.Click Discontinue Cancellation
	Scheduling.MyMeetings.Verify Appointment in Approved Status 	${DateAdd}	${Time3}
	Set Suite Variable	${DateAdd}

SchedulingClient_017
	Scheduling.MyMeetings.Click Cancel Button
	Scheduling.CancelMeeting.Click Continue Cancellation
	Scheduling.CancelMeeting.Click OK from Reschedule popup
	Scheduling.MyMeetings.Verify Appointment in Cancelled by Me Status	${DateAdd}	${Time3}
	Scheduling. Verify Appointment Time is Open 	${Time3}	${DateAdd}

SchedulingClient_019
	Scheduling.MyMeetings.Click Reschedule Button Display	${DateAdd}	${Time3}
	Scheduling.CancelMeeting.Click Continue Cancellation
	Scheduling.CancelMeeting.Click OK from Reschedule popup
	Scheduling.MyMeetings.Verify Appointment in Cancelled by Me Status	${DateAdd}	${Time3}
	Scheduling. Verify Appointment Time is Open	${Time2}	${DateInCal}

	Logout from Application

