Lparameters pExisting, pNewFile

Declare integer CopyFile in "kernel32";
	string @lpExistingFileName,;
	string @lpNewFileName,;
	integer bFailIfExists

copyfile(pExisting, pNewFile, 0)

Clear Dlls "copyfile"

return