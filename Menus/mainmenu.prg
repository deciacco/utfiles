Lparameters oFormRef, getMenuName, lUniquePopups, parm4, parm5, parm6, parm7, parm8, parm9

Local cMenuName, nTotPops, a_menupops, cTypeParm2, cSaveFormName
If Type("m.oFormRef") # "O" Or ;
		LOWER(m.oFormRef.BaseClass) # 'form' Or ;
		m.oFormRef.ShowWindow # 2
	Messagebox([This menu can only be called from a Top-Level form. Ensure that your form's ShowWindow property is set to 2. Read the header section of the menu's MPR file for more details.])
	Return
Endif
m.cTypeParm2 = Type("m.getMenuName")
m.cMenuName = Sys(2015)
m.cSaveFormName = m.oFormRef.Name
If m.cTypeParm2 = "C" Or (m.cTypeParm2 = "L" And m.getMenuName)
	m.oFormRef.Name = m.cMenuName
Endif
If m.cTypeParm2 = "C" And !Empty(m.getMenuName)
	m.cMenuName = m.getMenuName
Endif
Dimension a_menupops[3]
If Type("m.lUniquePopups")="L" And m.lUniquePopups
	For nTotPops = 1 To Alen(a_menupops)
		a_menupops[m.nTotPops]= Sys(2015)
	Endfor
Else
	a_menupops[1]="file"
	a_menupops[2]="utinstalld"
	a_menupops[3]="about"
Endif

Define Menu (m.cMenuName) In (m.oFormRef.Name) Bar

Define Pad _1yg0rpmir Of (m.cMenuName) Prompt "\<File" Color Scheme 3 ;
	KEY Alt+F, ""
Define Pad _1yg0rpmis Of (m.cMenuName) Prompt "\<Ut Install Dir" Color Scheme 3 ;
	KEY Alt+U, ""
Define Pad _1yg0rpmit Of (m.cMenuName) Prompt "\<About" Color Scheme 3 ;
	KEY Alt+A, ""
On Pad _1yg0rpmir Of (m.cMenuName) Activate Popup (a_menupops[1])
On Pad _1yg0rpmis Of (m.cMenuName) Activate Popup (a_menupops[2])
On Pad _1yg0rpmit Of (m.cMenuName) Activate Popup (a_menupops[3])

Define Popup (a_menupops[1]) Margin Relative Shadow Color Scheme 4
Define Bar 1 Of (a_menupops[1]) Prompt "\-"
Define Bar 2 Of (a_menupops[1]) Prompt "E\<xit"
On Selection Bar 2 Of (a_menupops[1]) ;
	DO _1yg0rpmiu

Define Popup (a_menupops[2]) Margin Relative Shadow Color Scheme 4
Define Bar 1 Of (a_menupops[2]) Prompt "\<Create Test Dir"
On Selection Bar 1 Of (a_menupops[2]) ;
	DO _1yg0rpmiw

Define Popup (a_menupops[3]) Margin Relative Shadow Color Scheme 4
Define Bar 1 Of (a_menupops[3]) Prompt "Help"
Define Bar 2 Of (a_menupops[3]) Prompt "License"
Define Bar 3 Of (a_menupops[3]) Prompt "Readme"
On Selection Bar 1 Of (a_menupops[3]) ;
	DO _1yg0rpmiz
On Selection Bar 2 Of (a_menupops[3]) ;
	DO _1yg0rpmj3
On Selection Bar 3 Of (a_menupops[3]) ;
	DO _1yg0rpmj6

Activate Menu (m.cMenuName) Nowait

If m.cTypeParm2 = "C"
	m.getMenuName = m.cMenuName
	m.oFormRef.Name = m.cSaveFormName
Endif

Return

**************************************************************************************
Procedure _1yg0rpmiu
	local oFormRef
	oFormRef = _screen.ActiveForm
	
	oFormRef.Release()
Endproc

**************************************************************************************
Procedure _1yg0rpmiw
	local oFormRef
	oFormRef = _screen.ActiveForm
	
	Local cfilename As String
	Local cdesktopfilename As String
	Local api_apprun As api_apprun Of z:\Projects\utfiles\libs\Process.vcx
	Local lstatus
	Local lcErrorMsg, lcDeskPath

	SHSPECIALFOLDER(0,@lcDeskPath)

	cfilename = Set("default")+Curdir()+"testgame.exe"
	cdesktopfilename = shortpath(Addbs(lcDeskPath))+"testgame.exe"

	Try
		Set Safety Off
		Copy File (cfilename) To (cdesktopfilename)

		api_apprun = Createobject("Api_apprun")
		api_apprun.iccommandline = cdesktopfilename
		api_apprun.iclaunchdir = Justpath(cdesktopfilename)
		api_apprun.icwindowmode = "HID"
		lstatus = api_apprun.launchappandwait()

		If fileexists(cdesktopfilename) Then
			Delete File (cdesktopfilename)
		Endif

		Set Safety On
	Catch To oerr
		Messagebox(oerr.Message, 48, "Error")
	Finally
		If !lstatus Then
			lcErrorMsg = "There was an error while attempting to create the test game dir." + Chr(13) + ;
				"Please create it manually by using the testgame.exe located in " + Chr(13) + ;
				"the UTFile install directory:" + Chr(13) + Chr(13) + ;
				"'c:\program files\utfile\testgame.exe'" + Chr(13) + Chr(13) +;
				"(You may want to copy testgame.exe to your desktop first.)"
			Messagebox(lcErrorMsg,48, "Error")
		Else
			oFormRef.txtutDir.Value = Lower(getdeskpath()+Addbs("testgame"))
		Endif
		Release api_apprun
		oFormRef.EnableCopy()
	Endtry
Endproc

**************************************************************************************
Procedure _1yg0rpmiz

	Declare Integer ShellExecute In shell32.Dll ;
		integer hndWin, ;
		string cAction, ;
		string cFileName, ;
		string cParams, ;
		string cDir, ;
		integer nShowWin

	Local cfilename As String
	Local nReturnVal As Number

	cfilename = Set("default")+Curdir()+"help.chm"
	cAction = "open"
	nReturnVal = ShellExecute(0,cAction,cfilename,"","",1)

	If nReturnVal = 2 Then
		Messagebox("Help file not found!",48,"Error")
	Endif

	Clear Dlls ShellExecute
Endproc

**************************************************************************************
Procedure _1yg0rpmj3
	Do Form license
Endproc

**************************************************************************************
Procedure _1yg0rpmj6
	Do Form ReadMe
Endproc

