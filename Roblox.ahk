#SingleInstance Force
#NoTrayIcon

; === Include GDI+ and start it ===
#Include Gdip.ahk
pToken := Gdip_Startup()
if (!pToken) {
    MsgBox, 16, Error, GDI+ ไม่สามารถเริ่มต้นได้
    ExitApp
}

; === Tesseract Path (ปรับตามที่คุณติดตั้ง) ===
tesseractPath := "C:\Program Files\Tesseract-OCR\tesseract.exe"

; === GUI Setup ===
Gui, +AlwaysOnTop -Resize -MaximizeBox -MinimizeBox
Gui, Color, 1E1E1E
Gui, Font, s10 cWhite, Segoe UI

Gui, Add, Text,       x10 y10 cGreen, Hub > Roblox
Gui, Add, Tab2,       x10 y30 w380 h320 vTabControl, Main|Misc|Settings

; --- Main Tab ---
Gui, Tab, Main
Gui, Add, GroupBox,   x20 y60 w360 h240, Brainrot AutoBuy Config

Gui, Add, Text,       x30 y95 cWhite, Available:
Gui, Add, ComboBox,   x100 y90 w200 vAvailableBrainrot gSelectAvail

Gui, Add, Text,       x30 y130 cWhite, Selected:
Gui, Add, ComboBox,   x100 y125 w200 vSelectedBrainrot gSelectRemove

Gui, Add, Checkbox,   x30 y165 w200 vAutoBuyBrainrot gToggleAutoBuy, AutoBuyBrainrot

Gui, Add, Checkbox,   x30 y195 w200 vDetectText gToggleDetectText, Detect Text
Gui, Add, Edit,       x150 y190 w200 h40 vDetectTextOutput ReadOnly

; --- Misc Tab ---
Gui, Tab, Misc
Gui, Add, GroupBox,   x20 y60 w360 h110, Misc Options
Gui, Add, Checkbox,   x30 y90 w300 vAntiAFK gToggleAFK, Anti AFK (Spacebar ทุก 10 นาที)

; --- Settings Tab ---
Gui, Tab, Settings
Gui, Add, GroupBox,   x20 y60 w360 h110, Save Settings
Gui, Add, Checkbox,   x30 y90 w300 vAutoSaveSetting gToggleAutoSave, Auto Save Setting to File

; Show GUI
Gui, Show, w400 h420, Roblox Config

; === Data Initialization ===
brainrotText =
(
NOOBINI PIZZANINI
LIRILI LARILÀ
Tim Cheese
Fluriflua
Talpa Di Fero
Svinina Bombardino
Pipi Kiwi
TRIPPI TROPPI
Tung Tung Tung Sahur
Gangster Footera
Boneca Ambalabu
Ta Ta Ta Ta Sahur
Tric Trac Baraboom
Bandito Bobritto
Cacto Hipopotamo
CAPPUCHINO ASSASSINO
Trulimero Trulicina
Bambini Crostini
Bananita Dolphinita
Brri Brri Bicus Dicus Bombicus
Brr Brr Patapim
Perochello Lemonchello
BURBALONI LOLILOLI
Chimpanzini Bananini
Ballerina Cappuccina
Chef Crabracadabra
Glorbo Fruttodrillo
Blueberrinni Octopusini
LIONEL CACTUSELI
Pandaccini Bananini
FRIGO CAMELO
Orangutini Ananassini
Rhino Toasterino
Bombardiro Crocodilo
Bombombini Gusini
CAVALLO VIRTUOSO
COCOFANTO ELEFANTO
Girafa Celestre
Tralalero Trarala
ODIN DIN DIN DUN
GATTATINO NYANINO
TRENOSTRUZZO TURBO 3000
Matteo
Unclito Samito
LA VACCA SATURONO SATURNITA
Los Tralaleritos
Graipuss Medussi
La Grande Combinazione
SAMMYNI SPYDERINI
GARAMA and MADUNDUNG
Orcalero Orcala
)

avail := []   ; รายชื่อพร้อมเลือก
sel   := []   ; รายชื่อที่เลือกแล้ว

Loop, Parse, brainrotText, `n, `r
    if (item := Trim(A_LoopField))
        avail.Push(item)

UpdateCombos()
return

; === GUI Close & Cleanup ===
GuiClose:
    SetTimer, DrawDetectBox, Off
    SetTimer, CaptureAndOCR, Off
    SetTimer, DoAntiAFK, Off
    Gdip_Shutdown(pToken)
    ExitApp
return

; === Main Tab Events ===
SelectAvail:
    Gui, Submit, NoHide
    if (!AvailableBrainrot)
        return
    Loop, % avail.Length()
        if (avail[A_Index] = AvailableBrainrot) {
            sel.Push(avail[A_Index])
            avail.RemoveAt(A_Index)
            break
        }
    UpdateCombos()
    if (AutoSaveSetting)
        SaveSettings()
return

SelectRemove:
    Gui, Submit, NoHide
    if (!SelectedBrainrot)
        return
    Loop, % sel.Length()
        if (sel[A_Index] = SelectedBrainrot) {
            avail.Push(sel[A_Index])
            sel.RemoveAt(A_Index)
            break
        }
    UpdateCombos()
    if (AutoSaveSetting)
        SaveSettings()
return

ToggleAutoBuy:
    Gui, Submit, NoHide
    if (AutoSaveSetting)
        SaveSettings()
return

; === Detect Text Events ===
ToggleDetectText:
    Gui, Submit, NoHide
    if (DetectText) {
        Gui, 5:Destroy
        Gui, 5:+ToolWindow -Caption +AlwaysOnTop +E0x20
        Gui, 5:Color, 00FF00
        Gui, 5:Show, x0 y0 w200 h40 NoActivate
        SetTimer, DrawDetectBox, 50
        SetTimer, CaptureAndOCR, 500
    } else {
        SetTimer, DrawDetectBox, Off
        SetTimer, CaptureAndOCR, Off
        Gui, 5:Hide
    }
return

DrawDetectBox:
    MouseGetPos, mx, my
    x := mx - 100, y := my - 20
    Gui, 5:Show, x%x% y%y% w200 h40 NoActivate
return

CaptureAndOCR:
    MouseGetPos, mx, my
    x := mx - 100, y := my - 20, w := 200, h := 40
    bmp := Gdip_BitmapFromScreen(x "|" y "|" w "|" h)
    tmpPng := A_Temp "\ocr_capture.png"
    Gdip_SaveBitmapToFile(bmp, tmpPng)
    Gdip_DisposeImage(bmp)
    tmpTxt := A_Temp "\ocr_text"
    RunWait, %ComSpec% " /c """ tesseractPath """ """ tmpPng """ """ tmpTxt """ -l eng",, Hide
    FileRead, textOut, % tmpTxt . ".txt"
    GuiControl,, DetectTextOutput, %textOut%
return

; === Misc Tab Events ===
ToggleAFK:
    Gui, Submit, NoHide
    if (AntiAFK)
        SetTimer, DoAntiAFK, 600000
    else
        SetTimer, DoAntiAFK, Off
    if (AutoSaveSetting)
        SaveSettings()
return

DoAntiAFK:
    SendInput {Space}
return

; === Settings Tab Events ===
ToggleAutoSave:
    Gui, Submit, NoHide
    if (AutoSaveSetting) {
        SaveSettings()
        MsgBox, 64, Settings, Auto-save enabled.`nSaved to %A_ScriptDir%\config.ini
    } else {
        MsgBox, 64, Settings, Auto-save disabled.
    }
return

; === Helper: Update ComboBoxes ===
UpdateCombos() {
    global avail, sel
    itemsA := "", itemsS := ""
    for idx, name in avail
        itemsA .= (idx>1 ? "|" : "") . name
    for idx, name in sel
        itemsS .= (idx>1 ? "|" : "") . name
    GuiControl,, AvailableBrainrot, |%itemsA%
    GuiControl,, SelectedBrainrot,  |%itemsS%
}

; === Helper: Save Settings to INI ===
SaveSettings() {
    global sel, AutoBuyBrainrot, AntiAFK, AutoSaveSetting
    IniFile := A_ScriptDir "\config.ini"
    list := ""
    for idx, name in sel
        list .= (idx>1 ? "|" : "") . name
    IniWrite, %list%,           %IniFile%, General, SelectedBrainrot
    IniWrite, %AutoBuyBrainrot%, %IniFile%, General, AutoBuyBrainrot
    IniWrite, %AntiAFK%,         %IniFile%, General, AntiAFK
    IniWrite, %AutoSaveSetting%, %IniFile%, General, AutoSaveSetting
}
