** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/OthersPage_res.txt
Suite Teardown	Close All Browsers


***variables***
${HelpMenuSecure}	 Reschedule an Appointment, Notifications via email
${HelpMenuLive}	 Troubleshooting
${therapistLive}	Automation IsClient
${therapistSecure}	Ginger Taylor

***Test Cases***
ATHCommunity_VerifyPageDisplay_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Community Menu
	Check Label Existence 	All Threads
	Check Link Existence 	COMMUNITY FORUM,Stress Relief,Anxiety Meditation

ATHCommunity_DisplaySelectedCommunityPage_By_Client
	Community.Select Community Name Link	Stress Relief
	Run Keyword and Ignore Error 	Check Label Existence 	Test Itours Community,This is a Test Community
	Check Link Existence 	Categories,Anxiety,Addictions,Parenting

ATHCommunity_DisplaySelectedCategoryPage_By_Client
	Community.Select Community Name Link	Better relationships
	Check Label Existence 	All Threads,Last Updates
	Check Link Existence 	Forum,Dashboard,Logout

ATHCommunity_ClickHomeLink_DisplayCommunityPage_By_Client
	Community.Select Community Name Link	Home	2
	Community.Verify Community Table Displayed

ATHCommunity_ClickHomeLink_DisplayDashboardPage_By_Client
	Select Community Menu
	Community.Select Community Name Link	Test Itours Community
	Community.Select Community Category Link	Anxiety
	Community.Select Community Name Link	Home
	Verify Dashboard Page displayed


ATHFAQS_VerifyPageDisplay_By_Client
	Select FAQs Menu
	Run Keyword if	"${TestEnv}" == "Secure"	Verify Help Page Displayed 	${therapistSecure}	${HelpMenuSecure}	ELSE 	Verify Help Page Displayed	${therapistLive}	${HelpMenuLive}
	Logout from Application

