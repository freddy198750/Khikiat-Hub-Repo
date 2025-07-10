games := ["Roblox", "Minecraft", "Genshin Impact"]
functions := Object()
functions["Roblox"] := ["Auto Click", "Anti AFK", "Farm Macro"]
functions["Minecraft"] := ["Auto Build", "Fast Break", "Sprint Macro"]
functions["Genshin Impact"] := ["Auto Heal", "Combo Spam"]

fileMap := Object()
fileMap["Roblox|Auto Click"] := "Roblox.ahk"
fileMap["Roblox|Anti AFK"] := "Roblox.ahk"
fileMap["Roblox|Farm Macro"] := "Roblox.ahk"
fileMap["Minecraft|Auto Build"] := "Minecraft.ahk"
fileMap["Minecraft|Fast Break"] := "Minecraft.ahk"
fileMap["Minecraft|Sprint Macro"] := "Minecraft.ahk"
fileMap["Genshin Impact|Auto Heal"] := "Genshin.ahk"
fileMap["Genshin Impact|Combo Spam"] := "Genshin.ahk"

baseURL := "https://raw.githubusercontent.com/YourUser/YourRepo/main/"

Gui, Add, Text, x30 y30, List Game
Gui, Add, DropDownList, x120 y28 vSelectedGame gUpdateFunctions w200, % JoinList(games)

Gui, Add, Text, x30 y70, List Function
Gui, Add, DropDownList, x120 y68 vSelectedFunction w200,

Gui, Add, Button, x160 y120 gRunFunction w80 h30, RUN

Gui, Show, w400 h200, Khikiat Hub
return

UpdateFunctions:
GuiControlGet, SelectedGame
GuiControl,, SelectedFunction, |
funcList := ""
for index, func in functions[SelectedGame]
    funcList .= "|" . func
GuiControl,, SelectedFunction, % SubStr(funcList, 2)
return

RunFunction:
Gui, Submit, NoHide
key := SelectedGame . "|" . SelectedFunction
if (fileMap.HasKey(key)) {
    fullURL := baseURL . fileMap[key]
    tempFile := A_Temp . "\\temp_" . fileMap[key]
    URLDownloadToFile, %fullURL%, %tempFile%
    Run, %tempFile% "%SelectedFunction%"
} else {
    MsgBox, ไม่พบฟังก์ชันหรือยังไม่ได้ระบุ URL
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
