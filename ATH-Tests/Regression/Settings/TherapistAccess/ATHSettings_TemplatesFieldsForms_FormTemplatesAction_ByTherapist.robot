** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SettingsPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
ATHSettings.TFF.FormTemplates_DisplayCreateNewTemplatePage
	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Templates, Fields and Forms
	Settings.AccountSettings.Select SubMenu 	Form Templates
	Settings.TFF.Click Create New Template Button
	Select Frame 	//iframe[@id='contactFormGenerator']
	Settings.TFF.Select Colors Selection Input
	Settings.TFF.Verify Colors Selection Widget Displayed
	Settings.TFF.Select Inputs Selection Input
	Check label existence 	Input design
	Settings.TFF.Close Selection Input
	Settings.TFF.Verify Template Element Exists 	Title,Paragraph,Today's Date,Date Completed,Single line text,Multi-line text,Checkbox,Radio button,Select drop-down,Upload,Date,Time,Rating,Smoking Status,Image,Separator,Treatment Goals,Client's Date of Birth

	Run Keyword if	"${TestEnv}" == "Secure"	Settings.TFF.Verify Template Checkbox Exists	Draft,Archived,Form cannot be edited by Groups Company after filled,Groups Company Signature Pad,Group Therapist Signature Pad,Groups Supervisor Signature Pad,Prompt on first login	ELSE 	Settings.TFF.Verify Template Checkbox Exists	Draft,Archived,Form cannot be edited by Client after filled,Client Signature Pad,Provider Signature Pad,Supervisor Signature Pad,Prompt on first login

ATHSettings.TFF.FormTemplates_CreateNewTemplate
	Settings.TFF.Input New Template Name	Automation template
	Settings.TFF.Click Copy Template Button
	Run Keyword and Ignore Error	ath click button	xpath=//div[contains(@class,' ui-helper-clearfix')]/descendant::span[text()="OK"]
	Settings.TFF.Click Save Template Button
	Sleep 	20.0
# 	Settings.TFF.Verify Template is Saved Successfully
	Unselect Frame
ATHSettings.TFF.FormTemplates_SelectCreatedTemplateFromDropdown
	Select Dashboard Menu
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Templates, Fields and Forms
	Settings.AccountSettings.Select SubMenu 	Form Templates
	Settings.TFF.Click Create New Template Button
	Settings.TFF.Select Created Template 	Automation template
	Run Keyword and Ignore Error	ath click button	xpath=//div[contains(@class,' ui-helper-clearfix')]/descendant::span[text()="OK"]
	Select Frame 	//iframe[@id='contactFormGenerator']
	ath verify element is visible 	xpath=//div[@class='warning']/descendant::strong[contains(text(),'You are trying to load a form')]
	Capture Page Screenshot
	Unselect Frame

ATHSettings.TFF.FormTemplates_CancelDeleteCreatedTemplateAction
	Select Dashboard Menu
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Templates, Fields and Forms
	Settings.AccountSettings.Select SubMenu 	Form Templates
	Settings.TFF.Click Create New Template Button
	Select Frame 	//iframe[@id='contactFormGenerator']
	Settings.TFF.Select Clear Template Action
	Settings.TFF.ClearTemplatePopup.Click Cancel button

ATHSettings.TFF.FormTemplates_DeleteCreatedTemplateAction
	Settings.TFF.Select Clear Template Action
	Settings.TFF.ClearTemplatePopup.Click Delete All items button
	unselect Frame

ATHSettings.TFF.FormTemplates_SelectRecordsPerPage_ByTherapist
	Select Dashboard Menu
	WelcomeHeader.Click Settings Icon
	Settings.AccountSettings.Select SubMenu	Templates, Fields and Forms
	Settings.AccountSettings.Select SubMenu 	Form Templates
	Settings.TFF.Select Records per Page 	100
	Capture Page Screenshot


ATHSettings_Notepad_NextAndPreviousDisplayed_ByTherapist
	Move to Next Page
	Move to Previous Page

ATHSettings_Notepad_SortOrderColumn_ByTherapist
	Settings.TFF.Sort Order Column

ATHSettings_Notepad_SortDateColumn_ByTherapist
	Settings.TFF.Sort Date Created Column

ATHSettings_Notepad_SearchNotepadEntry_ByTherapist
	Settings.TFF.Input Search Criteria 	sample automated
	ath verify element is visible 	xpath=//table[@id='formBoxes']/descendant::a[text()="sample automated"]

	Logout from Application