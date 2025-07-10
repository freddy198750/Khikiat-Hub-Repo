Gui, 4:Destroy ; ปิด GUI ก่อนหน้า (ถ้ามี)
Gui, 4:+AlwaysOnTop -Resize +MinimizeBox +MaximizeBox +Owner ; ตั้งค่า GUI 4 ให้อยู่ด้านบน และมีปุ่ม Minimize/Maximize
Gui, 4:Color, 1E1E1E ; ตั้งสีพื้นหลัง
Gui, 4:Font, s10 cWhite, Segoe UI ; ตั้งค่าฟอนต์ สี ขนาด

Gui, 4:Add, Text, x10 y10 cGreen, Hub > Roblox ; แสดง path ของเมนู

Gui, 4:Add, Tab2, x10 y40 w380 h160 vRobloxTab, Main|Teleport|Settings ; สร้าง Tab มี 3 หมวด

Gui, 4:Tab, Main
Gui, 4:Add, GroupBox, x20 y70 w360 h110, Main Options ; กรอบกลุ่มปุ่มหลัก
Gui, 4:Add, Checkbox, x30 y90 w200 vAutoClick, Auto Click ; Checkbox สำหรับ Auto Click
Gui, 4:Add, Edit, x250 y90 w100 vClickDelay, 100 (ms) ; ช่องกรอก delay
Gui, 4:Add, Checkbox, x30 y120 w200 vAntiAFK, Anti AFK ; Checkbox สำหรับกัน AFK
Gui, 4:Add, Checkbox, x30 y150 w200 vFarmMacro, Farm Macro ; Checkbox สำหรับมาโครฟาร์ม

Gui, 4:Tab, Teleport
Gui, 4:Add, GroupBox, x20 y70 w360 h110, Teleport Options ; กรอบตัวเลือก teleport
Gui, 4:Add, DropDownList, x30 y100 w200 vTPDest, Spawn|Shop|Mine ; เมนูเลือกจุด
Gui, 4:Add, Button, x250 y100 w100 gTeleportToDest, Teleport ; ปุ่มไปจุด teleport

Gui, 4:Tab, Settings
Gui, 4:Add, GroupBox, x20 y70 w360 h110, Extra Settings ; กลุ่มการตั้งค่าเสริม
Gui, 4:Add, Checkbox, x30 y90 w300 vAutoUpdate, Enable Auto-Update ; เช็คเปิดอัปเดตอัตโนมัติ
Gui, 4:Add, Edit, x30 y120 w320 vCustomParam, Custom Param ; กำหนดพารามิเตอร์เสริม

Gui, 4:Tab
Gui, 4:Add, Button, x150 y210 w100 h30 gToggleStartStop cBlack Background32CD32 vStartStopBtn, Start ; ปุ่มเริ่มต้น/หยุด
Gui, 4:Add, Text, x260 y215 w100 vStatusText cRed, Status: Stopped ; สถานะเริ่มต้น: หยุด

Gui, 4:Show, w400 h260, Roblox Config ; แสดงหน้าต่าง GUI 4
Gui, 4:Default
GuiControl,, StatusText, Status: Stopped ; ตั้งข้อความเริ่มต้นของสถานะ
GuiControl, +cRed, StatusText ; ตั้งสีเริ่มต้นเป็นแดง
return

GuiClose:
Run, main.ahk ; กลับไปหน้า Main เมื่อปิด Roblox GUI
ExitApp
return

ToggleStartStop:
Gui, 4:Submit, NoHide ; บันทึกค่าจาก GUI โดยไม่ปิด
GuiControlGet, currentLabel,, StartStopBtn ; ดึงข้อความจากปุ่ม
if (currentLabel = "Start") {
    GuiControl,, StartStopBtn, Stop ; เปลี่ยนข้อความปุ่มเป็น Stop
    GuiControl,, StatusText, Status: Running ; อัปเดตสถานะ
    GuiControl, +cGreen, StatusText ; สีเขียวเมื่อทำงานอยู่
} else {
    GuiControl,, StartStopBtn, Start ; เปลี่ยนกลับเป็น Start
    GuiControl,, StatusText, Status: Stopped ; อัปเดตสถานะ
    GuiControl, +cRed, StatusText ; สีแดงเมื่อหยุด
}
return

TeleportToDest:
Gui, 4:Submit, NoHide ; รับค่าจาก DropDownList
MsgBox, 64, Teleport, Teleporting to: %TPDest% ; แสดงจุดที่เลือกเทเลพอร์ต
return
