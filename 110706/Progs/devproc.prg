*-DevProc.prg
#DEFINE DeveloperName  "E.Cilento"
FUNCTION DocumentationHeader()
    KEYBOARD ''CLEAR
    KEYBOARD '*============================================================================='+CHR(10)
    KEYBOARD '*| Purpose......'+ CHR(10)
    KEYBOARD '*@ Author.......'+ DeveloperName +CHR(10)
    KEYBOARD '*| Created......'+ MDY(DATE())+CHR(10)
    KEYBOARD '*| About........'+ CHR(10)
    KEYBOARD '*| Mod List.....'+ CHR(10)
    KEYBOARD '*============================================================================='+CHR(10)
    KEYBOARD '{UPARROW}{UPARROW}{UPARROW}{UPARROW}{UPARROW}{END}'
    KEYBOARD '{UPARROW}'
ENDFUNC

FUNCTION DocumentModification()
    KEYBOARD ''CLEAR
    KEYBOARD '*// Modified ' + MDY(DATE())+' By '+ DeveloperName +CHR(10)
ENDFUNC

FUNCTION DocumentProgramStep()
    KEYBOARD '' CLEAR
    KEYBOARD '*========================================='+CHR(10)
    KEYBOARD '*->'+CHR(10)
    KEYBOARD '*========================================='
    KEYBOARD '{UPARROW}'
ENDFUNC

FUNCTION ExtendLine()
    KEYBOARD ''CLEAR
    KEYBOARD '{ENTER}'
    KEYBOARD '*)  '
ENDFUNC

FUNCTION AddDisplayClasses
    LOCAL lcTableName, lnFields, lnI, lcFieldName, lcDataType
    LOCAL lcClassName, lcClassLib

    lcTableName = ALIAS()
    IF EMPTY(lcTableName)
        =MESSAGEBOX("A table must be selected in the current work area.",16,"Error: Adding display Classes")
        RETURN .F.
    ENDIF

    lnFields = AFIELDS(laFields)
    FOR lnI = 1 TO lnFields
        lcFieldName    = laFields[lnI,1]
        lcDataType     = laFields[lnI,2]

        lcClassName     = _SCREEN.goAppVars.GetAppVar( "DISPLAYCLASS_"+lcDataType )
        lcClassLib      = _SCREEN.goAppVars.GetAppVar( "DISPLAYCLASSLIB_"+lcDataType )


        IF !ISNULL(lcClassName) AND ! ISNULL(lcClassLib)
            DBSETPROP( lcTableName+'.' + lcFieldName,  'Field', 'DisplayClass', lcClassName )
            DBSETPROP( lcTableName+'.' + lcFieldName, 'Field', 'DisplayClassLibrary', lcClassLib )
        ENDIF

    ENDFOR

ENDFUNC
