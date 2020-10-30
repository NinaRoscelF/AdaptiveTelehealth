*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SchedulingPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/Scheduling_ConfirmationCancellationTimeZonePage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Variables	${EXECDIR}../../ATH-Resources/Variables/ATHScheduling_Scheduling_SelectFromCalendar_By_Therapist.py
Suite Teardown	Close All Browsers


***Test Cases***
SchedulingTherapist_052
#scheduling page display
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	Scheduling.Calendar.Verify Calendar Meeting is Displayed
	${DTToday}	Generate Date and Time Today
	${DateFormat}	Generate Date and Time Today	%m-%d-%Y
	${DateAdd}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%Y-%m-%d
	Set Suite Variable	${DateAdd}

SchedulingTherapist_053
#Open Schedule Slots
	Scheduling.Calendar.Verify Client Calendar Meeting Display

SchedulingTherapist_054
#edit open slot
	Scheduling.Calendar.Select Any Open Meeting
	Scheduling.Calendar.Verify Edit Open Meeting windown is Displayed
	Capture Page Screenshot
	ath Click Button	Cancel



SchedulingTherapist_056
#add multiple participants offline meeting
#	Scheduling.Calendar.Close Edit Appointment Popup
#	Scheduling.TherapistRole.Move Calendar Display to Next Page
	Scheduling.TherapistRole.Select Appointment DateTime	${Time1}	2
	Capture Page Screenshot
	Scheduling.Calendar.EditOpenPopup.Select Appointment Type 	In-Person
	Scheduling.Calendar.EditMeetingPopup.Input description 	${Description}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName2}
	Scheduling.Calendar.EditOpenPopup.Select Reminder Checkbox
	Scheduling.Calendar.EditOpenPopup.Select Send a Reminder 	5 minutes
	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
	${status}	Run Keyword and Return Status 	ath verify element is visible	//*[contains(@class,'dialog-titlebar')]/following-sibling::div[contains(normalize-space(),'Are you sure that you would like')]
	Run Keyword If	${status}	Scheduling.SchedulingAppointmentPopup.Select Continue
	Scheduling.Calendar.EditOpenPopup.Meeting Updated successfully


SchedulingTherapist_059
#edit meeting
	##prereq
	Reload Page
	Scheduling.TherapistRole.Select Appointment DateTime	${Time3}	2
	Capture Page Screenshot
	Scheduling.Calendar.EditOpenPopup.Select Appointment Type 	In-Person
	Scheduling.Calendar.EditMeetingPopup.Input description 	${Description}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName2}
	Scheduling.Calendar.EditOpenPopup.Select Reminder Checkbox
	Scheduling.Calendar.EditOpenPopup.Select Send a Reminder 	5 minutes
	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
	Reload Page

	Scheduling.Calendar.Select Any Personal Meeting from Calendar
	Scheduling.Calendar.Appointment Popup.Click Edit Meeting
	Scheduling.Calendar.EditMeetingPopup.Input Meeting Title 	Change to Automated Title
	Scheduling.Calendar.EditOpenPopup.Click Cancel Button

SchedulingTherapist_060
#delete
	Reload Page
	Scheduling.Calendar.Select Any Personal Meeting from Calendar
	Scheduling.Calendar.Appointment Popup.Click Delete Meeting
	Scheduling.Calendar.Appointment.DeletePopup.Click Continue
	Scheduling.Calendar.Appointment.DeletePopup.Verify Meeting is Deleted successfully


SchedulingTherapist_064
#X button on Appointment Details
	Scheduling.Calendar.Select Any Personal Meeting from Calendar
	ath click icon	xpath=(//button[@class="close"]/span[normalize-space()="×"])[1]

SchedulingTherapist_065
	Scheduling.TherapistRole.Move Calendar Display to Next Page
	Capture Page Screenshot

SchedulingTherapist_066
	Scheduling.TherapistRole.Move Calendar Display to Previous Page
	Capture Page Screenshot

#cleanup
	Scheduling.Calendar.Select Meeting from Calendar	${Time1}	Multiple Clients
	Scheduling.Calendar.Appointment Popup.Select Status Dropdown	Cancelled
	Scheduling.Calendar.Appointment.DeletePopup.Click Continue
	Scheduling.Calendar.Appointment.DeletePopup.Verify Meeting is Deleted successfully
	Scheduling.Calendar.Verify Meeting is Reopened in Calendar	${Time1}
	Logout from Application


# SchedulingTherapist_058
# #no participants - error
# 	Scheduling.TherapistRole.Select Appointment DateTime	${Time3}	2
# 	Capture Page Screenshot
# 	Scheduling.Calendar.EditOpenPopup.Select Appointment Type 	OFFLINE
# #	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName}
# 	Scheduling.Calendar.EditOpenPopup.Select Reminder Checkbox
# 	Scheduling.Calendar.EditOpenPopup.Select Send a Reminder	5 minutes
# 	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
# 	Scheduling.Calendar.EditOpenPopup.Validation No Participants


# SchedulingTherapist_055
# #Past Date Slots
# 	Scheduling.TherapistRole.Move Calendar Display to Previous Page
# 	${status}	Run Keyword and Return Status	Scheduling.Calendar.Select Any Open Meeting
# 	Run Keyword If 	${status}	Fail