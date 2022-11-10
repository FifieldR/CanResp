;Made By Ryan Fifield Project Started 2/8/22
;Orginal Name was IAFI.ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;vars

;Canada Address
canLoc = {Enter}{Enter}Axis Communications, Inc.{Enter}c/o Bigtech{Enter}5990 14th Ave{Enter}Markham, ON L3S 4M4{Enter}CANADA{Enter}
;USA Address
usaLoc = {Enter}{Enter}Axis Communications, Inc.{Enter}c/o Scanfil{Enter}4345 Hamilton Mill Road - Suite 400{Enter}Buford, GA 30518{Enter}UNITED STATES OF AMERICA{Enter}
;Mexico Address
mexLoc = {Enter}{Enter}Mexico, Ciudad Mexico{Enter}Axis Communications{Enter}Av. Insurgentes Sur 1647. Piso 8 - 801{Enter}Col. San José Insurgentes, Del. Benito Juárez{Enter}C. P. 03900{Enter}Ciudad de México, Distrito Federal{Enter}

Goto, ConfigMan

;CanResp Setup
^!c::
Goto, CRSU

;Tier 2 Template

TSENote:
    Send, Product: {Enter}{Enter}========================={Enter}{Enter}Spoke With: {Enter}{Enter}Reported Problem: {Enter}{Enter}-------------------------{Enter}Troubleshooting on call:{Enter}{Enter}{Enter}{Enter}{Enter}{Enter}-------------------------{Enter}{Enter}Current Status:{Enter}
    SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    Return


PSNote:
    Send, -----------------------------{Enter}Hello PS,{Enter}Please have a look at the below case.{Enter}{Enter}BUSINESS CASE:{Enter}Case Title:{Enter}Case Number:{Enter}{Enter}CASE SUMMARY{Enter}{Enter}{Enter}TROUBLESHOOTING PERFORMED{Enter}{Enter}{Enter}KNOWLEDGE CHECKLIST{Enter}1.Similar tickets in Service Cloud with relevant keywords/error codes >> X{Enter}2.SME OneNote articles >> X{Enter}3.Issue tracker articles >> X{Enter}4.Axis OS PORTAL & FW release notes & E2E Troubleshooting guides >> X{Enter}{Enter}SME/TSS INPUT{Enter}{Enter}If consulted, please specify the outcome of the SME review{Enter}{Enter}Also please specify in case of PS/Manager request > Ok to skip SME/TSS step exceptionally but Escalation template is still mandatory{Enter}{Enter}STEPS TO REPRODUCE{Enter}{Enter}{Enter}{Enter}{Enter}ACTION REQUESTED: {Enter}{Enter}{Enter}{Enter}Regards TSE{Enter}------------------------------
    SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    Return


;Chat Responses
^!1::
    Send, Hello, my name is %FName% and I will be assisting you with your RMA request. Please give me a moment to review this chat transcript before we begin.
    SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    Return
^!2::
    MsgBox, 4, information, Do you have the info needed to complete the RMA?,
    IfMsgBox, Yes
        buffer = I have all of the information that I need to create the RMA, I will just take a couple of minutes and I will have an RMA number for you.
        SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    IfMsgBox, No
        buffer = Where would you like us to ship the camera once it is repaired or replaced, can I also get a good contact number for you?
        SetToClip(buffer)
        SendEvent {Shift Up}{Ctrl Up}{Alt Up}
        Return
^!3::
    InputBox, RMAnum, RMA Number, Input RMA number,
    buffer = Your RMA{#} is %RMAnum%. There will be a detailed email to follow. Is there anything else that I can assist you with today?
    SetToClip(buffer)
    SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    Return
^!4::
    Send, My pleasure, thank you for choosing Axis Communications as your IP Video Surveillance partner. Have a great day!
    SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    Return
;Freeform Responses
FreeOpen:
    Send, Thank you for contacting Axis Communications. My name is %FName%, and I will be assisting you with this case.
    SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    Return
FreeClose:
    Send, %ending%
    SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    Return
;Issues

CanPaste:
    canboard := "CanBoard.clip"
    canbrr := FileOpen(canboard, "r")
    isovared := canbrr.Read()
    canbrr.Close()
    Send, %isovared%
    SendEvent {Shift Up}{Ctrl Up}{Alt Up}
    Return 
;Functions
SetToClip(buffer) {
    canboard := "CanBoard.clip"
    canbrw := FileOpen(canboard, "w")
    canbrw.Write(buffer)
    canbrw.Close()
    Return, 
}


;Includes
#Include, RMAInfo.ahk
#Include, RMAIssues.ahk
#Include, RMARecept.ahk
#Include, CanConFigManager.ahk