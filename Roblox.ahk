#SingleInstance Force
#Persistent
#NoEnv
SetBatchLines, -1
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen

; GUI Setup
Gui, 4:Destroy
Gui, 4:+AlwaysOnTop -Resize +MinimizeBox +MaximizeBox +Owner
Gui, 4:Color, 1E1E1E
Gui, 4:Font, s10 cWhite, Segoe UI

Gui, 4:Add, Text, x10 y10 cGreen, Hub > Roblox
Gui, 4:Add, Tab2, x10 y40 w380 h160 vRobloxTab, Main|Teleport|Settings

Gui, 4:Tab, Main
Gui, 4:Add, GroupBox, x20 y70 w360 h130, Main Options

; Add transparent moving box (rectangle)
Gui, 4:Add, Progress, x30 y90 w100 h30 cWhite vCursorBox Background1E1E1E

; Add textbox to display detected word
Gui, 4:Add, Edit, x150 y90 w200 vDetectedText

Gui, 4:Add, Checkbox, x30 y130 w200 vAutoClick, Auto Click
Gui, 4:Add, Edit, x250 y130 w100 vClickDelay, 100 (ms)
Gui, 4:Add, Checkbox, x30 y160 w200 vAntiAFK, Anti AFK
Gui, 4:Add, Checkbox, x30 y190 w200 vFarmMacro, Farm Macro

; Other Tabs and Buttons Omitted for Brevity

Gui, 4:Tab
Gui, 4:Add, Button, x150 y210 w100 h30 gToggleStartStop cBlack Background32CD32 vStartStopBtn, Start
Gui, 4:Add, Text, x260 y215 w100 vStatusText cWhite, Status: Stopped

Gui, 4:Show, w400 h260, Roblox Config
GuiControl,, StatusText, Status: Stopped

; Start live tracking
SetTimer, TrackMouseAndUpdate, 50
return

GuiClose:
ExitApp
return

; Timer function to track mouse and update rectangle
TrackMouseAndUpdate:
MouseGetPos, mx, my
width := 100, height := 30
x := mx - (width//2), y := my - (height//2)
GuiControl, 4:Move, CursorBox, x%x% y%y% w%width% h%height%

; Try to copy text under cursor (primitive method)
Clipboard := ""
SendInput, {Click %mx%,%my% 2} ; double click to select word
Sleep, 100
SendInput, ^c
Sleep, 100
ClipWait, 0.5
text := Clipboard
if (text != "")
    GuiControl,, DetectedText, %text%
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
