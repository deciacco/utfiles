Lparameters ppath

Declare Integer GetShortPathName In Kernel32;
		String @lpszLongPath,;
		String @lpszShortPath,;
		Integer cchBuffer

lcretval = Space(255)
lnlen = Len(lcretval)

lclongpathname = ppath

lnretval = getshortpathname(@lclongpathname, @lcretval, lnlen)

Clear Dlls "GetShortPathName"

Return Left(lcretval, lnretval)