*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/DashboardPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Dashboard_VerifyAudioDeviceCheck_SuccessfulConfiguration_By_Admin

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Perform Login Checks
	WelcomeHeader.Click Device Check Icon
	Check label existence 	AUTO DEVICE CHECK
	Dashboard.Verify Device Icons are Visible
	Dashboard.DeviceCheck.Click Run Auto Device Check button
	Check Label existence 	If you are using either Google Chrome or Safari browser and your browser is up to date, this test will take just a few seconds. If you are using other browsers, you will be prompted to download Chrome or Safari and log into this platform again.
	Check Button existence 	Check my Browser
	Dashboard.DeviceCheck.Click Check My Browser button
	Check Label existence 	Your browser is , SUPPORTED,Chrome 78 On Windows
	Dashboard.DeviceCheck.Verify Device is Allowed	Browser
	Check Button existence 	Continue
	Dashboard.DeviceCheck.Click Continue BUtton
	Check Label existence 	ATH wants to use your camera, please click Allow. You can switch off your video after you have entered the room. DO NOT BLOCK as this will cause Online Meetings to be unable to function properly.
	Check Button existence 	Block,Allow
	Dashboard.DeviceCheck.Webcam.Click Allow BUtton
	Dashboard.DeviceCheck.Webcam.Click Yes I Can Button
	Dashboard.DeviceCheck.Verify Device is Allowed	Webcam
	Check Label existence 	ATH wants to use your microphone, please click Allow. You can switch off your audio after you have entered the room. DO NOT BLOCK as this will cause Online Meetings to be unable to function properly.
	Check Button existence 	Block,Allow
	Dashboard.DeviceCheck.Micorphone.Click Allow BUtton
	check label existence 	Can you see the volume bar moving as you speak?
	Dashboard.DeviceCheck.Microphone.Click Yes I Can Button
	Dashboard.DeviceCheck.Verify Device is Allowed	Microphone
	Check Label existence 	Turn up the volume of your speaker and click the Play button in the center of the video. Can you hear the audio?
	Check Button existence	No,Yes
	Dashboard.DeviceCheck.Speaker.Click Yes I Can Button
	Dashboard.DeviceCheck.Verify Device is Allowed	Speaker
	Dashboard.DeviceCheck.Device Check Process Successful
	Logout from Application