Lparameters pcdir, pocol, pcparent
Local lnptr, lnfilecount, lafilelist, lcdir, lcfile, lncnt

If pbcanceled then

	Chdir "&pcDir"
	*--- ? 'Dir -> ' + FULLPATH(CURDIR())

	Dimension lafilelist[1]
	lncnt = 0
	*--- Read the chosen directory.
	lnfilecount = Adir(lafilelist, '*.*', 'D')
	For lnptr = 1 To lnfilecount
		lncnt = lncnt + 1
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
		
		If lncnt % 10 = 0 then
			Doevents
		endif

	Endfor

	*--- Move back to parent directory.
	Chdir ..
Endif

