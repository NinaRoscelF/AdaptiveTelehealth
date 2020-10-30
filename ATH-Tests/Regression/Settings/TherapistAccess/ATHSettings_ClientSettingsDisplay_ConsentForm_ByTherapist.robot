** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***variables***
${ConsentBody}	Automated consent form
${ConsentTitle}	Automated form title

***Test Cases***
ATHSettings_ClientSettingsDisplay_ByTherapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Run Keyword if	"${TestEnv}" == "Secure" 	Settings.AccountSettings.Select SubMenu 	Groups Company Settings	ELSE	Settings.AccountSettings.Select SubMenu 	Client Settings
	Settings.AccountSettings.Select SubMenu 	Client Informed Consent Form
	TherapistRole.Verify Client Consent Form Page Displayed
	Settings.AccountSettings.Select SubMenu 	Invite Users
	Settings.CS.Verify Invite Users Page Displayed
	Settings.AccountSettings.Select SubMenu 	Display Authorization Code
	Check Label Existence	Display Authorization Code
	Settings.CS.Click Schedule OnOff SubMenu
	Settings.CS.Verify Schedule Client Page Displayed


ATHSettings_CS.ClientInformedConsentForm_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Client Informed Consent Form
	Settings.CS.Input Consent Title	${ConsentTitle}
	Settings.CS.Input Consent Body 	${ConsentBody}
	Settings.CS.Preview Consent Input
	Settings.CS.Verify Consent Form Detail Is Previewed	${ConsentBody}
	Settings.SP.ConsentForm.Close Preview Popup
	Settings.CS.Click Save Button
	Run Keyword and Ignore Error	Settings.CS.Verify Consent Form Is Saved Successfully
	Settings.CS.Verify Consent Form Remaining 	4
	Settings.CS.Click Delete Button
	Settings.CS.Verify Consent Form Remaining 	5
	Logout from Application
