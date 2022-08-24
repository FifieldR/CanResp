;Made By Ryan Fifield Project Started 2/8/22
;Orginal Name was IAFI.ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
file := "CanResp.conf"
canboard := "CanBoard.clip"
filever := 00000001
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
    
CoordMode, caret, screen
CoordMode, mouse, screen
#Include, Acc.ahk
#Include, RMAInfo.ahk
#Include, RMAIssues.ahk
#Include, RMARecept.ahk
DetectHiddenWindows, On
;Ending
ending = {Enter}{Enter}Thank you for choosing Axis Communications as your IP Video Surveillance partner{!}{Enter}{Enter}Warm regards, {Enter}%FName%{Enter}%Title%{Enter}Axis Communications{Enter}Phone: 1-800-444-2947, option 2{Enter}Online Chat: http://www.axis.com/reg/chat.php
;CanResp Setup
Pause & c::
CRSU:
    Gui, CRSU:New, ,CanResp Setup
    Gui, CRSU:Add, Text, , First Name
    Gui, CRSU:Add, Edit, vSetfname w160, Joe
    Gui, CRSU:Add, Text, , Last Name
    Gui, CRSU:Add, Edit, vSetlname w160, Smith
    Gui, CRSU:Add, Text, , Title
    Gui, CRSU:Add, Edit, vSettitle w160, Janitor Manager
    Gui, CRSU:Add, Button, , Submit
    Gui, CRSU:Show
    Return
    CRSUButtonSubmit:
        Gui, CRSU:Submit
        Gui, CRSU:Destroy

    if (Setfname = "" || Setlname = "" || Settitle = ""){
        MsgBox, One or more fields are empty
        Goto, CRSU
    } else {
    filew :=FileOpen(file, "w")
    filew.Write(filever . "`r`nfirst_name_var: `r`n" . Setfname . "`r`nlast_name_var:`r`n" . Setlname . "`r`ntitle_var:`r`n" . Settitle)
    filew.Close()
    }
    Return

;RMA Responses
PrintScreen & r::
 Goto, RMAIn


Pause & r::
 Goto, RMARe


;Chat Responses
PrintScreen & 1::
    Send, Hello, my name is %FName% and I will be assisting you with your RMA request. Please give me a moment to review this chat transcript before we begin.
    Return
PrintScreen & 2::
    MsgBox, 4, information, Do you have the info needed to complete the RMA?,
    IfMsgBox, Yes
        buffer = I have all of the information that I need to create the RMA, I will just take a couple of minutes and I will have an RMA number for you.
    IfMsgBox, No
        buffer = Where would you like us to ship the camera once it is repaired or replaced, can I also get a good contact number for you?
        SetToClip(buffer)
        Return
PrintScreen & 3::
    InputBox, RMAnum, RMA Number, Input RMA number,
    buffer = Your RMA{#} is %RMAnum%. There will be a detailed email to follow. Is there anything else that I can assist you with today?
    SetToClip(buffer)
    Return
PrintScreen & 4::
    Send, My pleasure, thank you for choosing Axis Communications as your IP Video Surveillance partner. Have a great day!
    Return
;Freeform Responses
PrintScreen & f::
    Send, Thank you for contacting Axis Communications. My name is %FName%, and I will be assisting you with this case. 
    Return
Pause & f::
    Send, %ending%
    Return
;Issues
PrintScreen & i::
 Goto, RMAIs

PrintScreen & v::
    canboard := "CanBoard.clip"
    canbrr := FileOpen(canboard, "r")
    isovared := canbrr.Read()
    canbrr.Close()
    Send, %isovared%
    Return 
;Functions
SetToClip(buffer) {
    canboard := "CanBoard.clip"
    canbrw := FileOpen(canboard, "w")
    canbrw.Write(buffer)
    canbrw.Close()
    Return, 
}
