#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ConfigMan:
    file := "CanResp.conf"
    canboard := "CanBoard.clip"
    filever := 00000002
    if (FileExist(file)) {
        FileReadLine, starter, %file%, 1
        if (starter != filever) {
            MsgBox, It Looks that you have an outdated conf file. Do not worry we will run through a quick setup and then we can correct your conf file without you even needing to edit it yourself. This also reduces the chance of human error.
            Goto, CRSU
        
        }
    } else if !FileExist(file) {
       MsgBox, A CanResp.conf File was not found. Do not worry we will run through a quick setup.
        Goto, CRSU   
    }
    FileReadLine, FName, %file%, 3
    FileReadLine, LName, %file%, 5
    FileReadLine, Title, %file%, 7
    MsgBox,4,Is This Correct?,%FName% %LName% %Title%
    IfMsgBox, No
       Goto, CRSU
    Return


CRSU:
    Gui, CRSU:New, ,CanResp Setup
    Gui, CRSU:Add, Text, , First Name
    Gui, CRSU:Add, Edit, vSetfname w160, Joe
    Gui, CRSU:Add, Text, , Last Name
    Gui, CRSU:Add, Edit, vSetlname w160, Smith
    Gui, CRSU:Add, Text, , Title
    Gui, CRSU:Add, Edit, vSettitle w160, Janitor Manager
    Gui, CRSU:Add, Checkbox, vAdvHotSet, Advanced Hotkey Setup(Currently not doing anything)
    Gui, CRSU:Add, Button, , Submit
    Gui, CRSU:Show
    Return
    CRSUButtonSubmit:
        Gui, CRSU:Submit
        Gui, CRSU:Destroy

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
        Gui, Add, Hotkey, vTSENOHot, ^!name
        Gui, AdvHKSET:Add, Text, , PS Notes
        Gui, Add, Hotkey, vPSNoHot, ^!p
        Gui, AdvHKSET:Add, Button, , Submit
        Gui, AdvHKSET:Show
    Return
    AdvHKSETButtonSubmit:
        Gui, AdvHKSET:Submit
        Gui, AdvHKSET:Destroy

    filew :=FileOpen(file, "w")
    filew.Write(filever . "`r`nfirst_name_var: `r`n" . Setfname . "`r`nlast_name_var:`r`n" . Setlname . "`r`ntitle_var:`r`n" . Settitle . "`r`nrma_info_request:`r`n" . RMAInHot . "`r`nrma_receipt:`r`n" . RMARcHot . "`r`nrma_issues:`r`n" . RMAIsHot . "`r`ncanresp_paste:`r`n" . RMAPasteHot)
    filew.Close()
    Return
    }