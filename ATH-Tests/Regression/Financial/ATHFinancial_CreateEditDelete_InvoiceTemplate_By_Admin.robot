*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/OthersPage_res.txt
Suite Teardown	Close All Browsers
Force Tags	System:Secure

***Test Cases***
Financial_Invoice_CreateTemplate_SaveWithoutDetails_By_Therapist


	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoAdmin}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoAdmin1}	${TestEnv}
	${DtToday}	Generate Date and Time Today 	%d-%b-%Y
	${endDate}	ath_GetDateTime	<<SPECDATE end of curr month>>	%d-%b-%Y
	Set Suite Variable 	${DtToday}
	Set Suite Variable 	${endDate}
	Select Financial Menu
	ath click link 	Invoice
	ath click button	Create Templates
	ath input text value 	//input[@name='template_name'] 	Automation template
	ath click icon	xpath=//*[contains(text(),'Invoice Creator')]/following::div[1]/div
	ath click icon	xpath=//li[contains(text(),'Therapist2')]
	ath_select_date_from_datepicker 	${DtToday}	xpath=//input[@name='dureation_start_date']
	ath_select_date_from_datepicker 	${endDate}	xpath=//input[@name='dureation_end_date']
	Capture Page Screenshot
	ath click button 	Save
	Check label existence 	The template is empty,Please create some fields.
	ath click button 	xpath=//*[contains(normalize-space(),'template is empty')]/ancestor::div[@class="modal-dialog"]/descendant::button[contains(normalize-space(),'Ok')]

	ath click link 	Return to templates
	Sleep 	3.0
	ath wait until loaded 	30

Financial_Invoice_CreateTemplate_CancelSaveWithDetails_By_Therapist
	ath click button	Create Templates
	ath input text value 	//input[@name='template_name'] 	Automation template
	ath click icon	xpath=//*[contains(text(),'Invoice Creator')]/following::div[1]/div
	ath click icon	xpath=//li[contains(text(),'Therapist2')]
	ath_select_date_from_datepicker 	${DtToday}	xpath=//input[@name='dureation_start_date']
	ath_select_date_from_datepicker 	${endDate}	xpath=//input[@name='dureation_end_date']
	Capture Page Screenshot
	ath click button 	xpath=//span[contains(text(),'Title of Invoice')]
	Check label Existence 	Title of Invoice
	Check button existence 	Add,Cancel
	ath input text value 	Enter invoice title	auto Invoice
	ath click button 	Cancel
	Capture Page Screenshot

Financial_Invoice_CreateTemplate_SaveWithDetails_By_Therapist
	${DtToday}	Generate Date and Time Today 	%Y-%m-%d
	${endDate}	ath_GetDateTime	<<SPECDATE end of curr month>>	%Y-%m-%d
	Set Suite variable 	${DtToday}
	Set Suite variable	${endDate}
	ath click button 	xpath=//span[contains(text(),'Title of Invoice')]
	Check label Existence 	Title of Invoice
	Check button existence 	Add,Cancel
	ath input text value 	Enter invoice title	auto Invoice
	ath click button 	Add
	ath wait until loaded 	30
	ath click button 	Save
	Sleep 	20.0
	ath wait until loaded 	30
	Capture Page Screenshot
	ath verify element is visible 	xpath=//td[contains(text(),'template')]
	ath verify element is visible 	xpath=//td[contains(text(),'${DtToday}')]
	ath verify element is visible 	xpath=//td[contains(text(),'${endDate}')]

Financial_Invoice_InputSearchCriteria_By_Admin
	ath input text value 	xpath=(//label[contains(text(),"Search ")])/input	Automation template
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Not Be True 	${status}

Financial_Invoice_CreateTemplate_EditCreatedTemplate_By_Therapist
	ath click link 	xpath=//td[6][contains(text(),'${DtToday}')]/following::td/descendant::a[text()="Edit"]
	ath input text value 	//input[@name='template_name'] 	Edit Automation template
	# ath click button 	xpath=//span[contains(text(),'Title of Invoice')]
	# ath input text value 	xpath=//label[contains(text(),'Enter invoice title:')]//input[@class='form-control']	Edit invoice
	# ath click button 	Add
	# ath wait until loaded 	30
	# ath verify element is visible 	xpath=//*[contains(@class,'invoice_field')]/descendant::h2[contains(text(),'Invoice')]
	Capture Page Screenshot
	ath click button 	Save
	Sleep 	20.0
	ath wait until loaded 	30
	ath verify element is visible 	xpath=//td[contains(text(),'Edit Automation')]

Financial_Invoice_CreateTemplate_DeleteCreatedTemplate_By_Therapist
	ath click link 	xpath=(//td[6][contains(text(),'${DtToday}')]/following::td/descendant::a[text()="Delete"])[1]
	ath verify element is visible 	xpath=//td[contains(text(),'${DtToday}')] 	false
	Capture Page Screenshot

Financial_Invoice_MoveToNextPage_By_Supervisor
	Move to Next Page

Financial_Invoice_MoveToPreviousPage_By_Supervisor
	Move to Previous Page

Financial_Invoice_SelectPageNumber_By_Supervisor
	Select Page Number 	3
	Logout from Application
