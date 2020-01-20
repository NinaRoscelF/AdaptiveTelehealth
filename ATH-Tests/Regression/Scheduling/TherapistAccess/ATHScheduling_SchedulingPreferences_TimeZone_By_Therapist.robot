*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/Scheduling_ConfirmationCancellationTimeZonePage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
#${MyPatient}	Ginger Taylor (Patient)
${MyPatient1}	Emma Stoneage (Patient)
${MyPatient2}	Beyonce Halo (Patient)

***Test Cases***
SchedulingTherapist_025
#confirmations tab
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	ath click button	Calendar Preferences
	Scheduling.Preferences.Select Confirmations Tab
	Scheduling.Preferences.Verify Confirmations Tab Displayed
	Sleep 	5.0
	Capture Page Screenshot

# SchedulingTherapist_026
# #apply w/out select client
# 	Scheduling.Preferences.Confirmations.Click Apply
# 	Fail 	no validation
# 	Capture Page Screenshot

SchedulingTherapist_027
#sekect client
#	Scheduling. Expand Schedule Menu Settings
	ath click link 	Schedule preferences
	Capture Page Screenshot
	Scheduling.Preferences.Select Confirmations Tab
	Scheduling.Preferences.Confirmations.Select Very First Time Checkbox
	Scheduling.Preferences.Confirmations.Select Patient from List 	${MyPatient1}
	Scheduling.Preferences.Confirmations.Select Patient from List 	${MyPatient2}
	Scheduling.Preferences.Confirmations.Click Apply
	Scheduling.Preferences.Confirmations.Select Very First Time Checkbox 	false
	ath Logout
	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}
	Perform Login Checks
	Messaging.Verify Alert Message Received
	ath Logout

SchedulingTherapist_028
#confirmations tab
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	ath click button	Calendar Preferences
	Scheduling.Preferences.Select Cancellation Messages Tab
	Scheduling.Preferences.Verify Cancellation Messages Tab Displayed

SchedulingTherapist_029
#Cancellation Message - If client cancels within hours
	Scheduling.Preferences.CancellationMessages.Select Cancellation Within Hours
	Sleep 	2.0
	Scheduling.Preferences.Input Within Hours	3
	Scheduling.Preferences.Confirmations.Click Apply

SchedulingTherapist_030
#Cancellation Message - If client cancels less than 1
	Reload Page
	Scheduling. Expand Schedule Menu Settings
	ath click link	Schedule preferences
	Scheduling.Preferences.Select Cancellation Messages Tab
	Scheduling.Preferences.CancellationMessages.Select Cancellation Less Than Hours
	Sleep 	2.0
	Scheduling.Preferences.Input Cancels Less Than Hours	1
	Scheduling.Preferences.Confirmations.Click Apply


# SchedulingTherapist_031
# #Cancellation Message - If client cancels less than 24
# #	Scheduling. Expand Schedule Menu Settings
# 	Reload Page
# 	Scheduling. Expand Schedule Menu Settings
# 	ath click link 	Schedule preferences
# 	Scheduling.Preferences.Select Cancellation Messages Tab
# 	Scheduling.Preferences.CancellationMessages.Select Cancellation RadioButton	If client cancels less than 24
# 	Scheduling.Preferences.Input Message Hours 	If client cancels less than 24	Cancellation Message for less than 24 hours
# 	Scheduling.Preferences.Confirmations.Click Apply

SchedulingTherapist_032
#Cancellation Message - If client cancels the same day
	Reload Page
	Scheduling. Expand Schedule Menu Settings
	ath click link 	Schedule preferences
	Scheduling.Preferences.Select Cancellation Messages Tab
	Scheduling.Preferences.CancellationMessages.Select Cancellation Within Same Day
	Sleep 	2.0
	Scheduling.Preferences.Confirmations.Click Apply

SchedulingTherapist_042
#timezone tab
	Reload Page
	Scheduling. Expand Schedule Menu Settings
	ath click link 	Schedule preferences
	Scheduling.Preferences.Select Time Zone Tab
	Scheduling.Preferences.Verify Time Zone Tab Displayed

SchedulingTherapist_043
#select and apply timezone
	Scheduling.Preferences.TimeZone.Select Time Zone 	(GMT-07:00) Arizona
	Scheduling.Preferences.TimeZone.Apply Time Block
	Scheduling. Expand Account Settings Menu
	ath click link	Timezone
	Ath Verify Element Is Visible	xpath=//select[@id='therapist_time_zone_list']/option[@selected][contains(text(),'Arizona')]
	#revert to orig timezone
	ath click link 	Schedule preferences
	Scheduling.Preferences.Select Time Zone Tab
	Scheduling.Preferences.TimeZone.Select Time Zone	(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi
	Scheduling.Preferences.TimeZone.Apply Time Block
	Scheduling.Preferences.Confirm TimeZone Changes Saved successfully
	Logout from Application



