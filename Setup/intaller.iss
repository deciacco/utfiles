[Setup]
AppName=UtFile
AppVerName=UtFile v1.2.132 Alpha
DefaultDirName={pf}\Deciacco.com\UtFile
DefaultGroupName=Deciacco.com\UtFile
DisableProgramGroupPage=true
OutputDir=Z:\Projects\UtFiles\Setup
OutputBaseFilename=utfilesetup
Compression=lzma
SolidCompression=true
AppCopyright=Copyright (C) 2006 Deciacco.com
PrivilegesRequired=admin
ShowLanguageDialog=no
AlwaysUsePersonalGroup=true
LicenseFile=license.txt
InfoAfterFile=readme.txt
DisableReadyPage=true
SourceDir=Z:\Projects\UtFiles
MinVersion=4.1.1998,5.0.2195

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: utfiles.exe; DestDir: {app}; Flags: ignoreversion
Source: Data\*; DestDir: {app}\Data; Flags: ignoreversion recursesubdirs createallsubdirs confirmoverwrite
Source: Help\Help.chm; DestDir: {app}
Source: testgame.exe; DestDir: {app}
Source: readme.txt; DestDir: {app}
Source: license.txt; DestDir: {app}
Source: vfp2c32.fll; DestDir: {app}

; Microsoft Graphics Device Interface Plus (GDI+) DLL
Source: Z:\Projects\VFP9Distrib\gdiplus.dll; DestDir: {cf}\Microsoft Shared\VFP; Flags: sharedfile uninsneveruninstall restartreplace

; Microsoft Visual C++ 7.1 Runtime DLL
Source: Z:\Projects\VFP9Distrib\msvcr71.dll; DestDir: {cf}\Microsoft Shared\VFP; Flags: onlyifdoesntexist deleteafterinstall
Source: Z:\Projects\VFP9Distrib\msvcr71.dll; DestDir: {app}; Flags: onlyifdoesntexist

; Microsoft Visual FoxPro 9.0 Runtime Support Libraries
Source: Z:\Projects\VFP9Distrib\vfp9r.dll; DestDir: {cf}\Microsoft Shared\VFP; Flags: regserver sharedfile uninsneveruninstall onlyifdoesntexist
Source: Z:\Projects\VFP9Distrib\vfp9t.dll; DestDir: {cf}\Microsoft Shared\VFP; Flags: sharedfile uninsneveruninstall onlyifdoesntexist
Source: Z:\Projects\VFP9Distrib\vfp9renu.dll; DestDir: {cf}\Microsoft Shared\VFP; Flags: sharedfile uninsneveruninstall onlyifdoesntexist

Source: C:\WINDOWS\system32\mscomctl.ocx; DestDir: {sys}; Flags: restartreplace sharedfile regserver
Source: C:\WINDOWS\system32\richtx32.ocx; DestDir: {sys}; Flags: restartreplace sharedfile regserver

[Icons]
Name: {group}\UtFile; Filename: {app}\utfiles.exe
Name: {group}\Help; Filename: {app}\help.chm
Name: {group}\{cm:UninstallProgram,UtFile}; Filename: {uninstallexe}
Name: {userdesktop}\UtFile; Filename: {app}\utfiles.exe; Tasks: desktopicon
