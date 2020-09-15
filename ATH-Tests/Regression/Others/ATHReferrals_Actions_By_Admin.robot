*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/MessagingPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Referrals_DisplayReferralPage_By_Admin

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	Perform Login Checks
	Select Referrals Menu
# 	ath verify element is visible 	xpath=//*[normalize-space()="Referral Dashboard"]/following-sibling::div[1]/descendant::section
# 	Check label Existence 	Referral Dashboard,Make a Referral,Referrals Received,Referrals Made
# 	Check Link Existence 	Referral Archive,request one

# Referrals_ReferralArchive_By_Admin
# 	ath click link 	Referral Archive
# 	Check Label Existence 	Referrals Made - Archive
# 	ath verify element is visible 	xpath=//*[normalize-space()="Referrals"]/following-sibling::div[1]/descendant::section
# 	Capture Page Screenshot

ATHReferrals_Create_WithNoSelectedUser_By_Supervisor
#	Go back
#	ath click link 	xpath=//div[@class='container-fluid']//a[1]
#https://prnt.sc/ub2cjd
	ath verify element is visible 	xpath=//*[normalize-space()="Referral Form Template"]/following-sibling::div[1]/descendant::section
	ath input text value 	Label of Referral Form 	Automation Label
	ath click button 	xpath=//section/descendant::button[text()="Save Form"]
	ath verify element is visible 	xpath=//*[contains(normalize-space(),'You have not selected')]/ancestor::div[@class="modal-dialog"]
	Capture Page Screenshot
	ath click button 	xpath=//*[contains(normalize-space(),'You have not selected')]/ancestor::div[@class="modal-dialog"]/descendant::div[@class="modal-footer"]/descendant::button[normalize-space()="Close"]

ATHReferrals_Create_WithSelectedUser_By_Supervisor
	ath input text value 	Label of Referral Form 	Automation Label
	Run Keyword and Ignore Error	ath select drop down value 	Atasha Aaron
	Run Keyword and Ignore Error	ath click icon 	xpath=//input[@value="Choose template users"]
	Run Keyword and Ignore Error	ath click icon 	xpath=//ul[@class="chosen-results"]/descendant::li[contains(normalize-space(),'Mary Ellis')]
	ath click button 	Save Form
	ath click button 	xpath=//*[contains(normalize-space(),'You have not selected')]/ancestor::div[@class="modal-dialog"]/descendant::div[@class="modal-footer"]/descendant::button[normalize-space()="Ok"]
	Logout from Application
