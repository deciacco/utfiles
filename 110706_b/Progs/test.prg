*!*	lcolddefault = SET('directory')

*!*	SET DEFAULT TO c:\ut2004

*!*	CLEAR
*!*	lncnt = ADIR(laFiles, "", "D", 0)

*!*	FOR i = 1 TO lncnt 
*!*		? laFiles[i,1]
*!*	ENDFOR

*!*	SET DEFAULT TO (lcolddefault)
*************************
*!*	SET DEFAULT TO Z:\Projects\UtFiles\Data\

*!*	USE filemappings

*!*	LOCAL loCol as Collection
*!*	loCol = CREATEOBJECT("Collection")

*!*	GOTO top
*!*	SCAN 
*!*		loCol.Add(filemappings.dir, filemappings.ext)
*!*	ENDSCAN 

*!*	CLEAR

*!*	FOR i = 1 TO loCol.Count
*!*		?  loCol(loCol.GetKey(i))
*!*	ENDFOR 

*!*	RELEASE loCol
*!*	CLOSE DATABASES
********************************
LOCAL loCol as Collection
loCol = CREATEOBJECT("Collection")
recurse("\\Orion\Lanparty\Ut2004\", @loCol)

clear

FOR i = 1 TO loCol.Count
	?  loCol.Item(i)
ENDFOR

RELEASE loCol
RELEASE ALL

**************************
FUNCTION Recurse
**************************
LPARAMETERS pcDir, poCol
LOCAL lnPtr, lnFileCount, laFileList, lcDir, lcFile

CHDIR "&pcDir"
? 'Dir -> ' + FULLPATH(CURDIR())

DIMENSION laFileList[1]

*--- Read the chosen directory.
lnFileCount = ADIR(laFileList, '*.*', 'D')
FOR lnPtr = 1 TO lnFileCount

  IF 'D' $ laFileList[lnPtr, 5]

    *--- Get directory name.
    lcDir = laFileList[lnPtr, 1]

    *--- Ignore current and parent directory pointers.
    IF lcDir != '.' AND lcDir != '..'
      *--- Call this routine again.
      Recurse(lcDir, @poCol)
    ENDIF

  ELSE

    *--- Get the file name.
    lcFile = LOWER(laFileList[lnPtr, 1])
*!*	    IF [Condition is True]
*!*	      Process File (lcFile) here...
*!*	    ENDIF
	poCol.Add(lcFile)
  ENDIF

ENDFOR

*--- Move back to parent directory.
CHDIR ..
ENDFUNC 


