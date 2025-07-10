games := ["Roblox", "Minecraft", "Genshin Impact"]

fileMap := Object()
fileMap["Roblox"] := "Roblox.ahk"
fileMap["Minecraft"] := "Minecraft.ahk"
fileMap["Genshin Impact"] := "Genshin.ahk"

baseURL := "https://raw.githubusercontent.com/YourUser/YourRepo/main/"

Gui, Add, Text, x30 y30, Select Game
Gui, Add, DropDownList, x120 y28 vSelectedGame w200, % JoinList(games)

Gui, Add, Button, x160 y80 gRunFunction w80 h30, RUN

Gui, Show, w400 h150, Khikiat Hub
return

RunFunction:
Gui, Submit, NoHide
if (fileMap.HasKey(SelectedGame)) {
    fullURL := baseURL . fileMap[SelectedGame]
    tempFile := A_Temp . "\\temp_" . fileMap[SelectedGame]
    URLDownloadToFile, %fullURL%, %tempFile%
    Run, %tempFile%
} else {
    MsgBox, ไม่พบเกมหรือยังไม่ได้ระบุ URL
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
