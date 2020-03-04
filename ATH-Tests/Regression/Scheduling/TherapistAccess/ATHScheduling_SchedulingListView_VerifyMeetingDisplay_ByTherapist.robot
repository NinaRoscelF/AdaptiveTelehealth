** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${ScheduledBySecure}	Ellis
${ScheduledByLive}	Therapist
${MyPatientLive}	IsClient
${MyPatientSecure}	Ginger

***Test Cases***
ATHScheduling_SchedulingListView_VerifyMeetingDisplay_ByTherapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	ath click icon 	xpath=//ul[@class='toggle pull-right']/descendant::li[@class="t"]
	ath verify element is visible 	//div[@id='list_view']
	ath check label	 Meetings 
	ath check button existence 	Print
	ath verify element is visible 	//select[@id='appointment_time']/descendant::option[@selected][text()="Future Appointments"]
	ath check label	Search
	ath verify element is visible 	//label[contains(text(),'Search')]//input
	Scheduling.MyMeetings.Verify Columns Display 	Date,Time,Title,Scheduled by By
	ath_check_links_displayed 	Previous
	ath_check_links_displayed 	Next
	Run Keyword if	"${TestEnv}" == "Secure"	ath verify element is visible 	xpath=(//table/descendant::td[contains(text(),'${ScheduledBySecure}')])[1] 	ELSE 	ath verify element is visible 	xpath=(//table/descendant::td[contains(text(),'${ScheduledByLive}')])[1]
	Run Keyword if	"${TestEnv}" == "Secure"	ath verify element is visible 	xpath=(//table/descendant::td[contains(text(),'${MyPatientSecure}')])[1] 	ELSE 	ath verify element is visible 	xpath=(//table/descendant::td[contains(text(),'${MyPatientLive}')])[1]
	Run Keyword if	"${TestEnv}" == "Live"	ath verify element is visible 	xpath=(//table/descendant::td[text()="Open"])[1]
	ath verify element is visible 	xpath=(//table/descendant::td[text()="Appointment"])[1]
	Capture Page Screenshot

ATHScheduling_SchedulingListView_SelectAppointmentDisplay_ByTherapist
	Select Dashboard Menu
	Select Scheduling Menu
	ath click icon 	xpath=//ul[@class='toggle pull-right']/descendant::li[@class="t"]
	ath click icon 	//select[@id='appointment_time']
	ath click icon 	//select[@id='appointment_time']/option[contains(text(),'Future Appointments')]
	Capture Page Screenshot
	ath click icon 	//select[@id='appointment_time']
	ath click icon 	//select[@id='appointment_time']/option[contains(text(),'Past Appointments')]
	Capture Page Screenshot

ATHScheduling_SchedulingListView_SelectRecordsPerPage_ByTherapist
	Scheduling.MyMeetings.Select Records per Page dropdown 	All
	Capture Page Screenshot



ATHScheduling_SchedulingListView_InputSearchCriteria_ByTherapist
	Run Keyword if	"${TestEnv}" == "Secure"	ath input text value 	Search 	${ScheduledBySecure} 	ELSE 	ath input text value 	Search 	${ScheduledByLive} 
	${status}	Run Keyword and Return Status	Scheduling.ListView.SearchIput.Verify No Results Found
	Should Not Be True	${status}

ATHScheduling_SchedulingListView_ExpandCollapseStatusWidget_ByTherapist
	Select Dashboard Menu
	Select Scheduling Menu
	ath click icon 	xpath=//ul[@class='toggle pull-right']/descendant::li[@class="t"]
	ath click icon	xpath=//h4[@class='panel-title']/a
	Capture Page Screenshot
	${status}	Run Keyword and Return Status	ath verify element is visible	//h4[@class='panel-title']/a[@aria-expanded="true"]
	Run Keyword and Continue on Failure 	Should not be true	${status}
	ath click icon	xpath=//h4[@class='panel-title']/a
	Scheduling. Verify Status widget display
	Scheduling.Verify Available Status in Status widget 	Office Hours,Online,Pending,Booked,Confirmed,Cancelled,Waiting,Attended,Off Hours,In-Person,Cancelled,Walk-in,No Answer,No-show,Being Seen,Rescheduled

	Logout from Application