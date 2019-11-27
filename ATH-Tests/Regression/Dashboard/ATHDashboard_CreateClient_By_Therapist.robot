*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***


***Test Cases***
SchedulingTherapist_001
#wdigets display

	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}
	Perform Login Checks
	ath click button 	Invite Client
	ath input text value	Enter Groups Company's Email Address 	random01@mailinator.com
	ath click button 	Invite Groups Company
	ath verify element is visible 	xpath=//*[text()="Successfully Sent"]
	ath verify element is visible 	xpath=//*[text()="Groups Company's email:"]
	ath verify element is visible 	xpath=//*[normalize-space()="random01@mailinator.com"]
	Login to Mailinator
	Get Code From Mailinator
	Select new window
	Complete registration Process 	random01 	randomlast	random01@mailinator.com
	//a[text()="login to the platform here"]
	Sleep 	2.0
	ath wait until element is present	//h3[@class="box-title"][normalize-space()="Login"]
	Input Email Address 	random01@mailinator.com
	Input Password 	Password123!!!
	Click Login Button
	Ath select drop down field value 	Timezone	(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi
	ath click button 	Submit
	Run keyword and ignore error	mouse down on image	xpath=//canvas[@id='dd_canvas']
	Run keyword and ignore error	Mouse up 	xpath=//canvas[@id='dd_canvas']
	ath click button 	Ok
