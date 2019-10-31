If _vfp.StartMode != 0
	= myinstance("utfile")
Endif

On Error Do errorhandler With Error( ), Message( ), Message(1), Program( ), Lineno(1)

Do setcommands
Do setuplibs
Do setupscreen
Do setupmenu
Do setupdatabase

Do Form utfile
Do settopmost With _Screen.ActiveForm.HWnd

On Shutdown Clear Events

Read Events

Do propershutdown

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

Procedure setcommands
	Local lcpath
	
	Set Bell On 
	Set Century On  
	Set Deleted On 
	Set Escape Off 
	Set Exclusive Off 
	Set Hours To 12 
	Set Multilocks On 
	Set Refresh To 5,3 
	Set Reprocess To 5 Seconds
	Set Seconds Off
	Set Talk Off
	
	If _vfp.StartMode = 0  && running inside the Visual FoxPro IDE
		lcpath = Left(Sys(16,0), Rat("\", Sys(16,0), 2))
		Set Default To (lcpath) && Specifies the default drive and directory
		Set Path To (lcpath + ";Data\;Forms\;Help\;Images\;Libs\;Menus\;Progs\;Reports\") && Specifies a path for file searches
	Else
		lcpath = Justpath(Sys(16,0))
		Set Default To (lcpath) && Specifies the default drive and directory
		Set Path To (lcpath + ";Data\;Images\") && Specifies a path for file searches
	Endif
Endproc

Procedure setupscreen
	With _Screen
		.AddProperty("ClientPath", Addbs(Sys(5) + Sys(2003)))
		.AddProperty("DataPath", Addbs(Sys(5) + Sys(2003)) + "Data\")
		.AddProperty("ClientExe", _Screen.clientpath + Justfname(Sys(16)))
	Endwith
Endproc

Procedure setupmenu
Endproc

Procedure setupdatabase
Endproc

Procedure setuplibs
	Set Classlib To Process Additive
	Set Library To vfp2c32.fll Additive
	If !InitVFP2C32(0xFFFFFFFF)
		Local laError[1], lnCount, xj, lcError
		lnCount = AERROREX('laError')
		lcError = 'VFP2C32 Library initialization failed:' + Chr(13)
		For xj = 1 To lnCount
			lcError = lcError + ;
				'Error No : ' + Transform(laError[1]) + Chr(13) + ;
				'Function : ' + laError[2] + Chr(13) + ;
				'Message : "' + laError[3] + '"'
		Endfor
	Endif
Endproc

Procedure propershutdown
	On Shutdown

	Clear Events
	Release All

	If _vfp.StartMode = 0 && running inside the Visual FoxPro IDE
		Removeproperty(_Screen, "clientpath")
		Removeproperty(_Screen, "datapath")
		Removeproperty(_Screen, "clientexe")
		On Error
	Endif

	Close Databases All
	Clear All

	If _vfp.StartMode = 0
		Cancel
	Else
		Quit
	Endif
Endproc

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

Procedure ddezoom
	Parameter  ichannel,saction,sitem,sdata,sformat,istatus
	Zoom Window Screen Norm
	Return
Endproc
