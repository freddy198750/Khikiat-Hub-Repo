#SingleInstance Force
#NoTrayIcon
; — CONFIGURATION —
games := ["Roblox", "Minecraft", "League of Legends"]
fileMap := { "Roblox":"Roblox.ahk"
           , "Minecraft":"Minecraft.ahk"
           , "League of Legends":"League of Legends.ahk" }
baseURL := "https://raw.githubusercontent.com/freddy198750/Khikiat-Hub-Repo/main/"

; — GUI LAYOUT —
Gui, +AlwaysOnTop -Resize +MinimizeBox +MaximizeBox
Gui, Color, 1E1E1E
Gui, Font, s10 cWhite, Segoe UI
Gui, Add, GroupBox, x20 y15 w360 h90 cGreen, Select Game
Gui, Add, DropDownList, x40 y45 vSelectedGame w200 cWhite Background202020, % JoinList(games)
Gui, Add, Button,       x260 y42 gRunFunction w100 h30 cBlack Background32CD32, RUN
Gui, Show, w400 h130, Khikiat Hub
return

; — CLICK “RUN” —
RunFunction:
    Gui, Submit, NoHide
    sel := SelectedGame
    if (!fileMap.HasKey(sel)) {
        Msg("กรุณาเลือกรายชื่อเกมก่อน")
        return
    }

    ; — เตรียม temp folder —
    tempDir := A_Temp "\KhikiatHub"
    FileCreateDir, %tempDir%

    ; — 1) ดาวน์โหลด Gdip.ahk (ถ้ายังไม่มี) —
    libURL   := baseURL . "Gdip.ahk"
    libLocal := tempDir "\Gdip.ahk"
    if !FileExist(libLocal)
        URLDownloadToFile, %libURL%, %libLocal%

    ; — 2) ดาวน์โหลดสคริปต์เกมที่เลือก —
    gameFile  := fileMap[sel]
    scriptURL := baseURL . gameFile
    localScript := tempDir "\" . gameFile
    URLDownloadToFile, %scriptURL%, %localScript%

    ; — ตรวจสอบ & รัน —
    if !FileExist(localScript) {
        Msg("ไม่สามารถดาวน์โหลดไฟล์: " . gameFile)
        return
    }
    FileRead, txt, %localScript%
    if InStr(txt, "404: Not Found") {
        Msg("ไม่พบไฟล์บน GitHub: " . gameFile)
        FileDelete, %localScript%
        return
    }
    Run, %localScript%
return

GuiClose:
    ExitApp

; — HELPERS — 
JoinList(arr) {
    out := ""
    for _, v in arr
        out .= "|" v
    return SubStr(out,2)
}
Msg(text) {
    MsgBox, 48, Khikiat Hub, %text%
}
