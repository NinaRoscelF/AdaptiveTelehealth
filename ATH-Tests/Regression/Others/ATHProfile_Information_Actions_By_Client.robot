** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/OthersPage_res.txt
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers

***Variable***
${IsUpload}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\JPEGFile.jpg
${ProfileImg}	C:\\ATH.Git\\AdaptiveTelehealth\\ATH-Resources\\UploadFile\\FileTypes\\try.jpg


***Test Cases***
ATHProfile_Information_DisplayChangePassword_By_Client

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoClient}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoClient1}	${TestEnv}
	Perform Login Checks
	Select Profile Menu
	ClientProfile.Click Information tab
	ClientProfile.Verify Change Password button is visible
	ClientProfile.Click Change Password button
	ClientProfile.Verify Change Password Inputs Expanded
	Check button existence	Change Password
	Settings.SP.Password.Input New Password Value 	Password1234!!!
	Settings.SP.Password.Click Unmask New Password Input
	Settings.SP.Password.Input Confirm Password Value 	Password1234!!!
	Settings.SP.Password.Click Unmask Confirm Password Input
	ClientProfile.Click Change Password button
	ClientProfile.Verify Change Password Inputs Collapsed

ATHProfile_Information_UploadPatientID_By_Client
	ClientProfile.PatientID.Click Choose File Button	${IsUpload}
	Capture Page Screenshot
	ClientProfile.PatientID.Select Patient ID Type
	ClientProfile.Click Update Information Button
	Check Label Existence 	Data updated.
	ClientProfile.PatientID.Verify File is Uploaded	jpg

ATHProfile_Information_DeletePatientIDuploaded_By_Client
	ClientProfile.PatientID.Delete Uploaded File
	ClientProfile.Click Update Information Button
	Check Label Existence 	Data updated.

ATHProfile_Information_UploadProfileImage_By_Client
	ath click button 	Change
	ClientProfile.ProfileImage.Click Choose File Button	${IsUpload}
	ClientProfile.ProfileImage.Click Add Button
	Check Label Existence 	Profile image has been saved successfully.
	ClientProfile.ProfileImage.Verify Profile Image Displayed
	Check button existence 	Change

#reset to orig profile photo
	ath click button 	Change
	ClientProfile.ProfileImage.Click Choose File Button	${ProfileImg}
	ClientProfile.ProfileImage.Click Add Button
	Check Label Existence 	Profile image has been saved successfully.

ATHProfile_Information_ViewAgreementsDisplay_By_Client
	ath click link 	View My Agreements
	Check Label existence 	My Agreements,Agreements
	Check Label existence 	Agreements,Automatic Agreement,Date Automatic Agreement,Verbal Agreement,Date Verbal Agreement
	Check Link Existence 	Back to My Profile,Terms of Use,Notice of Privacy Policies
	Logout from Application

