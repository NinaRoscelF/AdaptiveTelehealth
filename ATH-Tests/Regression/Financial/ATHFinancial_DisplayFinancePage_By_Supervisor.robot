*** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/OthersPage_res.txt
Suite Teardown	Close All Browsers


***Test Cases***
Financial_DisplayInvoicePage_By_Supervisor

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoSupervisor1}	${TestEnv}
	Select Financial Menu
	ath click link 	Invoice
	ath verify element is visible 	xpath=//h3[contains(text(),'Assigned For')]/../../descendant::table
	ath verify element is visible 	xpath=//h3[contains(text(),'Created Invoices')]/../../descendant::table
	Check Label Existence	Assigned For My Approval Invoices
	Clients.Verify Record Per Page Dropdown Is Visible
	Clients.Verify Search Input Is Visible
	Check Button Existence 	Invoice Templates,Create Templates

Financial_Invoice_SelectRecordsPerPageDisplay_By_Supervisor
	Clients.Select Records Per Page Value 	100
	Capture Page Screenshot

Financial_Invoice_InputSearchCriteria_By_Admin
	ath input text value 	xpath=(//label[contains(text(),"Search ")])/input	Emma Stoneage
	${status}	Run Keyword and Return Status	Dashboard.GroupsCompanyWidget.Verify No Results found
	Run Keyword and Continue on Failure	Should Be True 	${status}
	Logout from Application
