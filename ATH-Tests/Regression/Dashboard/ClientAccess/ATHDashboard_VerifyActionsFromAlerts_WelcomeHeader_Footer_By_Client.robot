*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DashboardPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/MessagingPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***variables***
${therapistLive}	Automation
${therapistSecure}	Ginger
${HelpMenuSecure}	 Reschedule an Appointment, Notifications via email
#${HelpMenuLive}	 Starting a Meeting, Notification Via Email, Troubleshooting
${HelpMenuLive}	 Search

***Test Cases***
Dashboard_VerifyActionsFromWelcomeHeader_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	WelcomeHeader.Click Message Icon
	Messaging.Verify Message Page Displayed
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

Dashboard_Alerts_SelectRecordsPerPage_By_Client
	Select Dashboard Menu
	ath verify element is visible 	xpath=//section[@id="notification-section"]/descendant::label[text()="Records per page "]
	ath verify element is visible 	xpath=//section[@id="notification-section"]/descendant::label[contains(text(),'Search')]/input
	Settings.TFF.Select Records per Page 	100 	3
	Capture Page Screenshot

Dashboard_Alerts_InputSearchCriteria_By_Client
	Settings.TFF.Input Search Criteria 	therapist 	3
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure 	Should not be true	${status}
	Capture Page Screenshot

Dashboard_Alerts_CancelMarkAsRead_By_Client
	ath click link 	Mark all as read
	Capture Page Screenshot
	Run Keyword and Ignore Error	ath click button 	Close
	Run Keyword and Ignore Error	ath click button 	xpath=//*[contains(normalize-space(),'Mark all as read')]/ancestor::div[@class="modal-dialog"]/descendant::button[contains(normalize-space(),'Close')]

Dashboard_Alerts_MarkAsRead_By_Client
	ath click link 	Mark all as read
	ath click button 	xpath=//*[contains(normalize-space(),'Mark all as read')]/ancestor::div[@class="modal-dialog"]/descendant::button[contains(normalize-space(),'Apply')]
	Capture Page Screenshot

Dashboard_VerifyActionsFromFooter_By_Therapist
	Footer.Click Privacy Disclaimer
	Verify Privacy Disclaimer Page Opens
	Footer.Click Terms of Use
	Verify Terms of Use Page Opens
	Logout from Application