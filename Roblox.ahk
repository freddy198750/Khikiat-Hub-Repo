#SingleInstance Force
#NoTrayIcon

Gui, 4:Destroy
Gui, 4:+AlwaysOnTop -Resize +MinimizeBox +MaximizeBox +Owner
Gui, 4:Color, 1E1E1E
Gui, 4:Font, s10 cWhite, Segoe UI

Gui, 4:Add, Text, x10 y10 cGreen, Hub > Roblox
Gui, 4:Add, Tab2, x10 y40 w380 h160 vRobloxTab, Main|Teleport|Settings

; ==== Main Tab ====
Gui, 4:Tab, Main
Gui, 4:Add, GroupBox, x20 y70 w360 h130, Main Options
Gui, 4:Add, Checkbox, x30 y90 w200 vAutoClick, Auto Click
Gui, 4:Add, Edit, x250 y90 w100 vClickDelay, 100 (ms)
Gui, 4:Add, Checkbox, x30 y120 w200 vAntiAFK, Anti AFK
Gui, 4:Add, Checkbox, x30 y150 w200 vFarmMacro, Farm Macro
Gui, 4:Add, Checkbox, x250 y120 w200 vDetectText gToggleDetectText, Detect Text

; ==== Teleport Tab ====
Gui, 4:Tab, Teleport
Gui, 4:Add, GroupBox, x20 y70 w360 h110, Teleport Options
Gui, 4:Add, DropDownList, x30 y100 w200 vTPDest, Spawn|Shop|Mine
Gui, 4:Add, Button, x250 y100 w100 gTeleportToDest, Teleport

; ==== Settings Tab ====
Gui, 4:Tab, Settings
Gui, 4:Add, GroupBox, x20 y70 w360 h110, Extra Settings
Gui, 4:Add, Checkbox, x30 y90 w300 vAutoUpdate, Enable Auto-Update
Gui, 4:Add, Edit, x30 y120 w320 vCustomParam, Custom Param

; ==== Bottom Button & Status ====
Gui, 4:Tab
Gui, 4:Add, Button, x150 y210 w100 h30 gToggleStartStop cBlack Background32CD32 vStartStopBtn, Start
Gui, 4:Add, Text, x260 y215 w100 vStatusText cWhite, Status: Stopped

Gui, 4:Show, w400 h260, Roblox Config
Gui, 4:Default
GuiControl,, StatusText, Status: Stopped
return

; ========== Events ==========

GuiClose:
SetTimer, DrawMouseBox, Off
Gui, 5:Destroy
ExitApp
return

ToggleStartStop:
Gui, 4:Submit, NoHide
GuiControlGet, currentLabel,, StartStopBtn
if (currentLabel = "Start") {
    GuiControl,, StartStopBtn, Stop
    GuiControl,, StatusText, Status: Running
} else {
    GuiControl,, StartStopBtn, Start
    GuiControl,, StatusText, Status: Stopped
}
return

TeleportToDest:
Gui, 4:Submit, NoHide
MsgBox, 64, Teleport, Teleporting to: %TPDest%
return

ToggleDetectText:
Gui, 4:Submit, NoHide
if (DetectText) {
    Gui, 5:Destroy
    Gui, 5:+ToolWindow -Caption +AlwaysOnTop +E0x20
    Gui, 5:Color, Red
    Gui, 5:Show, x0 y0 w100 h100 NoActivate
    SetTimer, DrawMouseBox, 50
} else {
    SetTimer, DrawMouseBox, Off
    Gui, 5:Hide
}
return

DrawMouseBox:
MouseGetPos, xpos, ypos
x := xpos - 50, y := ypos - 50  ; กึ่งกลางกล่องบนเมาส์
Gui, 5:Show, x%x% y%y% w100 h100 NoActivate
return
