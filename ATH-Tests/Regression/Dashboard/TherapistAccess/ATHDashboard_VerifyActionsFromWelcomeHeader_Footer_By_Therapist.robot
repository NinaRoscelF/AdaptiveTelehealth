*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DashboardPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***variables***
${therapistLive}	Automation
${therapistSecure}	Mary
${HelpMenuSecure}	 Set Up Guide, Documents, Change Password, Homework Assignments, Schedule, Email Notifications, Starting a Meeting, Client/Patient Information, Troubleshooting, Invite Users
${HelpMenuLive}	 Set Up Guide,Documents,Change Password,Schedule,Email Notifications,,Client/Patient Information,Invite Collaborator/Guest


***Test Cases***
Dashboard_VerifyActionsFromWelcomeHeader_By_Therapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Perform Login Checks
	WelcomeHeader.Click Message Icon
	Messaging.Verify Message Page Displayed
	Capture Page Screenshot
	WelcomeHeader.Click Notification Icon
	Dashboard.TherapistRole.Verify Notifications Table Header Is Visible
	Dashboard.NotificationsTable.Verify Column Is Visible	Date,Name,Message
	Dashboard.NotificationsTable.Verify Status Column is Visible
	Dashboard.Verify Notifications Mark All as Read Link Is Visible
	Capture Page Screenshot
	WelcomeHeader.Click Settings Icon
	TherapistRole.Verify Settings Page Displayed
	Capture Page Screenshot
	WelcomeHeader.Click Help Icon
	Run Keyword if	"${TestEnv}" == "Secure"	Verify Help Page Displayed 	${therapistSecure}	${HelpMenuSecure}	ELSE 	Verify Help Page Displayed	${therapistLive}	${HelpMenuLive}
	Capture Page Screenshot

Dashboard_VerifyActionsFromFooter_By_Therapist
	Footer.Click Privacy Disclaimer
	Verify Privacy Disclaimer Page Opens
	Footer.Click Terms of Use
	Verify Terms of Use Page Opens
	Run Keyword if	"${TestEnv}" == "Secure"	Footer.Click Provider Sign Up
	Run Keyword if	"${TestEnv}" == "Secure"	Verify Provider Sign Up Page Opens
	Logout from Application