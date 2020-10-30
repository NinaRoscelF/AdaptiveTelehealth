** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Resource	${EXECDIR}../../ATH-Resources/Flows/DashboardPage_res.txt
Suite Teardown	Close All Browsers

***Variables***
${uploadLogo}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\FileTypes\\try.jpg

***Test Cases***
ATHSettings_AccountSettings_EditPublicProfile_ByTherapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Edit Public Profile
	Settings.AS.EditPublicProfile.Verify Profile Page Display
	Settings.AS.EditPublicProfile.Click Edit Button
	Settings.AS.EditPublicProfile.Verify Checkbox State	Display in Public Directory
	Settings.AS.EditPublicProfile.Verify Checkbox State	Display Profile to clients 	false
	Settings.AS.EditPublicProfile.Verify Checkbox State	Hide profile from internal provider directory 	false
	Settings.AS.EditPublicProfile.Verify Checkbox State	Display in Referral Directory
	Check Label Existence 	Profile Visibility,Custom Provider Directory page link, The current link to your provider directory page is:
	Run Keyword if	"${TestEnv}" == "Secure"	ath check links displayed 	http://tinyurl.com/vfxktm9 	ELSE 	ath check links displayed 	http://tinyurl.com/uus8t8p


	Check Label Existence 	Company name,Name,NPI,Religion,License type,License number,License state,Phone Number,Location,School,Certification
	Check Label Existence 	Practice Areas,Ages,Topics,Specializations,Contact page message
	Check button existence 	Preview,Save Draft,Publish

ATHSettings_AS.EPP_SaveDraftPublicProfile_ByTherapist
	Select Dashboard Menu
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Edit Public Profile
	Settings.AS.EditPublicProfile.Click Edit Button
	Settings.EPP.Input Company Name	ATH Telehealth
	${NPIGen}	Generate Random String	8	[NUMBERS]
	${TelNo}	Generate Random String	12	[NUMBERS]
	Set Suite Variable	${NPIGen}
	Settings.EPP.Input NPI	${NPIGen}
	Settings.EPP.Input Phone Number	${TelNo}
	Ath Set Text Area Value	Contact page message 	automation message
	Settings.EPP.Click Save Draft button
	Settings.EPP.Verify Profile Is Saved Successfully

ATHSettings_AS.EPP_PublishPublicProfile_ByTherapist
	Settings.EPP.Click Publish button
	Settings.EPP.Verify Profile Is Saved Successfully

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSystemAdmin1}	${TestEnv}
	Perform Login Checks
	Dashboard.ProvidersWidget.Select Records per Page Value 	100
	Run Keyword if	"${TestEnv}" == "Secure"	Dashboard.ProvidersWidget.Select Newly Created Provider	Mary Ellis	ELSE	Dashboard.ProvidersWidget.Select Newly Created Provider	Automation Therapist
	Dashboard.ClientProfile.Verify NPI Detail	${NPIGen}

ATHSettings_AS.LogoSettings_UploadLogo_ByTherapist
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Logo Settings
	Settings.LS.Choose Logo File for Upload 	${uploadLogo}
	Settings.LS.Click Upload Loago Button
	Settings.LS.Verify Logo Changed Successfully


ATHSettings_AS.LogoSettings_DeleteLogo_ByTherapist
	Settings.LS.Click Delete Loago Button
	Settings.LS.Verify Logo Deleted Successfully
	Logout from Application
