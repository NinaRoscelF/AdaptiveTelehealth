*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***
${Filelocation}	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources
${Filename}	dummy1.pdf
${Filename2}	dummy25.pdf
${FileType}	pdf

***Test Cases***
MessagingClient_031
#star a message
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${Client2}	${TestEnv}
	Perform Login Checks
	Select Messaging Menu
	Messaging.Select Inbox Menu
	${mySubj}	Messaging.Inbox.Get Subject Column of Selected Message
	Set Suite variable	${mySubj}
	Messaging.Select Message as Starred
	Messaging.Select Starred Menu
	Ath Verify Element Is Visible	xpath=(//tr/td[normalize-space()="${mySubj}"])[1]

MessagingClient_032
#unstar a message
	Messaging.Select Inbox Menu
	Messaging.Unstar a Starred Message
	Messaging.Select Starred Menu
	Ath Verify Element Is Visible	xpath=(//tr/td[normalize-space()="${mySubj}"])[1]
	Check Label Existence	No starred messages. Stars allows you to mark important

MessagingClient_033
	ath click icon	xpath=//*[contains(@src,'/MENU_createfolder.png')]
	ath input text value 	//input[@name='new_folder'] 	${mySubj}
	ath_launch_via_shortcut_keys 	ENTER 	//input[@name='new_folder']
	Sleep 	10.0
	ath wait until loaded 	30
	ath click button	xpath=//*[normalize-space()="Folder created successfully"]/ancestor::div[@class="modal-dialog"]/descendant::div[@class="modal-footer"]/descendant::button[normalize-space()="OK"]
	Capture Page Screenshot

MessagingClient_034
	Execute Javascript	var element = document.evaluate("//a[@controls-title='${mySubj}']" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue;if (element != null) {element.click();}
	Sleep 	10.0
	ath wait until loaded 	30
	Check Label Existence 	No Records Found
	ath click icon 	xpath=//a[@controls-title='${mySubj}']/span[text()="X"]
	Capture Page Screenshot
	ath click button	xpath=//*[normalize-space()="Remove Folder"]/ancestor::div[@class="modal-dialog"]/descendant::div[@class="modal-footer"]/descendant::button[normalize-space()="No"]

MessagingClient_035
	Execute Javascript	var element = document.evaluate("//a[@controls-title='${mySubj}']" ,document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null ).singleNodeValue;if (element != null) {element.click();}
	Sleep 	10.0
	ath wait until loaded 	30
	Check Label Existence 	No Records Found
	ath click icon 	xpath=//a[@controls-title='${mySubj}']/span[text()="X"]
	Capture Page Screenshot
	ath click button	xpath=//*[normalize-space()="Remove Folder"]/ancestor::div[@class="modal-dialog"]/descendant::div[@class="modal-footer"]/descendant::button[normalize-space()="Yes"]
	Sleep 	5.0
	ath wait until loaded 	30
	Capture Page Screenshot
	Check label Existence 	Custom Folder has been deleted successfully.
	Logout from Application
