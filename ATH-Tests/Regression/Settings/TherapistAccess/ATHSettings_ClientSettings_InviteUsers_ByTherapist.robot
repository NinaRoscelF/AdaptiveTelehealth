** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers

***variables***
${therapistLive}	Automation Therapist
${therapistSecure}	Mary Ellis

***Test Cases***
ATHSettings_CS.InviteUsers_EmailRequired_ByTherapist
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Run Keyword if	"${TestEnv}" == "Secure" 	Settings.AccountSettings.Select SubMenu 	Groups Company Settings	ELSE	Settings.AccountSettings.Select SubMenu 	Client Settings
	Settings.AccountSettings.Select SubMenu 	Invite Users
	Settings.IU.Click Invite a New Guest Button
	Settings.IU.Verify Invite New Guest Page Display
	Run Keyword if	"${TestEnv}" == "Secure"	Check Label Existence	Mary Ellis	ELSE	Check Label Existence	Automation Therapist
	Settings.IU.Click Invite Guest Button
	Settings.IU.InviteGuestPopup.Click Confirm Button
	Settings.IU.Verify Email Address Required

ATHSettings_CS.InviteUsers_FirstNameRequired_ByTherapist
	Settings.IU.Click Go Back Here Link
	Settings.IU.Input Guest Email	test1@mailinator.com
	Settings.IU.Click Invite Guest Button
	Settings.IU.InviteGuestPopup.Click Confirm Button
	Settings.IU.Verify First Name Required

ATHSettings_CS.InviteUsers_LastNameRequired_ByTherapist
	Settings.IU.Click Go Back Here Link
	Settings.IU.Input Guest First Name	test1
	Settings.IU.Input Guest Email	test1@mailinator.com
	Settings.IU.Click Invite Guest Button
	Settings.IU.InviteGuestPopup.Click Confirm Button
	Settings.IU.Verify Last Name Required

ATHSettings_CS.InviteUsers_EmailPreview_ByTherapist
	Settings.IU.Click Go Back Here Link
	${FirstName}	Generate Random String	5	[LETTERS]
	${LastName}	Generate Random String	9	[LETTERS]
	Settings.IU.Input Guest First Name	${FirstName}
	Settings.IU.Input Guest Last Name	${LastName}
	Settings.IU.Input Guest Email	${FirstName}@mailinator.com
	Capture Page Screenshot
	Settings.IU.Click Email Preview Button
	Settings.IU.EmailPreviewPopup.Verify First Name 	${FirstName}
	Settings.IU.EmailPreviewPopup.Verify Last Name 	${LastName}
	Settings.SP.ConsentForm.Close Preview Popup

ATHSettings_CS.InviteUsers_CancelFromCreation_ByTherapist
	Settings.IU.Click Cancel Button
	Verify Dashboard Page displayed

ATHSettings.CS.InviteUsers_CancelInviteUsers_ByTherapist
	WelcomeHeader.Click Settings Icon
	Run Keyword if	"${TestEnv}" == "Secure" 	Settings.AccountSettings.Select SubMenu 	Groups Company Settings	ELSE	Settings.AccountSettings.Select SubMenu 	Client Settings
	Settings.AccountSettings.Select SubMenu 	Invite Users
	Settings.IU.Click Invite a New Guest Button
	${FirstName}	Generate Random String	5	[LETTERS]
	${LastName}	Generate Random String	9	[LETTERS]
	${FullName}	Catenate 	${FirstName}	${LastName}
	Set Suite Variable	${FirstName}
	Set Suite Variable	${FullName}
	Settings.IU.Input Guest First Name	${FirstName}
	Settings.IU.Input Guest Last Name	${LastName}
	Settings.IU.Input Guest Email	${FirstName}@mailinator.com
	Capture Page Screenshot
	Settings.IU.Click Invite Guest Button
	Settings.IU.InviteGuestPopup.Click Cancel Button

ATHSettings.CS.InviteUsers_ConfirmInviteUsers_ByTherapist
	Settings.IU.Click Invite Guest Button
	Settings.IU.InviteGuestPopup.Click Confirm Button
	Settings.IU.Verify Guest Successfully Invited Display 	${FirstName}@mailinator.com 	${FullName}
	Settings.IU.Click Back to Client File Link
	Verify Dashboard Page displayed
	Logout from Application

	Login to Mailinator 	${FirstName}@mailinator.com
	Mailinator.Select First Message
	${myTherapist}	Set Variable If	"${TestEnv}" == "Secure"	${therapistSecure} 	${therapistLive}
	Capture Page Screenshot
	Settings.IU.Mailinator.Verify Email Contents 	${FullName}	${myTherapist}
