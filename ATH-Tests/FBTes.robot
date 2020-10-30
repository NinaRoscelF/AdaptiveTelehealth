*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***


***Test Cases***
Automated FB
	Open Browser	https://web.facebook.com/potsnsoil.antipolo.ph/	Chrome 	FB	ff_profile_dir=firefoxprofile
	Maximize Browser Window
	Ath Wait Until Loaded	30
	Capture Page Screenshot
#	ath click button 	xpath=//a[@class='_42ft _4jy0 _3obb _4jy6 _4jy1 selected _51sy']

	ath input text value 	xpath=//div[@class='menu_login_container rfloat _ohf']//input[@name='email']	ninaroscel@yahoo.com
	ath input text value 	xpath=//div[@class='menu_login_container rfloat _ohf']//input[@name='pass']	joscelerin17
	ath click button 	xpath=//label[@class='login_form_login_button uiButton uiButtonConfirm']//input
	Sleep 	30.0
	ath wait until loaded 	30
	Execute Javascript	var element = document.evaluate("//a[@class='_3rwx _42ft']" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue;if (element != null) {element.click();}
#	ath click link	xpath=//a[@class='_3rwx _42ft']
	Sleep 	60.0
	Capture Page Screenshot
	${count}	get Matching xpath count 	xpath=//*[@class="fwn fcg"]/descendant::a
	
	${name}	Get element attribute 	//*[@class="fwn fcg"]/descendant::a@textContent