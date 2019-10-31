Lparameters pcsourcedir, pcgamedir, pbow, pbprev

_Screen.MousePointer = 11

Local locoldirfiles As Collection
Local locolfilemappings As Collection
Local lotherm As 'mytherm' Of z:\Projects\utfiles\libs\appobjs.vcx

lotherm = Createobject("mytherm", "Copying Files")
locolfilemappings = Createobject("Collection")
locoldirfiles = Createobject("Collection")

lotherm.AutoCenter = .T.
lotherm.Show()

lotherm.Update(0 * 100,"Loading mappings...")
Select filemappings

Goto Top
Scan
	locolfilemappings.Add(filemappings.dir, filemappings.ext)
Endscan

lotherm.Update(0 * 100,"Scanning source directory...")
lcolddef = Set('directory')


recurse(pcsourcedir, @locoldirfiles, "")

Set Default To (lcolddef)

_Cliptext = ""

lnfoundcnt = 0
lclog = ""


lotherm.Update(0 * 100,"Starting copy...")
For i = 1 To locoldirfiles.Count
	lcfile = locoldirfiles.Item(i)
	lcext = Justext(lcfile)
	lotherm.Update(i/locoldirfiles.Count * 100,lcfile)
	Try
		lcfound = locolfilemappings.Item(lcext)
		If !Isnull(lcfound) Then
			lclookfor = Addbs(pcgamedir) + Addbs(lcfound) + Justfname(lcfile)
			lcexists = Cast(File(lclookfor,1) As c)
			If pbprev
				lclog = lclog + "Found       : " + Lower(lcfile) + Chr(13)
				lclog = lclog + "Looking for : " + Lower(lclookfor) + Chr(13)
				lclog = lclog + "Search      : " + lcexists + Chr(13)+ Chr(13)
			Else
				If (lcexists = "T" And pbow = .T.) Or lcexists = "F" Then
					Copy File (lcfile) To (lclookfor)
				Endif
			Endif
		Endif
	Catch To oerr
		_Cliptext = _Cliptext + oerr.Message + Chr(13)
	Endtry
Endfor
lotherm.Complete()
Release lotherm
Release locolfilemappings
Release locoldirfiles

If pbprev Then
	Do Form copypreview With lclog
Endif
_Screen.MousePointer = 0

Return lnfoundcnt

**************************************************************************************
Function recurse
	Lparameters pcdir, pocol, pcparent
	Local lnptr, lnfilecount, lafilelist, lcdir, lcfile

	Chdir "&pcDir"
	*--- ? 'Dir -> ' + FULLPATH(CURDIR())

	Dimension lafilelist[1]

	*--- Read the chosen directory.
	lnfilecount = Adir(lafilelist, '*.*', 'D')
	For lnptr = 1 To lnfilecount

		If 'D' $ lafilelist[lnPtr, 5]

			*--- Get directory name.
			lcdir = lafilelist[lnPtr, 1]

			*--- Ignore current and parent directory pointers.
			If lcdir != '.' And lcdir != '..'
				*--- Call this routine again.
				recurse(lcdir, @pocol, Addbs(pcparent+pcdir))
			Endif
		Else

			*--- Get the file name.
			lcfile = Lower(lafilelist[lnPtr, 1])

			*--- Use filename for key in collection so that duplicate entry will not occur
			Try
				pocol.Add(pcparent + Addbs(pcdir) + lcfile, lcfile)
			Catch To oerr
			Endtry
		Endif

	Endfor

	*--- Move back to parent directory.
	Chdir ..
Endfunc

**************************************************************************************
Function copyfile
	Lparameters pcfilepath

Endfunc

**************************************************************************************
Function fileext
	Lparameters pcfile

	Return Substr(pcfile,At(".",pcfile, Occurs(".",pcfile))+1,3)

Endfunc
