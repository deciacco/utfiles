&& types
#Define	DWORD		Long
#Define	WORD		Short
#Define SIZE_T		DWORD
#Define BOOL		Integer
#Define POINTER		Long
#Define LPVOID		POINTER
#Define LPCVOID		POINTER
#Define VOID
#Define	CHAR		String
#Define	UCHAR		Integer
#Define T_HANDLE	Integer
#Define T_HRESULT	Integer
#Define	T_VARTYPE	SHORT
#Define T_SAFEARRAY	POINTER
#Define	T_BSTR		POINTER
#Define	UINT		Integer
#Define	HKEY		Long
#Define LPCTSTR		String @
#Define LPTSTR		String @
#Define	REGSAM		Integer
#Define	PHKEY		HKEY @
#Define	LPDWORD		DWORD @
#Define LPBYTE		String @
#Define	PFILETIME 	String @
#Define	LPBOOL		BOOL @

#Define LPSYSTEMTIME 				String @
#Define LPTIME_ZONE_INFORMATION 	String @
#Define LPWIN32_FIND_DATA			String @
#Define	HINTERNET					Integer
#Define	INTERNET_PORT				Integer
#Define	HCRYPTPROV					Long

Declare BOOL CopyFile In "kernel32";
	as CopyFileA;
	LPCTSTR lpExistingFileName,;
	LPCTSTR lpNewFileName,;
	BOOL bFailIfExists

Declare BOOL CopyFileEx In "kernel32" ;
	as CopyFileExA;
	LPCTSTR lpExistingFileName, ;
	LPCTSTR lpNewFileName, ;
	LONG lpProgressRoutine, ;
	LPVOID lpData, ;
	LPBOOL pbCancel, ;
	DWORD dwCopyFlags ;
