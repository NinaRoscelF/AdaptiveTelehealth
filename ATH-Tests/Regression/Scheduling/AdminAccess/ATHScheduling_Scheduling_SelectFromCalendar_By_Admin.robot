*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/Scheduling_ConfirmationCancellationTimeZonePage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHScheduling_Scheduling_SelectFromCalendar_By_Admin.py
Suite Teardown	Close All Browsers 


***Test Cases***
SchedulingAdmin_001
#scheduling therapist selection
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	Run Keyword and Ignore Error	ath click button	xpath=//button[@id='different-timezone-no']
	Run Keyword if	"${TestEnv}" == "Secure"	Scheduling.Select Therapist Calendar 	${MyPatient}	ELSE	Scheduling.Select Therapist Calendar 	${MyPatient2}

	Scheduling.AdminRole.TherapistTimezone.Click OK button
	Scheduling.Calendar.Verify Calendar Meeting is Displayed
	${DTToday}	Generate Date and Time Today
	${DateFormat}	Generate Date and Time Today	%m-%d-%Y
	${DateAdd}	Add/Subtract Days from Input Date 	${DTToday}	ADD	2	%Y-%m-%d
	Set Suite Variable	${DateAdd}

SchedulingAdmin_002
#Odisplay calendar for therapist
	Scheduling.Calendar.Verify Client Calendar Meeting Display
	Run Keyword if	"${TestEnv}" == "Secure"	ath_verify_element_is_visible	//span[@class='page-title'][contains(normalize-space(),'Schedule')]/font[normalize-space()="${MyPatient}"] 	ELSE 	ath_verify_element_is_visible	//span[@class='page-title'][contains(normalize-space(),'Schedule')]/font[normalize-space()="${MyPatient2}"]

#prereq Offline meeting deletion
	:FOR 	${idx}	IN RANGE	1	2
	\	Run Keyword and Ignore Error	Scheduling.Calendar.Select Any Personal Meeting from Calendar
	\	Run Keyword and Ignore Error	Scheduling.Calendar.Appointment Popup.Click Delete Meeting
	\	Run Keyword and Ignore Error	Scheduling.Calendar.Appointment.DeletePopup.Click Continue
	\	Run Keyword and Ignore Error	Scheduling.Calendar.Appointment.DeletePopup.Verify Meeting is Deleted successfully

#prereq Online meeting deletion
	Run Keyword and Ignore Error	Scheduling.Calendar.Select Any Online Meeting from Calendar
	Run Keyword and Ignore Error	Scheduling.Calendar.Appointment Popup.Click Delete Meeting
	Run Keyword and Ignore Error	Scheduling.Calendar.Appointment.DeletePopup.Click Continue
	Run Keyword and Ignore Error	Scheduling.Calendar.Appointment.DeletePopup.Verify Meeting is Deleted successfully
SchedulingAdmin_003
#delete personal
	${DTToday}	Generate Date and Time Today
	${DateFormat}	Generate Date and Time Today	%m-%d-%Y
	${DateAdd}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%Y-%m-%d
	${DateAddFormat}	Add/Subtract Days from Input Date 	${DTToday}	ADD	1 	%m-%d-%Y
	Run Keyword and Ignore Error	ath click button	xpath=//button[@id='different-timezone-no']
#	Run Keyword if	"${TestEnv}" == "Secure"	Scheduling.TherapistRole.Select Appointment DateTime	${Time1}	ELSE	ath click icon	xpath=//span[text()="${LiveTime1}"]/ancestor::tr[1]/td[2]
#	Run Keyword and Ignore Error	ath click icon	xpath=//span[text()="${LiveTime1}"]/ancestor::tr[1]/td[2]
#	run keyword and Ignore Error	Execute Javascript	var element = document.evaluate("//span[text()="${LiveTime1}"]/ancestor::tr[1]/td[2]" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue;if (element != null) {element.click();}
	Scheduling.TherapistRole.Select Appointment DateTime	${Time1}
	Scheduling.Calendar.EditOpenPopup.Select Appointment Type 	OFFLINE
	Scheduling.Calendar.EditMeetingPopup.Input description 	${Description}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName2}
	Scheduling.Calendar.EditOpenPopup.Select Reminder Checkbox
	Scheduling.Calendar.EditOpenPopup.Select Send a Reminder 	5 minutes
	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
	${status}	Run Keyword and Return Status 	ath verify element is visible	//*[contains(@class,'dialog-titlebar')]/following-sibling::div[contains(normalize-space(),'Are you sure that you would like')]
	Run Keyword If	${status}	Scheduling.SchedulingAppointmentPopup.Select Continue
	Sleep	10.0 	wait for process to finish
	Reload Page
	Scheduling.AdminRole.TherapistTimezone.Click OK button
	Scheduling.Calendar.Select Any Personal Meeting from Calendar
	Scheduling.Calendar.Appointment Popup.Click Delete Meeting
	Scheduling.Calendar.Appointment.DeletePopup.Click Continue
	Scheduling.Calendar.Appointment.DeletePopup.Verify Meeting is Deleted successfully
	Capture Page Screenshot
	Reload Page
	Scheduling.AdminRole.TherapistTimezone.Click OK button

SchedulingAdmin_004
#edit online meeting
	##prereq
#	Run Keyword if	"${TestEnv}" == "Secure"	Scheduling.TherapistRole.Select Appointment DateTime	${Time4}	ELSE	ath click icon	xpath=//span[text()="${LiveTime1}"]/ancestor::tr[1]/td[2]
	# Run Keyword and Ignore Error	ath click icon	xpath=//span[text()="${LiveTime1}"]/ancestor::tr[1]/td[2]
	# run keyword and Ignore Error	Execute Javascript	var element = document.evaluate("//span[text()="${LiveTime1}"]/ancestor::tr[1]/td[2]" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue;if (element != null) {element.click();}
	Scheduling.TherapistRole.Select Appointment DateTime	12:00 - 1:00
	Scheduling.Calendar.EditOpenPopup.Select Appointment Type	ONLINE
	Scheduling.Calendar.EditMeetingPopup.Input description 	${Description}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName}
	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
	${status}	Run Keyword and Return Status 	ath verify element is visible	//*[contains(@class,'dialog-titlebar')]/following-sibling::div[contains(normalize-space(),'Are you sure that you would like')]
	Run Keyword If	${status}	Scheduling.SchedulingAppointmentPopup.Select Continue
	Sleep	10.0 	wait for process to finish
	Reload Page
	Scheduling.AdminRole.TherapistTimezone.Click OK button
	Scheduling.Calendar.Select Any Online Meeting from Calendar
	Scheduling.Calendar.Appointment Popup.Click Edit Meeting
	Scheduling.Calendar.EditMeetingPopup.Input description	Change Description
	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
	${status}	Run Keyword and Return Status 	ath verify element is visible	xpath=//*[contains(@class,'dialog-titlebar')]/following-sibling::div[contains(normalize-space(),'Are you sure that you would like')]
	Run Keyword If	${status}	Scheduling.SchedulingAppointmentPopup.Select Continue
	Scheduling.Calendar.EditOpenPopup.Meeting Updated successfully
	Sleep	30.0 	wait for process to finish
	Reload Page
	Scheduling.AdminRole.TherapistTimezone.Click OK button

SchedulingAdmin_005
#create meeting
#	Run Keyword if	"${TestEnv}" == "Secure"	Scheduling.TherapistRole.Select Appointment DateTime	${Time4}	ELSE	ath click icon	xpath=//span[text()="${LiveTime}"]/ancestor::tr[1]/td[2]
	# Run Keyword and Ignore Error	ath click icon	xpath=//span[text()="${LiveTime}"]/ancestor::tr[1]/td[2]
	# run keyword and Ignore Error	Execute Javascript	var element = document.evaluate("//span[text()="${LiveTime}"]/ancestor::tr[1]/td[2]" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue;if (element != null) {element.click();}
	Scheduling.TherapistRole.Select Appointment DateTime	${Time4}
	Scheduling.Calendar.EditOpenPopup.Select Appointment Type 	OFFLINE
	Scheduling.Calendar.EditMeetingPopup.Input description 	${Description}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName}
	Scheduling.Calendar.Appointment Popup.Add Participants	${PtcpName2}
	Scheduling.Calendar.EditOpenPopup.Select Reminder Checkbox
	Scheduling.Calendar.EditOpenPopup.Select Send a Reminder 	5 minutes
	Scheduling.Calendar.Appointment Popup.Click Change Meeting Button
	${status}	Run Keyword and Return Status 	ath verify element is visible	xpath=//*[contains(@class,'dialog-titlebar')]/following-sibling::div[contains(normalize-space(),'Are you sure that you would like')]
	Run Keyword If	${status}	Scheduling.SchedulingAppointmentPopup.Select Continue
	Scheduling.Calendar.EditOpenPopup.Meeting Updated successfully


	Logout from Application

