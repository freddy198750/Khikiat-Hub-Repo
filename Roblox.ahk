Gui, 4:Destroy
Gui, 4:+AlwaysOnTop -Resize +MinimizeBox +MaximizeBox +Owner
Gui, 4:Color, 1E1E1E
Gui, 4:Font, s10 cWhite, Segoe UI

Gui, 4:Add, Text, x10 y10 cGreen, Hub > Roblox
Gui, 4:Add, Button, x300 y10 w80 h25 gBackToMainFromRoblox, Back

Gui, 4:Add, Tab2, x10 y40 w380 h160 vRobloxTab, Main|Teleport|Settings

Gui, 4:Tab, Main
Gui, 4:Add, GroupBox, x20 y70 w360 h110, Main Options
Gui, 4:Add, Checkbox, x30 y90 w200 vAutoClick, Auto Click
Gui, 4:Add, Edit, x250 y90 w100 vClickDelay, 100 (ms)
Gui, 4:Add, Checkbox, x30 y120 w200 vAntiAFK, Anti AFK
Gui, 4:Add, Checkbox, x30 y150 w200 vFarmMacro, Farm Macro

Gui, 4:Tab, Teleport
Gui, 4:Add, GroupBox, x20 y70 w360 h110, Teleport Options
Gui, 4:Add, DropDownList, x30 y100 w200 vTPDest, Spawn|Shop|Mine
Gui, 4:Add, Button, x250 y100 w100 gTeleportToDest, Teleport

Gui, 4:Tab, Settings
Gui, 4:Add, GroupBox, x20 y70 w360 h110, Extra Settings
Gui, 4:Add, Checkbox, x30 y90 w300 vAutoUpdate, Enable Auto-Update
Gui, 4:Add, Edit, x30 y120 w320 vCustomParam, Custom Param

Gui, 4:Tab
Gui, 4:Add, Button, x150 y210 w100 h30 gRunRobloxFunctions, RUN SELECTED

Gui, 4:Show, w400 h260, Roblox Config
return

RunRobloxFunctions:
Gui, 4:Submit, NoHide
msg := ""
if (AutoClick)
    msg .= "- Auto Click with delay: " . ClickDelay . " ms\n"
if (AntiAFK)
    msg .= "- Anti AFK enabled\n"
if (FarmMacro)
    msg .= "- Farm Macro enabled\n"
if (AutoUpdate)
    msg .= "- Auto Update ON\n"
if (CustomParam != "")
    msg .= "- Custom Param: " . CustomParam . "\n"
MsgBox, 64, Roblox Run Result, % (msg != "") ? msg : "No functions selected."
return

TeleportToDest:
Gui, 4:Submit, NoHide
MsgBox, 64, Teleport, Teleporting to: %TPDest%
return
