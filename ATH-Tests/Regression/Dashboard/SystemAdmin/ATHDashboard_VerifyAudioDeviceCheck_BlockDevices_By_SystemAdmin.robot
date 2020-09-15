*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Dashboard_VerifyAudioDeviceCheck_BlockDevices_By_SystemAdmin

	Run Keyword if 	"${TestEnv}" == "Secure" 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin}	${TestEnv} 	ELSE 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin1}	${TestEnv}
	Perform Login Checks
	WelcomeHeader.Click Device Check Icon
	Dashboard.Verify Device Icons are Visible
	Dashboard.DeviceCheck.Click Run Auto Device Check button
	Check Button existence 	Check my Browser
	Dashboard.DeviceCheck.Click Check My Browser button
	Check Label existence 	Your browser is , SUPPORTED,Chrome 78 On Windows
	Dashboard.DeviceCheck.Verify Device is Allowed	Browser
	Dashboard.DeviceCheck.Click Continue BUtton
	Dashboard.DeviceCheck.Webcam.Click Block BUtton
	Dashboard.DeviceCheck.Verify Device is Blocked	Webcam
	Dashboard.DeviceCheck.Microphone.Click Block BUtton
	Dashboard.DeviceCheck.Verify Device is Blocked	Microphone
	Dashboard.DeviceCheck.Speaker.Click No I Cant Button
	Dashboard.DeviceCheck.Click OK to troubleshoot
	Check Label existence 	All Users,Search:
	Logout from Application