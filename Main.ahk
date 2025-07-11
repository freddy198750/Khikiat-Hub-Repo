#SingleInstance Force
#NoTrayIcon
; Khikiat Hub Launcher

; — Game list + map to filenames —
games := ["Roblox", "Minecraft", "League of Legends"]
fileMap := {}
fileMap["Roblox"]             := "Roblox.ahk"
fileMap["Minecraft"]          := "Minecraft.ahk"
fileMap["League of Legends"]  := "League of Legends.ahk"

; — Your GitHub raw base URL —
baseURL := "https://raw.githubusercontent.com/freddy198750/Khikiat-Hub-Repo/main/"

; — GUI layout —
Gui, +AlwaysOnTop -Resize +MinimizeBox +MaximizeBox
Gui, Color, 1E1E1E
Gui, Font, s10 cWhite, Segoe UI

Gui, Add, GroupBox, x20 y15 w360 h90 cGreen, Select Game
Gui, Add, DropDownList, x40 y45 vSelectedGame w200 cWhite Background202020, % JoinList(games)
Gui, Add, Button,       x260 y42 gRunFunction w100 h30 cBlack Background32CD32, RUN

Gui, Show, w400 h130, Khikiat Hub
return

; — RunFunction: download Gdip + game script + execute —
RunFunction:
    Gui, Submit, NoHide
    selectedFile := fileMap[SelectedGame]
    if (selectedFile = "") {
        CustomMsgBox("กรุณาเลือกรายชื่อเกมก่อน")
        return
    }

    ; create temp folder
    tempDir := A_Temp "\KhikiatHub"
    FileCreateDir, %tempDir%

    ; 1) Download Gdip.ahk if missing
    libURL   := baseURL . "Gdip.ahk"
    libLocal := tempDir "\Gdip.ahk"
    if !FileExist(libLocal)
        URLDownloadToFile, %libURL%, %libLocal%

    ; 2) Download chosen game script
    fullURL     := baseURL . selectedFile
    localScript := tempDir "\" selectedFile
    URLDownloadToFile, %fullURL%, %localScript%

    ; 3) Validate & run
    if !FileExist(localScript) {
        CustomMsgBox("ไม่สามารถดาวน์โหลดไฟล์: " selectedFile)
        return
    }
    FileRead, content, %localScript%
    if InStr(content, "404: Not Found") {
        CustomMsgBox("ไม่พบไฟล์บน GitHub: " selectedFile)
        FileDelete, %localScript%
        return
    }
    Run, %localScript%
return

GuiClose:
    ExitApp

; — Helpers — 
JoinList(arr) {
    out := ""
    for _, v in arr
        out .= "|" v
    return SubStr(out, 2)
}

CustomMsgBox(msg) {
    Gui, 2:Destroy
    Gui, 2:+AlwaysOnTop -SysMenu +ToolWindow
    Gui, 2:Color, 1E1E1E
    Gui, 2:Font, s10 cWhite, Segoe UI
    Gui, 2:Add, Text,   x20 y20 w360 h60 Center, %msg%
    Gui, 2:Add, Button, x160 y90 w80 h30 gCloseCustomMsgBox, OK
    Gui, 2:Show, w400 h140, Notification
}

CloseCustomMsgBox:
    Gui, 2:Destroy
return
