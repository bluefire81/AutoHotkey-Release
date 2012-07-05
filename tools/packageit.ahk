SetWorkingDir %A_ScriptDir%\..

if WinActive(A_ScriptFullPath) || %True% = "/persist" {
    SetTitleMatchMode 2
    Hotkey IfWinActive, Installer_src
    Hotkey ~^s, packageit
    Menu Tray, Add
    Menu Tray, Add, Update Installer.ahk, packageit
    Menu Tray, Add, Rebuild Installer.exe, rebuild
    Menu Tray, Default, Rebuild Installer.exe
    Menu Tray, Click, 1
    return
}

packageit:
Sleep 200
FileRead htm, source\Installer_src.htm
FileRead ahk, source\Installer_src.ahk
ahk := RegExReplace(ahk, "`ams)((?<=`r`n)`r`n)?^\s*;#debug.*?^\s*;#end\R")
ahk := RegExReplace(ahk, "`am)^FileRead html,.*", "
(Join`r`n
html=
`(%``
" htm "
`)
)")
FileRead inc, %A_MyDocuments%\AutoHotkey\Lib\ShellRun.ahk
inc := RegExReplace(inc, "`ams)^/\*.*?^\*/\R")
ahk := RegExReplace(ahk, "`am)^#include <ShellRun>$", inc)
if 1 !=
    out = %1%
else
    out = include\Installer.ahk
FileDelete %out%
FileAppend %ahk%, %out%
return

rebuild:
Run %A_ScriptDir%\UPDATE.bat
return