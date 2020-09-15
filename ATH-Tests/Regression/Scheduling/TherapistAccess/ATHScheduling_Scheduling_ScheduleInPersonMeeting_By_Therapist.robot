*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/Scheduling_ConfirmationCancellationTimeZonePage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/${TestEnv}_ATHScheduling_Scheduling_ScheduleInPersonMeeting_By_Therapist.py
Suite Teardown	Close All Browsers


***Test Cases***
ATHScheduling_Scheduling_ScheduleInPersonMeeting_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	Scheduling.Calendar.Verify Calendar Meeting is Displayed
	${DTToday}	Generate Date and Time Today	%Y-%m-%d
	${DateAddDisplay}	Add/Subtract Days from Input Date	${DTToday}	ADD	1 	%m/%d/%Y
	${DateAdd}	Add/Subtract Days from Input Date	${DTToday}	ADD	1 	%Y-%m-%d
	Scheduling.TherapistRole.Select Appointment DateTime	${Time1}	2
	Capture Page Screenshot
	Run keyword and Ignore Error	Scheduling.Calendar.EditOpenPopup.Select Appointment Type 	In-Person
	Run keyword and Ignore Error	Scheduling.Calendar.EditOpenPopup.Select Appointment Type 	In Person
	Scheduling.Calendar.EditMeetingPopup.Input description 	${Description}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName}
	Scheduling.Calendar.EditOpenPopup.Input Schedule Start Date	${DateAddDisplay}
	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
	${status}	Run Keyword and Return Status 	ath verify element is visible	//*[contains(@class,'dialog-titlebar')]/following-sibling::div[contains(normalize-space(),'Are you sure that you would like')]
	Run Keyword If	${status}	Scheduling.SchedulingAppointmentPopup.Select Continue
	Sleep 	15.0
	ath wait until loaded	30
	Scheduling.Calendar.EditOpenPopup.Meeting Updated successfully

	Select Dashboard Menu
	Dashboard.MeetingWidget.Verify Meeting Is Displayed	${TimeDisplay}	${DateAddDisplay}
	Dashboard.MeetingWidget.Click Participant Name	${PtcpName}


	Run Keyword and Ignore Error	Dashboard.MeetingPopupDetails.Verify Label Existence	Appointment Details,Open,ONLINE,Scheduled by: ${Therapist}

	#post action to delete created meeting
	Dashboard.MeetingPopupDetails.Click Edit button
	Sleep 	15.0 	wait for app to naviagte to Scheduling tab
	Scheduling.Calendar.EditMeetingPopup.Click Delete Icon
	Scheduling.Calendar.Appointment.DeletePopup.Click Continue
	Scheduling.Calendar.Appointment.DeletePopup.Verify Meeting is Deleted successfully
	Logout from Application