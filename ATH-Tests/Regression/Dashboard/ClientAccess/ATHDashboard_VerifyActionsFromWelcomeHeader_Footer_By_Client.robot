*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***variables***
${therapistLive}	Automation IsClient
${therapistSecure}	Ginger Taylor
${HelpMenuSecure}	 Reschedule an Appointment, Notifications via email
#${HelpMenuLive}	 Starting a Meeting, Notification Via Email, Troubleshooting
${HelpMenuLive}	 Troubleshooting

***Test Cases***
Dashboard_VerifyActionsFromWelcomeHeader_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	WelcomeHeader.Click Message Icon
	Messaging.Verify Message Page Displayed
	Capture Page Screenshot
	WelcomeHeader.Click Notification Icon
	Dashboard.ClientRole.Verify Alerts Table Header Is Visible
	Dashboard.NotificationsTable.Verify Column Is Visible	Date,Name,Message
	Dashboard.NotificationsTable.Verify Status Column is Visible
	Dashboard.Verify Notifications Mark All as Read Link Is Visible
	Capture Page Screenshot
	WelcomeHeader.Click Settings Icon
	ClientRole.Verify Settings Page Displayed
	Capture Page Screenshot
	WelcomeHeader.Click Help Icon
	Run Keyword if	"${TestEnv}" == "Secure"	Verify Help Page Displayed 	${therapistSecure}	${HelpMenuSecure}	ELSE 	Verify Help Page Displayed	${therapistLive}	${HelpMenuLive}
	Capture Page Screenshot

Dashboard_VerifyActionsFromFooter_By_Therapist
	Footer.Click Privacy Disclaimer
	Verify Privacy Disclaimer Page Opens
	Footer.Click Terms of Use
	Verify Terms of Use Page Opens
	Logout from Application