*** Settings ***
Resource	C:/Ath.Git/AdaptiveTelehealth/ATH-Resources/Flows/SchedulingPage_res.txt
Suite Teardown	Close All Browsers


***Variable***


***Test Cases***
SchedulingTherapist_001
#wdigets display

	ath_Logon	${BROWSER}	${URL}	${AutoTherapist}	${TestEnv}
	Perform Login Checks
	Select Scheduling Menu
	ath check button existence	Hide Cancelled Appointments
	ath check button existence	Calendar Preferences

# SchedulingTherapist_002
# #Schedule Preferences page
	ath click button	Calendar Preferences
	Scheduling.Preferences.Verify Widget display
	Check Label Existence	Time Blocks,Days/Hours,Exceptions,Confirmations,Cancellation Messages,Time Zone

SchedulingClient_003
#Time Blocks tab
	Scheduling.Preferences.Select Time Blocks Tab
	Scheduling.Preferences.Verify Time Blocks Tab Displayed

# SchedulingClient_004
# #Verify time blocks field
# 	Scheduling.Preferences.TimeBlocks.Click Add New Time Block Button
# 	Scheduling.Preferences.TimeBlocks.Add new Time Block value	30
# 	Scheduling.Preferences.TimeBlocks.Apply Time Block
# 	Fail 	no validation


SchedulingClient_005
#remove time block
	Scheduling.Preferences.TimeBlocks.Remove Time Block
	Sleep 	3.0
	ath check button existence	Change	1	false
	ath check button existence	Apply
	Capture Page Screenshot

SchedulingClient_006
#dupkicate time block
	Scheduling.Preferences.Select Time Blocks Tab
	Scheduling.Preferences.TimeBlocks.Add new Time Block value	65
	Scheduling.Preferences.TimeBlocks.Click Add New Time Block Button
	Scheduling.Preferences.TimeBlocks.Add new Time Block value	65	2
	Scheduling.Preferences.TimeBlocks.Apply Time Block
	Scheduling.Preferences.TimeBlocks.Verify Duplicate Time Block not allowed
	Capture Page Screenshot
	Scheduling.Preferences.TimeBlocks.Close Duplicate Popup
	Capture Page Screenshot
	Scheduling.Preferences.TimeBlocks.Remove Time Block
	Scheduling.Preferences.TimeBlocks.Remove Time Block

SchedulingClient_007
#apply time block
	Scheduling.Preferences.TimeBlocks.Add new Time Block value	10
	Scheduling.Preferences.TimeBlocks.Add Field 1	Auto Test 1
	Scheduling.Preferences.TimeBlocks.Add Field 2	Auto Test 2
	Scheduling.Preferences.TimeBlocks.Click Add New Time Block Button
	Scheduling.Preferences.TimeBlocks.Add new Time Block value	20	2
	Scheduling.Preferences.TimeBlocks.Apply Time Block 	2
	RUn Keyword and Ignore Error	Scheduling.Preferences.TimeBlocks.Close Duplicate Popup
	Run Keyword and Ignore Error	Scheduling.Preferences.TimeBlocks.Apply Time Block
	RUn Keyword and Ignore Error	Scheduling.Preferences.TimeBlocks.Close Duplicate Popup
	Scheduling. Expand Schedule Menu Settings
	ath click link 	Schedule preferences
	${status}	RUn Keyword and Return Status	ath check button existence	Change	1
	Set Suite Variable 	${status}

SchedulingClient_008
#change time block
	# Scheduling. Expand Schedule Menu Settings
	# ath click link 	Schedule preferencesvv
	Run Keyword If	${status}	Scheduling.Preferences.TimeBlocks.Add new Time Block value	15
	Run Keyword If	${status}	Scheduling.Preferences.TimeBlocks.Change Time Block
	RUn Keyword and Ignore Error	Scheduling.Preferences.TimeBlocks.Close Duplicate Popup
	Capture Page Screenshot
	Scheduling.Preferences.TimeBlocks.Click Add New Time Block Button
	Scheduling.Preferences.TimeBlocks.Add new Time Block value	60	2
	Scheduling.Preferences.TimeBlocks.Apply Time Block
	Capture Page Screenshot

SchedulingClient_010
#days/hours tab
	Scheduling.Preferences.Select Days/Hours Tab
	Scheduling.Preferences.Verify Days/Hours Tab Displayed

SchedulingClient_011
#days/hours tab
	Scheduling.Preferences.Days/Hours.Click Save Button
	Reload Page

SchedulingClient_012
#days/hours tab_new office hour popup
	Capture Page Screenshot
	Scheduling.Preferences.Select Days/Hours Tab
	${curCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Scheduling.Preferences.Days/Hours.Click New Office Hour Button
	Scheduling.Preferences.Days/Hours.Verify New Office Hour Popup is Displayed
	Set Suite variable	${curCount}

# SchedulingClient_013
# #days/hours tab_new office hour add without day
# 	Scheduling.Preferences.Days/Hours.Click Add button
# 	Sleep 	1.0
# 	${newCount}	Scheduling.Preferences.Days/Hours.Get Table Count
# 	Should Not be equal 	${newCount}	${curCount}
# 	Fail	No validation
SchedulingClient_014
#days/hours tab_new office hour add with day and no time
	${mycurCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Scheduling.Preferences.Days/Hours.Click New Office Hour Button
	Scheduling.Preferences.Days/Hours.Select Day from dropdown	Mon
	Scheduling.Preferences.Days/Hours.Click Add button
	${newCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Run Keyword and Continue on Failure	Should Not be equal 	${newCount}	${mycurCount}


SchedulingClient_015
#days/hours tab_new office hour add with day and no time
	${mycurCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Scheduling.Preferences.Days/Hours.Click New Office Hour Button
	Sleep 	2.0
	Scheduling.Preferences.Days/Hours.Select Day from dropdown	Mon
	Scheduling.Preferences.Days/Hours.Click Set Start Time
	Scheduling.Preferences.Days/Hours.Select Time hours from dropdown 	5
	Scheduling.Preferences.Days/Hours.Select Time minutes from dropdown 	30
	Scheduling.Preferences.Days/Hours.SetTimePopup.Click Set button
	Scheduling.Preferences.Days/Hours.Click Set End Time
	Scheduling.Preferences.Days/Hours.Select Time hours from dropdown 	6
	Scheduling.Preferences.Days/Hours.Select Time minutes from dropdown 	30
	Scheduling.Preferences.Days/Hours.SetTimePopup.Click Set button
	Scheduling.Preferences.Days/Hours.Click Add button
	${newCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Run Keyword and Continue on Failure	Should Not be equal 	${newCount}	${mycurCount}
	Set Suite Variable	${newCount}

SchedulingClient_016
#select time per appointment/meeting break and type
	Scheduling.Preferences.Days/Hours.Select Time per Appointment for newly added entry 	${newCount} 	No Appointment
	Scheduling.Preferences.Days/Hours.Select Meeting Type for newly added entry 	${newCount} 	Online
	Scheduling.Preferences.Days/Hours.Select Meeting Break for newly added entry	${newCount} 	5 minutes

SchedulingClient_019
#save office hours
	${mycurCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Scheduling.Preferences.Days/Hours.Click Save Button
	Scheduling.Preferences.Days/Hours.Save.Click Just Save Office Hours Button
	Scheduling.Preferences.Confirm Office Hours Saved successfully
	${newCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Run Keyword and Continue on Failure	Should Be equal	${newCount}	${mycurCount}

SchedulingClient_017
#delete last entry
	${mycurCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Scheduling.Preferences.Days/Hours.Click Delete for newly added entry	${mycurCount}
	${delCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Run Keyword and Continue On Failure	Should Not be equal	${mycurCount}	${delCount}

SchedulingClient_018
#delete first entry
	${mycurCount}	Scheduling.Preferences.Days/Hours.Get Table Count
	Scheduling.Preferences.Days/Hours.Click Delete for first entry
	${firstCnt}	Scheduling.Preferences.Days/Hours.Get Table Count
	Run Keyword and Continue On Failure	Should Not be equal	${mycurCount}	${firstCnt}

# SchedulingClient_020
# #save timeframe
# 	Scheduling.Preferences.Days/Hours.Timeframe.Click Apply Button
# 	Scheduling.Preferences.Confirm Apply Changes Saved successfully
# 	Fail 	no validation

# SchedulingClient_021
# #save timeframe
# 	Scheduling.Preferences.Days/Hours.Click New Office Hour Button
# 	Scheduling.Preferences.Days/Hours.Select Day from dropdown	Mon
# 	Scheduling.Preferences.Days/Hours.Click Set Start Time
# 	Scheduling.Preferences.Days/Hours.Select Time hours from dropdown 	5
# 	Scheduling.Preferences.Days/Hours.Select Time minutes from dropdown 	30
# 	Scheduling.Preferences.Days/Hours.SetTimePopup.Click Set button
# 	Scheduling.Preferences.Days/Hours.Click Set End Time
# 	Scheduling.Preferences.Days/Hours.Select Time hours from dropdown 	6
# 	Scheduling.Preferences.Days/Hours.Select Time minutes from dropdown 	30
# 	Scheduling.Preferences.Days/Hours.SetTimePopup.Click Set button
# 	Scheduling.Preferences.Days/Hours.Click Add button
# 	${isFrom}	Generate Date and Time Today 	%Y-%m-%d
# 	${year}	${month}	${day}	Split String	${isFrom}	-

# 	${DateAdd}	Add/Subtract Days from Input Date 	${isFrom}	ADD	5 	%d-%B-%Y
# 	${year}	${month}	${AddDay}	Split String	${DateAdd}	-
# 	Scheduling.Preferences.Days/Hours.Timeframe.Select Date From	${month}	${day}
# 	Scheduling.Preferences.Days/Hours.Timeframe.Select Date To	${month}	${AddDay}
# 	Scheduling.Preferences.Days/Hours.Timeframe.Click Apply Button
# 	Scheduling.Preferences.Confirm Apply Changes Saved successfully
# 	Fail 	no validation

SchedulingClient_023
#exceptions
	Scheduling.Preferences.Select Exceptions Tab
	Scheduling.Preferences.Verify Exceptions Tab Displayed

SchedulingClient_024
#exceptions
	${isFrom}	Generate Date and Time Today	%Y-%m-%d
	${FromDate}	Add/Subtract Days from Input Date 	${isFrom}	ADD	1	%Y-%m-%d
	${FromFormat}	Add/Subtract Days from Input Date 	${isFrom}	ADD	1	%m-%d-%Y
	${ToDate}	Add/Subtract Days from Input Date 	${isFrom}	ADD	5	%Y-%m-%d
	${ToFormat}	Add/Subtract Days from Input Date 	${isFrom}	ADD	5	%m-%d-%Y

	${year}	${month}	${dateFrom}	Split String	${FromDate}	-
	${iszero}	Fetch From Left 	${dateFrom}	0
	${stringFrom}	Run Keyword if	"${iszero}" == "${EMPTY}"	Replace String	${dateFrom}	0	${EMPTY}	ELSE	Set Variable	${dateFrom}

	${year}	${month}	${dateFrom}	Split String	${ToDate}	-
	${iszero}	Fetch From Left 	${dateFrom}	0
	${stringTo}	Run Keyword if	"${iszero}" == "${EMPTY}"	Replace String	${dateFrom}	0	${EMPTY}	ELSE	Set Variable	${dateFrom}

	Scheduling.Preferences.Exceptions.Select DisplayFrom Date	${stringFrom}
	Scheduling.Preferences.Exceptions.Select DisplayTo Date	${stringTo}

	Scheduling.Preferences.Exceptions.Click Select Button
	Scheduling.Preferences.Exceptions.Verify Selected Date Applied	${FromFormat}
	Scheduling.Preferences.Exceptions.Verify Selected Date Applied	${ToFormat}
	Logout from Application