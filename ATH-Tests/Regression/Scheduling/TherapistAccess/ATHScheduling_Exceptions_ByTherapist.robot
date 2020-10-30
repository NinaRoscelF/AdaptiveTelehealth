** Settings ***
Resource	${EXECDIR}../../ATH-Resources/Flows/SchedulingPage_res.txt
Suite Teardown	Close All Browsers

***Test Cases***
SchedulingTherapist_001
# #wdigets display

	Run Keyword if	"${TestEnv}" == "Secure"	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}	ELSE	ath_Logon	${BROWSER}	${URL}	${AutoTherapist1}	${TestEnv}
# 	Perform Login Checks
# 	Select Scheduling Menu
# 	ath click button	Calendar Preferences
# 	Scheduling.Preferences.Select Exceptions Tab
# 	Scheduling.Preferences.Verify Exceptions Tab Displayed

# #exceptions
# 	${isFrom}	Generate Date and Time Today	%Y-%m-%d

# 	${FromDate}	Add/Subtract Days from Input Date 	${isFrom}	ADD	1	%Y-%m-%d
# 	${FromFormat}	Add/Subtract Days from Input Date 	${isFrom}	ADD	1	%m-%d-%Y
# 	${ToDate}	Add/Subtract Days from Input Date 	${isFrom}	ADD	5	%Y-%m-%d
# 	${ToFormat}	Add/Subtract Days from Input Date 	${isFrom}	ADD	5	%m-%d-%Y

# 	${year}	${month}	${dateFrom}	Split String	${FromDate}	-
# 	${iszero}	Fetch From Left 	${dateFrom}	0
# 	${stringFrom}	Run Keyword if	"${iszero}" == "${EMPTY}"	Replace String	${dateFrom}	0	${EMPTY}	ELSE	Set Variable	${dateFrom}

# 	${year}	${month}	${dateFrom}	Split String	${ToDate}	-
# 	${iszero}	Fetch From Left 	${dateFrom}	0
# 	${stringTo}	Run Keyword if	"${iszero}" == "${EMPTY}"	Replace String	${dateFrom}	0	${EMPTY}	ELSE	Set Variable	${dateFrom}

# 	Scheduling.Preferences.Exceptions.Select DisplayFrom Date	${stringFrom}
# 	Scheduling.Preferences.Exceptions.Select DisplayTo Date	${stringTo}

# 	Scheduling.Preferences.Exceptions.Click Select Button
# 	Scheduling.Preferences.Exceptions.Verify Selected Date Applied	${FromFormat}
# 	Scheduling.Preferences.Exceptions.Verify Selected Date Applied	${ToFormat}