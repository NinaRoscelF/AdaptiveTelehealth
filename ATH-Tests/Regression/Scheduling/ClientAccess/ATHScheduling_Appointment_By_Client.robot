*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHScheduling_Appointment_By_Client.py
Suite Teardown	Close All Browsers


***Test Cases***
SchedulingClient_001
#wdigets display
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	Scheduling. Verify Schedule widget display
	Scheduling. Verify My Meetings widget display

SchedulingClient_002
#Ok button not enabled
	${DTToday}	Generate Date and Time Today
	${DateFormat}	Generate Date and Time Today	%m-%d-%Y
	${DateAdd}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%Y-%m-%d
	${DateAddFormat}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%m-%d-%Y
	Set Suite Variable	${DTToday}
	Set Suite Variable	${DateAddFormat}
	Set Suite Variable	${DateAdd}
	Scheduling.Select Appointment DateTime	${DateAdd}	${Time1}
	Scheduling.Select Appointment Type 	${ApptType1}	${DateAdd}	${Time1}
	Scheduling.Input Message	${Message}
	Scheduling.Check OK button is disabled


SchedulingClient_003
#schedule an online appt
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify Online Appointment is in Calendar	${Time1}
	${chkTime}	Strip String 	${Time1}	characters=PM
	${TimeRight}	Fetch From Right	${chkTime}	 - 
	${isTime}	Replace String	${TimeRight}	${SPACE}	${EMPTY}
	${TimeLeft}	Fetch From Left	${chkTime}	- 
	Scheduling.MyMeetings.Verify Appointment Display	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Appointment in Approved Status	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Cancel Button Display	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Reschedule Button Display	${DateAddFormat}	${isTime}
	#based on ENH
	Scheduling.Select Meeting from Calendar	${Time1}
	Scheduling.CancelMeeting.Click Continue Cancellation
	Sleep	1.0
	Scheduling.CancelMeeting.Click OK from Reschedule popup
	Reload Page

SchedulingClient_004
#Schedule an In-person appointment
	Scheduling.Select Appointment DateTime	${DateAdd}	${Time2}
	Run Keyword and Ignore Error	Scheduling.Select Appointment Type	${LiveApptType2}	${DateAdd}	${Time2}
	Run Keyword and Ignore Error	Scheduling.Select Appointment Type	${ApptType2}	${DateAdd}	${Time2}
	Scheduling.Input Message	${Message}
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify In-Person Appointment is in Calendar	${Time2}
	${chkTime}	Strip String 	${Time2}	characters=PM
	${TimeRight}	Fetch From Right	${chkTime}	 - 
	${isTime}	Replace String	${TimeRight}	${SPACE}	${EMPTY}
	${TimeLeft}	Fetch From Left	${chkTime}	- 
	Scheduling.MyMeetings.Verify Appointment Display	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Appointment in Approved Status	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Cancel Button Display	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Reschedule Button Display	${DateAddFormat}	${isTime}
	#based on ENH
	Scheduling.Select Meeting from Calendar	${Time2}
	Scheduling.CancelMeeting.Click Continue Cancellation
	Sleep	1.0
	Scheduling.CancelMeeting.Click OK from Reschedule popup
	Reload Page

SchedulingClient_005
#Schedule an online appointment w/ reminder
	Scheduling.Select Appointment DateTime	${DateAdd}	${Time3}
	Scheduling.Select Appointment Type	${ApptType1}	${DateAdd}	${Time3}
	Scheduling.Input Message	${Message}
	Scheduling.Select Reminder Checkbox
	Scheduling.Select Reminder Time	5 minutes
	Capture Page Screenshot
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify Online Appointment is in Calendar	${Time3}
	${chkTime}	Strip String 	${Time3}	characters=PM
	${TimeRight}	Fetch From Right	${chkTime}	 - 
	${isTime}	Replace String	${TimeRight}	${SPACE}	${EMPTY}
	${TimeLeft}	Fetch From Left	${chkTime}	- 
	Scheduling.MyMeetings.Verify Appointment Display	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Appointment in Approved Status	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Cancel Button Display	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Reschedule Button Display	${DateAddFormat}	${isTime}

SchedulingClient_009
#Cancel Scheduled Appointment from calendar - discontinue cancellation
	Scheduling.Select Meeting from Calendar	${Time3}
	Capture Page Screenshot
	Scheduling.CancelMeeting.Click Discontinue Cancellation
	Capture Page Screenshot
#	Scheduling.CancelMeeting.Click OK from Reschedule popup
	Scheduling. Verify In-Person Appointment is in Calendar	${Time3}

	#based on ENH
	Scheduling.Select Meeting from Calendar	${Time3}
	Scheduling.CancelMeeting.Click Continue Cancellation
	Sleep	1.0
	Scheduling.CancelMeeting.Click OK from Reschedule popup
	Reload Page
SchedulingClient_006
#Schedule an in person appointment w/ reminder
	Capture Page Screenshot
	Scheduling.Select Appointment DateTime	${DateAdd}	${Time4}
	Run Keyword and Ignore Error	Scheduling.Select Appointment Type	${LiveApptType4}	${DateAdd}	${Time4}
	Run Keyword and Ignore Error	Scheduling.Select Appointment Type	${ApptType2}	${DateAdd}	${Time4}
	Scheduling.Input Message	${Message}
	Scheduling.Select Reminder Checkbox
	Scheduling.Select Reminder Time	5 minutes
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify In-Person Appointment is in Calendar	${Time4}
	${chkTime}	Strip String 	${Time4}	characters=PM
	${TimeRight}	Fetch From Right	${chkTime}	 - 
	${isTime}	Replace String	${TimeRight}	${SPACE}	${EMPTY}
	${TimeLeft}	Fetch From Left	${chkTime}	- 
	Scheduling.MyMeetings.Verify Appointment Display	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Appointment in Approved Status	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Cancel Button Display	${DateAddFormat}	${isTime}
	Scheduling.MyMeetings.Verify Reschedule Button Display	${DateAddFormat}	${isTime}
	#based on ENH
	Scheduling.Select Meeting from Calendar	${Time4}
	Scheduling.CancelMeeting.Click Continue Cancellation
	Sleep	1.0
	Scheduling.CancelMeeting.Click OK from Reschedule popup
	Reload Page
SchedulingClient_007
#Cancel Schedule Appointment creation
	Scheduling.Select Appointment DateTime	${DateAdd}	${Time5}
	Run Keyword and Ignore Error	Scheduling.Select Appointment Type	${LiveApptType4}	${DateAdd}	${Time5}
	Run Keyword and Ignore Error	Scheduling.Select Appointment Type	${ApptType2}	${DateAdd}	${Time5}
	Scheduling.Input Message	${Message}
	Scheduling.Select Reminder Checkbox
	Scheduling.Select Reminder Time	10 minutes
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click Cancel Button

SchedulingClient_010
	Scheduling.Move Calendar Display to Next Page
	Sleep 	5.0
	Capture Page Screenshot

SchedulingClient_011
	Scheduling.Move Calendar Display to Previous Page
	Sleep 	5.0
	Capture Page Screenshot

SchedulingClient_008
#Cancel Scheduled Appointment from calendar- continue cancellation
	Scheduling.MyMeetings.Select Records per Page dropdown	100
	Scheduling.MyMeetings.Verify Appointment in Cancelled by Me Status	${DateAddFormat}	${TimeCalendar}
	Scheduling. Verify Appointment Time is Open 	${Time4}	${DateAdd}





	Logout from Application
