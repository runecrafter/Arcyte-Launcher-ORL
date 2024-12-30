[Setup]
AppName=Arcyte Launcher
AppPublisher=Arcyte
UninstallDisplayName=Arcyte
AppVersion=${project.version}
AppSupportURL=https://arcyte.net/
DefaultDirName={localappdata}\Arcyte

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/app_small.bmp
WizardImageFile=${basedir}/innosetup/left.bmp
SetupIconFile=${basedir}/innosetup/app.ico
UninstallDisplayIcon={app}\Arcyte.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=OpenRuneSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-x86\Arcyte.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x86\Arcyte.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\launcher_x86.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-x86\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x86\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Arcyte\Arcyte"; Filename: "{app}\Arcyte.exe"
Name: "{userprograms}\Arcyte\Arcyte (configure)"; Filename: "{app}\Arcyte.exe"; Parameters: "--configure"
Name: "{userprograms}\Arcyte\Arcyte (safe mode)"; Filename: "{app}\Arcyte.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Arcyte"; Filename: "{app}\Arcyte.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Arcyte.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Arcyte.exe"; Description: "&Open Arcyte"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Arcyte.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.Arcyte\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"