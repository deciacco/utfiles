If _vfp.StartMode != 0
	= myinstance("utfile")
Endif

On Error Do errorhandler With Error( ), Message( ), Message(1), Program( ), Lineno(1)

*!* Set up the initial environment
Do setcommands
Do setuplibs
Do setupscreen
Do setupmenu
Do setupdatabase

*!* Bring up the application form
Do Form utfile
Do settopmost With _screen.ActiveForm.HWnd

*!* Setup Quit Routine
On Shutdown Clear Events && if user quits app then run ProperShutdown procedure

*!* Start event processing loop
Read Events

Do propershutdown

*=========================================
*->
*=========================================
Procedure errorhandler
	Parameter tnerror, tcmessage, tcmessage1, tcprogram, tnlineno
	Local lcerrormessage
	lcerrormessage = "Error number: " + Transform(tnerror) + Chr(13) ;
		+ "Error message: " + tcmessage + Chr(13) ;
		+ "Line of code: " + tcmessage1 + Chr(13);
		+ "Program: " + tcprogram + Chr(13);
		+ "Line number: " + Transform(tnlineno)
	Messagebox(lcerrormessage, 16, "A Problem Has Been Encountered")
	Clear Events
Endproc

*=========================================
*->
*=========================================
Procedure setcommands
	Local lcpath
	Set Bell On && Turns the computer bell on
	Set Century On && Specifies a four-digit year in a format that includes 10 characters
	Set Console Off && Disables output to the main Visual FoxPro window or to the active user-defined window from within programs
	Set Deleted On && Specifies that commands that operate on records, including records in related tables, using a scope ignore records that are marked for deletion
	Set Escape Off && Pressing the ESC key interrupts program and command execution
	Set Exclusive Off && Specifies that tables are opened for shared use on a network
	Set Hours To 12 && Sets the system clock to a 12-hour time format
	Set Multilocks On && Required for row or table buffering and allows multiple records to be locked using LOCK( ) or RLOCK( )
	Set Refresh To 5,3 && Frequency (in seconds) to update a browse window or memo editing window, or to refresh local memory buffers - 1st parameter is for local data, 2nd parameter is for network data
	*!*    Set REPORTBEHAVIOR 90 && Using the new reporting engine features
	*!*	   _REPORTOUTPUT = "ReportOutput.app" && Designate application to use for report output
	*!*	   _REPORTPREVIEW = "ReportPreview.app" && Designate application to use for report previewing
	Set Reprocess To 5 Seconds && How long will Visual FoxPro attempt to lock a file or record after an unsuccessful locking attempt
	Set Seconds Off && Specifies that seconds are not displayed in the time portion of a DateTime value
	Set Status Bar On && Displays the graphical status bar at the bottom of the _screen
	Set Sysmenu Off && Turn off the default system menu that Visual FoxPro uses
	Set Talk Off && Prevents talk from being sent to the main Visual FoxPro window, the system message window, the graphical status bar, or a user-defined window
	SYS(3050, 1, VAL(SYS (3050, 1, 0)) / 3) && Memory management
	clearkeys()
	If _vfp.StartMode = 0  && running inside the Visual FoxPro IDE
		lcpath = Left(Sys(16,0), Rat("\", Sys(16,0), 2))
		Set Default To (lcpath) && Specifies the default drive and directory
		Set Path To (lcpath + ";Data\;Forms\;Help\;Images\;Libs\;Menus\;Progs\;Reports\") && Specifies a path for file searches
	Else
		lcpath = Justpath(Sys(16,0))
		Set Default To (lcpath) && Specifies the default drive and directory
		Set Path To (lcpath + ";Data\;Images\") && Specifies a path for file searches
	ENDIF
Endproc

*=========================================
*->
*=========================================
Procedure setupscreen
	With _Screen
		If _vfp.StartMode != 0
			If Wexist("Standard")
				Hide Window "Standard"
			Endif
			.AddProperty("oldScreenCaption", .Caption)
			.LockScreen=.T.
			.WindowState=0
			.BackColor=Rgb(128,128,128)
			.Movable=.T.
			.Height=500
			.Width=800
			.AutoCenter = .T.
			.LockScreen=.F.
			.Caption = "UT File Copy Utility"
		Endif

		*!* Personal preference to have the clientpath and the datapath available as _screen properties
		.AddProperty("ClientPath", Addbs(Sys(5) + Sys(2003)))
		*!* If data is not local, path would be pulled from an INI or Registry
		.AddProperty("DataPath", Addbs(Sys(5) + Sys(2003)) + "Data\")
		.AddProperty("ClientExe", _screen.clientpath + Justfname(Sys(16)))
	Endwith
Endproc

*=========================================
*->
*=========================================
Procedure setupmenu
	*!*	 Bring up our user-defined menu
	Do mainmenu.mpr
Endproc

*=========================================
*->
*=========================================
Procedure setupdatabase
	*!* Open and set the database
	*!*	   OPEN DATABASE (_SCREEN.datapath + "Northwind.dbc")
	*!*	   SET DATABASE TO NORTHWIND
Endproc

*=========================================
*->
*=========================================
Procedure setuplibs
	Set Classlib To ecprogbar Additive
	Set Classlib To process Additive
	Set Library To vfp.fll Additive 
	Do winapi
Endproc

*=========================================
*->
*=========================================
Procedure propershutdown
	Local loform

	On Shutdown && Must shut off the quit routine otherwise it will fire recursively
	*!* Code to clean up would go here such as releasing resources and closing databases
	Clear Events
	Release All
	If _vfp.StartMode = 0 && running inside the Visual FoxPro IDE
		Removeproperty(_Screen, "clientpath")
		Removeproperty(_Screen, "datapath")
		Removeproperty(_Screen, "clientexe")
		
		Set Sysmenu To Default
		setdevkeys()
		*!*SHOW WINDOW "Standard"
		On Error && Restore default Error Handling
	Endif

	*!* Close any open forms
	loform = .Null. && Not necessary, but force of habit
	For Each loform In _Screen.Forms
		loform.Release()
	Next

	Close Databases All && closes any open tables and database
	Clear All && Clear all remaingin items from memory

	If _vfp.StartMode = 0
		*!*	      _SCREEN.CAPTION = _SCREEN.oldScreenCaption && Restore _Screen's Caption
		*!*	      REMOVEPROPERTY(_SCREEN, "oldScreenCaption")

		Cancel
	Else
		Quit
	Endif
Endproc

*=========================================
*->
*=========================================
Procedure myinstance
	Parameters myapp
	=Ddesetoption("SAFETY",.F.)
	ichannel = Ddeinitiate(myapp,"ZOOM")
	If ichannel =>0
		=Ddeterminate(ichannel)
		Quit
	Endif
	=Ddesetservice(myapp,"define")
	=Ddesetservice(myapp,"execute")
	=Ddesettopic(myapp,"","ddezoom")
	Return
Endproc

*=========================================
*->
*=========================================
Procedure ddezoom
	Parameter  ichannel,saction,sitem,sdata,sformat,istatus
	Zoom Window Screen Norm
	Return
Endproc

*=========================================
*->
*=========================================
Procedure setdevkeys
	If File('devproc.prg') Then
		Set Procedure To devproc.prg Additive

		On Key Label ctrl+f5 documentationheader()
		On Key Label ctrl+f6 documentprogramstep()
		On Key Label ctrl+f7 documentmodification()
	Endif
Endproc
*=========================================
*->
*=========================================
Procedure clearkeys()
	Push Key Clear
Endproc
