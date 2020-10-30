*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/DashboardPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Dashboard_InviteToCommunity_By_Therapist
	[Tags]	System:Secure

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	Dashboard.Click Invite to Community Button
	Check label existence 	Invite Client to the Community,Select a client below,Date Created
	${clientName}	Get element attribute 	xpath=(//tr/td/descendant::a)[1]@textContent
	ath click link 	${clientName}
	Sleep 	2.0
	ath wait until loaded 	30
	ath verify element is visible 	xpath=//div[contains(text(),'was invited to join the community.')]
	ath click link 	Invite another client to the community
	Logout from Application