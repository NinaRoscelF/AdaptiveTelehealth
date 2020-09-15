*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Dashboard_VerifyAudioDeviceCheck_CannotDisplayCamera_By_SystemAdmin

	Run Keyword if 	"${TestEnv}" == "Secure" 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin}	${TestEnv} 	ELSE 	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin1}	${TestEnv}
	Perform Login Checks
	WelcomeHeader.Click Device Check Icon
	Dashboard.DeviceCheck.Click Run Auto Device Check button
	Check Button existence 	Check my Browser
	Dashboard.DeviceCheck.Click Check My Browser button
	Check Label existence 	Your browser is , SUPPORTED,Chrome 78 On Windows
	Dashboard.DeviceCheck.Verify Device is Allowed	Browser
	Dashboard.DeviceCheck.Click Continue BUtton
	Dashboard.DeviceCheck.Webcam.Click Allow BUtton
	Dashboard.DeviceCheck.Webcam.Click No I Cant Button
	Dashboard.DeviceCheck.Click OK to troubleshoot
	Check Label existence 	All Users,Search:

Dashboard_VerifyAudioDeviceCheck_CannotHearMicrophone_By_SystemAdmin
	WelcomeHeader.Click Device Check Icon
	Dashboard.DeviceCheck.Click Run Auto Device Check button
	Check Button existence 	Check my Browser
	Dashboard.DeviceCheck.Click Check My Browser button
	Check Label existence 	Your browser is , SUPPORTED,Chrome 78 On Windows
	Dashboard.DeviceCheck.Verify Device is Allowed	Browser
	Dashboard.DeviceCheck.Click Continue BUtton
	Dashboard.DeviceCheck.Webcam.Click Allow BUtton
	Dashboard.DeviceCheck.Webcam.Click Yes I Can Button
	Dashboard.DeviceCheck.Verify Device is Allowed	Webcam
	Dashboard.DeviceCheck.Micorphone.Click Allow BUtton
	check label existence 	Can you see the volume bar moving as you speak?
	Dashboard.DeviceCheck.Microphone.Click No I Cant Button
	Dashboard.DeviceCheck.Click OK to troubleshoot
	Check Label existence 	All Users,Search:

Dashboard_VerifyAudioDeviceCheck_CannotHearSpeaker_By_SystemAdmin
	WelcomeHeader.Click Device Check Icon
	Dashboard.DeviceCheck.Click Run Auto Device Check button
	Check Button existence 	Check my Browser
	Dashboard.DeviceCheck.Click Check My Browser button
	Check Label existence 	Your browser is , SUPPORTED,Chrome 78 On Windows
	Dashboard.DeviceCheck.Verify Device is Allowed	Browser
	Dashboard.DeviceCheck.Click Continue BUtton
	Dashboard.DeviceCheck.Webcam.Click Allow BUtton
	Dashboard.DeviceCheck.Webcam.Click Yes I Can Button
	Dashboard.DeviceCheck.Verify Device is Allowed	Webcam
	Dashboard.DeviceCheck.Micorphone.Click Allow BUtton
	Dashboard.DeviceCheck.Microphone.Click Yes I Can Button
	Dashboard.DeviceCheck.Verify Device is Allowed	Microphone
	Check Label existence 	Turn up the volume of your speaker and click the Play button in the center of the video. Can you hear the audio?
	Dashboard.DeviceCheck.Speaker.Click No I Cant Button
	Dashboard.DeviceCheck.Click OK to troubleshoot
	Check Label existence 	All Users,Search:
	Logout from Application
