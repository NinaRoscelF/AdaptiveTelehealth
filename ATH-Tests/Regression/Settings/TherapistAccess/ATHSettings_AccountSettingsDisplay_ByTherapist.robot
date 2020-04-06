** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***variables***
${therapistLive}	Automation Therapist
${therapistSecure}	Mary Ellis
${dateJoinedSecure}	10/18/2019
${dateJoinedLive}	01/02/2020


***Test Cases***
ATHSettings_AccountSettings_AccountInformationDisplay_ByTherapist

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	TherapistRole.Verify Settings Page Displayed
	Capture Page Screenshot
	Settings.AS.AcctInfo.Verify Account Information Label Display
	Run Keyword if	"${TestEnv}" == "Secure"	Settings.AS.AcctInfo.Verify Account Information Details Is Displayed	${therapistSecure}	${AutoTherapist}	${dateJoinedSecure}	ELSE 	Settings.AS.AcctInfo.Verify Account Information Details Is Displayed	${therapistLive}	${AutoTherapist1}	${dateJoinedLive}
	Settings.AS.AcctInfo.Verify Cancel Your Account button displayed
	Settings.AS.AcctInfo.Verify Contact Us button displayed

ATHSettings_AccountSettings_AccountInformation_ClickContactUs_ByTherapist
	Settings.AS.AcctInfo.Click Contact Us button
	Settings.AS.AcctInfo.Contact Us Page Displayed

ATHSettings_AccountSettings_AccountInformation_ClickCancelAccount_ByTherapist
	Settings.AS.AcctInfo.Click Cancel Your Account button
	Settings.AS.AcctInfo.CancelAccount.Select Cancel Action	No

ATHSettings_AccountSettings_CustomBackgroundsDisplay_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Backgrounds
	Settings.AS.CustomBackground.Verify Background Page Display

ATHSettings_AccountSettings_EditPublicProfileDisplay_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Edit Public Profile
	Settings.AS.EditPublicProfile.Verify Profile Page Display

ATHSettings_AccountSettings_LogoSettingsDisplay_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Logo Settings
	Settings.AS.LogoSettings.Verify Logo Settings Page Display

ATHSettings_AccountSettings_MerchantServicesDisplay_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Merchant Services
	Settings.AS.MerchantServices.Verify Merchant Services Page Display

ATHSettings_AccountSettings_SignatureClinicianDisplay_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Signature
	Settings.AS.Signature.Verify Signature/Clinician Page Display

ATHSettings_AccountSettings_TimezoneDisplay_ByTherapist
	Settings.AccountSettings.Select SubMenu 	Timezone
	Settings.AS.Timezone.Verify Timezone Page Display
	Logout from Application