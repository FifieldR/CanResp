#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ConfigMan:
    file := "CanResp.conf"
    canboard := "CanBoard.clip"
    filever := 00000003
    if (FileExist(file)) {
        FileReadLine, starter, %file%, 1
        if (starter != filever) {
            MsgBox, It Looks that you have an outdated conf file. Do not worry we will run through a quick setup and then we can correct your conf file without you even needing to edit it yourself.
            Goto, CRSU
        
        }
    } else if !FileExist(file) {
       MsgBox, A CanResp.conf File was not found. Do not worry we will run through a quick setup.
        Goto, CRSU   
    }
    num = 1
    arnum = 1
    infopull := [1,1,1,1,1,1,1,1,1,1,1]
    Loop, 11{
        num := num + 2
        FileReadLine, infopullbuff, %file%, num
        infopull[arnum] := infopullbuff
        arnum++
    }
    FName := infopull[1]
    LName := infopull[2]
    Title := infopull[3]
    RINKEY := infopull[4]
    Hotkey, %RINKEY% , RMAIn, On
    RREKEY := infopull[5]
    Hotkey, %RREKEY% , RMARe, On
    RISKEY := infopull[6]
    Hotkey, %RISKEY% , RMAIs, On
    CRPKEY := infopull[7]
    Hotkey, %CRPKEY% , CanPaste, On
    TSEKEY := infopull[8]
    Hotkey, %TSEKEY% , TSENote, On
    PSKEY := infopull[9]
    Hotkey, %PSKEY% , PSNote, On
    OPENKEY := infopull[10]
    Hotkey, %OPENKEY% , FreeOpen, On
    CLOSEKEY := infopull[11]
    Hotkey, %CLOSEKEY% , FreeClose, On

    ;Vardependvars
    ;Opening
    opening = Thank you for contacting Axis Communications. My name is %FName%, and I will be assisting you with this case.
    ;Ending
    ending = {Enter}{Enter}Warm regards, {Enter}%FName%{Enter}%Title%{Enter}Axis Communications{Enter}Phone: 1-800-444-2947, option 2{Enter}Online Chat: http://www.axis.com/reg/chat.php{Enter}{Enter}
    MsgBox,4,Is This Correct?,%FName% %LName% %Title%
    IfMsgBox, No
       Goto, CRSU
    Return


CRSU:
    Gui, CRSU:New, ,CanResp Setup
    Gui, CRSU:Add, Text, , First Name
    Gui, CRSU:Add, Edit, vSetfname w160, %FName%
    Gui, CRSU:Add, Text, , Last Name
    Gui, CRSU:Add, Edit, vSetlname w160, %LName%
    Gui, CRSU:Add, Text, , Title
    Gui, CRSU:Add, Edit, vSettitle w160, %Title%
    Gui, CRSU:Add, Button, , Submit
    Gui, CRSU:Show
    Return
    CRSUButtonSubmit:
        Gui, CRSU:Submit
        Gui, CRSU:Destroy

    AdvHotSet = true
    if (Setfname = "" || Setlname = "" || Settitle = ""){
        MsgBox, One or more fields are empty
        Goto, CRSU
    } else if (!AdvHotSet) {
    filew :=FileOpen(file, "w")
    filew.Write(filever . "`r`nfirst_name_var: `r`n" . Setfname . "`r`nlast_name_var:`r`n" . Setlname . "`r`ntitle_var:`r`n" . Settitle)
    filew.Close()
    } else if (AdvHotSet) {
        Gui, AdvHKSET:New, ,Advanced Hotkey Setup
        Gui, AdvHKSET:Add, Text, , RMA Info Request
        Gui, Add, Hotkey, vRMAInHot, ^!r
        Gui, AdvHKSET:Add, Text, , RMA Receipt
        Gui, Add, Hotkey, vRMARcHot, ^!t
        Gui, AdvHKSET:Add, Text, , RMA Issues
        Gui, Add, Hotkey, vRMAIsHot, ^!i
        Gui, AdvHKSET:Add, Text, , CanResp Paste
        Gui, Add, Hotkey, vRMAPasteHot, ^!v
        Gui, AdvHKSET:Add, Text, , TSE Notes
        Gui, Add, Hotkey, vTSENoHot, ^!n
        Gui, AdvHKSET:Add, Text, , PS Notes
        Gui, Add, Hotkey, vPSNoHot, ^!p
        Gui, AdvHKSET:Add, Text, , Freeform Open
        Gui, Add, Hotkey, vFFOpHot, ^!f
        Gui, AdvHKSET:Add, Text, , Freeform Close
        Gui, Add, Hotkey, vFFClHot, ^!g
        Gui, AdvHKSET:Add, Button, , Submit
        Gui, AdvHKSET:Show
    Return
    AdvHKSETButtonSubmit:
        Gui, AdvHKSET:Submit
        Gui, AdvHKSET:Destroy

    filew :=FileOpen(file, "w")
    filew.Write(filever . "`r`nfirst_name_var: `r`n" . Setfname . "`r`nlast_name_var:`r`n" . Setlname . "`r`ntitle_var:`r`n" . Settitle . "`r`nrma_info_request:`r`n" . RMAInHot . "`r`nrma_receipt:`r`n" . RMARcHot . "`r`nrma_issues:`r`n" . RMAIsHot . "`r`ncanresp_paste:`r`n" . RMAPasteHot . "`r`ncanresp_tsenote:`r`n" . TSENoHot . "`r`ncanresp_psnote:`r`n" . PSNoHot . "`r`ncanresp_freeformopen:`r`n" . FFOpHot . "`r`ncanresp_freeformclose:`r`n" . FFClHot)
    filew.Close()
    Reload
    Return
    }