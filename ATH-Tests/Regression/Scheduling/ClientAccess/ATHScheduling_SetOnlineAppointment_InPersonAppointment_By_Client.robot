*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHScheduling_Appointment_By_Client.py
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Variables	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Variables/ATHScheduling_SetOnlineAppointment_InPersonAppointment_By_Client.py
Suite Teardown	Close All Browsers


***Test Cases***
ATHScheduling_SetOnlineAppointment_InPersonAppointment_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu

	${DTToday}	Generate Date and Time Today
	${DateFormat}	Generate Date and Time Today	%m-%d-%Y
	${DateAdd}	Add/Subtract Days from Input Date 	${DTToday}	ADD	2 	%Y-%m-%d
	${DateAddFormat}	Add/Subtract Days from Input Date 	${DTToday}	ADD	2 	%m-%d-%Y
	${DateDisplay}	Add/Subtract Days from Input Date 	${DTToday}	ADD	2 	%m/%d/%y
	Scheduling.Select Appointment DateTime	${DateAdd}	${Time1}
	Scheduling.Select Appointment Type 	${ApptType1}	${DateAdd}	${Time1}
	Scheduling.Input Message	${Message}
	Scheduling.Check OK button is disabled

	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify Online Appointment is in Calendar	${Time1}
	${chkTime}	Strip String 	${Time1}	characters=PM
	${TimeRight}	Fetch From Right	${chkTime}	 -
	${isTime}	Replace String	${TimeRight}	${SPACE}	${EMPTY}
	${TimeLeft}	Fetch From Left	${chkTime}	-
	Scheduling.MyMeetings.Verify Appointment Display	${DateAddFormat}	${isTime}

	Select Dashboard Menu
	Dashboard.Verify Client Meetings Widget Is Displayed
	Dashboard.ClientMeetingsWidget.Verify Video Meetings Details	${DateDisplay}	${TimeDisplay}

#Schedule an In-person appointment
	#click via schedule link  in MyMeetings widget
	ath click Link	Schedule
	Sleep 	3.0
	ath wait until loaded	30
	Scheduling. Verify My Meetings widget display
	Scheduling.Select Appointment DateTime	${DateAdd}	${Time2}
	Scheduling.Select Appointment Type	${ApptType2}	${DateAdd}	${Time2}
	Scheduling.Input Message	${Message}
	Scheduling.Select Schedule appointment Checkbox
	Scheduling.Click OK Button
	Scheduling. Verify In-Person Appointment is in Calendar	${Time2}
	${chkTime}	Strip String 	${Time2}	characters=PM
	${TimeRight}	Fetch From Right	${chkTime}	 -
	${isTime}	Replace String	${TimeRight}	${SPACE}	${EMPTY}
	${TimeLeft}	Fetch From Left	${chkTime}	-
	Scheduling.MyMeetings.Verify Appointment Display	${DateAddFormat}	${isTime}
	Select Dashboard Menu
	Dashboard.Verify Client Meetings Widget Is Displayed
	Dashboard.ClientMeetingsWidget.Verify InPerson Meetings Details	${DateDisplay}	${TimeDisplay2}

	Logout from Application
