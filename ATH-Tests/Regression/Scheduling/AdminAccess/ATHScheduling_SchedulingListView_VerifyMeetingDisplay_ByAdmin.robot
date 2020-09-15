** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${ScheduledBySecure}	Taylor 
${ScheduledByLive}	Therapist
${CalendarSecure}	Mary Ellis
${CalendarLive}	Automation Therapist


***Test Cases***
ATHScheduling_SchedulingListView_VerifyMeetingDisplay_ByAdmin

	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	Run Keyword and Ignore Error	ath click button	xpath=//button[@id='different-timezone-no']
	Run Keyword if	"${TestEnv}" == "Secure"	Scheduling.Select Therapist Calendar 	${CalendarSecure}	ELSE	Scheduling.Select Therapist Calendar 	${CalendarLive}
	Run Keyword and Ignore Error	ath click button	xpath=//*[@id="diff_timezone"]/descendant::button[text()="Ok"]
	Scheduling.Switch to List View
	Scheduling.ListView.Select Appointment Range Display	Past Appointments
	Check Label Existence	 Meetings
	ath check button existence 	Print
	Scheduling.ListView.Verify Selected Appointment Range Is Displayed 	Future Appointments
	Scheduling.ListView.Verify Search Input textbox displayed
	Scheduling.MyMeetings.Verify Columns Display 	Date,Time,Title,Scheduled by By
	Check Link Existence	Previous
	Check Link Existence	Next
	Run Keyword if	"${TestEnv}" == "Secure"	Scheduling.ListView.Verify Appointment Detail Displayed	${ScheduledBySecure}	ELSE 	Scheduling.ListView.Verify Appointment Detail Displayed 	${ScheduledByLive}
	Run Keyword if	"${TestEnv}" == "Live"	Scheduling.ListView.Verify Appointment Detail Displayed	Open
	Scheduling.ListView.Verify Appointment Detail Displayed	Appointment
	Capture Page Screenshot

ATHScheduling_SchedulingListView_SelectAppointmentDisplay_ByAdmin
	Select Dashboard Menu
	Select Scheduling Menu
	Run Keyword if	"${TestEnv}" == "Secure"	Scheduling.Select Therapist Calendar 	${CalendarSecure}	ELSE	Scheduling.Select Therapist Calendar 	${CalendarLive}
	Run Keyword and Ignore Error	ath click button	xpath=//*[@id="diff_timezone"]/descendant::button[text()="Ok"]
	Scheduling.Switch to List View
	Scheduling.ListView.Select Appointment Range Display 	All Appointments
	Capture Page Screenshot
	Scheduling.ListView.Select Appointment Range Display 	Past Appointments
	Capture Page Screenshot


ATHScheduling_SchedulingListView_SelectRecordsPerPage_ByAdmin
	Scheduling.MyMeetings.Select Records per Page dropdown 	All
	Capture Page Screenshot



ATHScheduling_SchedulingListView_InputSearchCriteria_ByAdmin
	Run Keyword if	"${TestEnv}" == "Secure"	ath input text value 	Search 	${ScheduledBySecure} 	ELSE 	ath input text value 	Search 	${ScheduledByLive}
	${status}	Run Keyword and Return Status	Scheduling.ListView.SearchIput.Verify No Results Found
	Should Not Be True	${status}

ATHScheduling_SchedulingListView_ExpandCollapseStatusWidget_ByAdmin
	Select Dashboard Menu
	Select Scheduling Menu
	Run Keyword if	"${TestEnv}" == "Secure"	Scheduling.Select Therapist Calendar 	${CalendarSecure}	ELSE	Scheduling.Select Therapist Calendar 	${CalendarLive}
	Run Keyword and Ignore Error	ath click button	xpath=//*[@id="diff_timezone"]/descendant::button[text()="Ok"]
	Scheduling.Switch to List View
	Scheduling.StatusWidget.Expand/Collapse Action
	Capture Page Screenshot
	${status}	Run Keyword and Return Status	Scheduling.StatusWidget.Verify Widget Is Expanded
	Run Keyword and Continue on Failure	Should be true	${status}
	Scheduling.StatusWidget.Expand/Collapse Action
	Scheduling.Verify Status widget display
	Scheduling.Verify Available Status in Status widget 	Office Hours,Online,Booked,Confirmed,Cancelled,Waiting,Attended,Cancelled,Walk-in,No Answer,No-show,Being Seen,Rescheduled

	Logout from Application