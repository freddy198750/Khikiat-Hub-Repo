games := ["Roblox", "Minecraft", "League of Legends"]

fileMap := Object()
fileMap["Roblox"] := "Roblox.ahk"
fileMap["Minecraft"] := "Minecraft.ahk"
fileMap["League of Legends"] := "League of Legends.ahk"

baseURL := "https://github.com/freddy198750/Khikiat-Hub-Repo/tree/main/"

Gui, +AlwaysOnTop -Resize +MinimizeBox +MaximizeBox
Gui, Color, 1E1E1E  ; dark background
Gui, Font, s10 cWhite, Segoe UI

Gui, Add, GroupBox, x20 y15 w360 h90 cGreen, Select Game
Gui, Add, DropDownList, x40 y45 vSelectedGame w200 cWhite Background202020, % JoinList(games)
Gui, Add, Button, x260 y42 gRunFunction w100 h30 cBlack Background32CD32, RUN

Gui, Show, w400 h130, Khikiat Hub
return

RunFunction:
Gui, Submit, NoHide
selectedFile := fileMap[SelectedGame]
if (selectedFile != "") {
    fullURL := baseURL . selectedFile
    tempFile := A_Temp . "\\temp_" . selectedFile
    URLDownloadToFile, %fullURL%, %tempFile%

    if FileExist(tempFile) {
        FileRead, fileContent, %tempFile%
        if InStr(fileContent, "404: Not Found") {
            CustomMsgBox("ไม่พบไฟล์บน GitHub: " . selectedFile)
            FileDelete, %tempFile%
            return
        } else {
            Run, %tempFile%
        }
    } else {
        CustomMsgBox("ไม่สามารถดาวน์โหลดไฟล์: " . selectedFile)
    }
} else {
    CustomMsgBox("ไม่พบเกมหรือยังไม่ได้ระบุ URL")
}
return

JoinList(arr) {
    out := ""
    for i, v in arr
        out .= "|" . v
    return SubStr(out, 2)
}

GuiClose:
ExitApp

CustomMsgBox(msg) {
    Gui, 2:Destroy
    Gui, 2:+AlwaysOnTop -SysMenu +ToolWindow
    Gui, 2:Color, 1E1E1E
    Gui, 2:Font, s10 cWhite, Segoe UI
    Gui, 2:Add, Text, x20 y20 w360 h60 Center, %msg%
    Gui, 2:Add, Button, x160 y90 w80 h30 gCloseCustomMsgBox, OK
    Gui, 2:Show, w400 h140, Notification
}

CloseCustomMsgBox:
Gui, 2:Destroy
return
