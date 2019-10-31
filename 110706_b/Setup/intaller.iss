[Setup]
AppName=UtFile
AppVerName=UtFile
DefaultDirName={pf}\UtFile
DefaultGroupName=UtFile
DisableProgramGroupPage=true
OutputDir=Z:\Projects\UtFiles\Setup
OutputBaseFilename=utfilesetup
Compression=lzma
SolidCompression=true
AppCopyright=EC Consulting
PrivilegesRequired=poweruser
ShowLanguageDialog=no
VersionInfoVersion=
DisableDirPage=true

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: Z:\Projects\UtFiles\utfiles.exe; DestDir: {app}; Flags: ignoreversion
Source: Z:\Projects\UtFiles\Data\*; DestDir: {app}\Data; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: C:\WINDOWS\system32\msvcr71.dll; DestDir: {cf}\Microsoft Shared\VFP; Flags: deleteafterinstall
Source: C:\WINDOWS\system32\msvcr71.dll; DestDir: {app}; Flags: onlyifdoesntexist
Source: C:\Program Files\Common Files\Microsoft Shared\VFP\vfp9r.dll; DestDir: {cf}\Microsoft Shared\VFP; Flags: regserver sharedfile onlyifdoesntexist uninsneveruninstall
Source: C:\Program Files\Common Files\Microsoft Shared\VFP\vfp9t.dll; DestDir: {cf}\Microsoft Shared\VFP; Flags: regserver sharedfile onlyifdoesntexist uninsneveruninstall
Source: C:\Program Files\Common Files\Microsoft Shared\VFP\VFP9RENU.DLL; DestDir: {cf}\Microsoft Shared\VFP; Flags: uninsneveruninstall onlyifdoesntexist
;Source: C:\Program Files\Common Files\Microsoft Shared\VFP\FM20.DLL; DestDir: {sys}; Flags: regserver sharedfile onlyifdoesntexist uninsneveruninstall
Source: Z:\Projects\UtFiles\Help\Help.chm; DestDir: {app}
Source: Z:\Projects\UtFiles\testgame.exe; DestDir: {app}

[Icons]
Name: {group}\UtFile; Filename: {app}\utfiles.exe
Name: {group}\Help; Filename: {app}\help.chm
Name: {group}\{cm:UninstallProgram,UtFile}; Filename: {uninstallexe}
Name: {userdesktop}\UtFile; Filename: {app}\utfiles.exe; Tasks: desktopicon

