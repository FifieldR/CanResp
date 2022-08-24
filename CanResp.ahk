;Made By Ryan Fifield Project Started 2/8/22
;Orginal Name was IAFI.ahk
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
file := "CanResp.conf"
filever := 00000001
;File Starter Is in Binary
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
#WinActivateForce
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
    findCaret()
    Gui, RIR:New, ,RMA Info Request
    Gui, RIR:Add, Text, , What is The Product
    Gui, RIR:Add, Edit, vProduct,
    Gui, RIR:Add, Text, , What is The Serial Number
    Gui, RIR:Add, Edit, vSerial,
    Gui, RIR:Add, Text, , RMA Type
    Gui, RIR:Add, Radio, vRMASt, Standard
    Gui, RIR:Add, Radio, vRMAAd, Advanced
    Gui, RIR:Add, Radio, vRMAOOW, Out Of Warranty
    Gui, RIR:Add, Radio, vRMADOA, Dead On Arrival
    Gui, RIR:Add, Text, , Are They A Partner
    Gui, RIR:Add, Checkbox, vPartner, Partner
    Gui, RIR:Add, Button, , Submit
    Gui, RIR:Show
    Return
    RIRButtonSubmit:
        Gui, RIR:Submit
        Gui, RIR:Destroy

    If (RMASt){
        moveclick(x, y, wintitle)
        Send, Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the Standard RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}Once I get that information I will create an RMA for the defective unit.{Enter}NOTE: Standard RMA is free of charge, but can take 7-10 business days to complete once the unit is received at our repair facility. You would send us the device; we would test to verify the failure. If we can repair it we will, but if it is not repairable we will send you a replacement unit.%ending%
        Return
    }else if (RMAAd & partner){
        moveclick(x, y, wintitle)
        Send, Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the Advance Replacement RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}Once I get that information I can create an RMA for the defective unit.{Enter}{Enter}NOTE: With the Advanced Replacement program, a replacement device would be sent to you via UPS ground within the next few days. We ask that you return the defective camera within 20 business days of receipt of the replacement unit.%ending%
        Return
    }else if (RMAAd & !partner){
        InputBox, MSRP, MSRP, What is the MSRP?,
        moveclick(x, y, wintitle)
        Send, Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the Advanced RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}For our Advanced Replacement RMA program, a replacement device would be sent to you via UPS ground only after receiving the Advanced Replacement Authorization form via fax. A link to the Advanced Replacement Authorization form would be sent to you via an automated email once the Advanced Replacement has been processed by Axis Technical Support.{Enter}{Enter}Some important notes about the Advanced Replacement: A $30 service fee plus a $20 per camera fee will be charged to the credit card provided on the Advanced Replacement Authorization form.  A hold would be placed on the CC for the MSRP of the camera ($%MSRP%.00 USD), this hold is released after our repair facility has received the defective unit.  A replacement camera would be shipped within 24 to 48 hours after receiving the form. We ask that you return the defective camera within 20 business days of receipt of the replacement unit.%ending%
        Return
    } else if (RMADOA & partner){
        moveclick(x, y, wintitle)
        Send, Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the 30-Day Replacement RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}Once I get that information I can create an RMA for the defective camera.{Enter}{Enter}NOTE: For a 30-Day Replacement RMA we will overnight ship a new unit to you if it is within 30 days of purchase. A replacement unit will be shipped within the next business day and it will come with a UPS Return Shipment Label for the defective. We ask that you return the defective unit within 20 business days of receipt of the replacement unit.%ending%
        Return
    } else if (RMADOA & !partner){
        InputBox, MSRP, MSRP, What is the MSRP?,
        moveclick(x, y, wintitle)
        Send, Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the 30-Day Replacement RMA process I will need to know a couple of things. Once I get this information I can create an RMA for the defective unit.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}3. Which 30-Day Replacement RMA Option you prefer as detailed below{Enter}{Enter}Option 1 (30-Day Replacement RMA with Credit Card Hold):{Enter}For this option, we will ship a new unit only after receiving the DOA (Cross Shipment) form via fax, a link to the Cross Shipment form would be sent to you via an automated email. A hold would be placed on the CC for the MSRP of the unit ($%MSRP%.00 USD), this hold is released after our repair facility has received the defective unit. A new replacement unit would be shipped within 24 to 48 hours after receiving the form. We ask that you return the defective camera within 20 business days of receipt of the replacement unit.{Enter}{Enter}Option 2 (30-Day Replacement RMA without Credit Card Hold):{Enter}For this option, we will ship a new unit within 24 to 48 hours ONLY after receiving the defective unit at our repair facility.%ending%
        Return
    } else if (RMAOOW){
        Gui, OOWInfo:New , ,Out of Warranty Info
        Gui, OOWInfo:Add, Text, , What is The Case Number
        Gui, OOWInfo:Add, Edit, vCase,
        Gui, OOWInfo:Add, Text, , How long was the warranty
        Gui, OOWInfo:Add, Edit, vYear,
        Gui, OOWInfo:Add, Text, , What is the cost to repair
        Gui, OOWInfo:Add, Edit, vCost,
        Gui, OOWInfo:Add, Button, , Submit
        Gui, OOWInfo:Show
        Return
        OOWInfoButtonSubmit:
            Gui, OOWInfo:Submit
            Gui, OOWInfo:Destroy
        moveclick(x, y, wintitle)
        Send, Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Unfortunately, our system shows that the warranty on your %product% (SN: %serial%) has expired. If you feel this is in error, please provide a dated billing or shipping receipt as proof of purchase in order to show that this unit is still within its original warranty period of: %year% year(s).{Enter}{Enter}Optionally, we do have an Out of Warranty Repair RMA program. The cost to repair this product would be $%cost%.00 USD. To initiate the Out of Warranty Repair RMA program you need to call us at 800-444-2947 and select option 2. In order for us to process your credit card payment, please reference Case#: %case% to expedite processing. For security reasons please do not provide any credit card information within the case.{Enter}{Enter}NOTE: Our Out of Warranty Repair program guarantees that you will receive back a working product. Axis will fully repair, refurbish and clean your product, or where necessary, replace your product with a fully refurbished unit. In either case, the repaired or replaced unit will be covered under our standard RMA for 90 days.%ending%
        Return
    } else{
        MsgBox Not a Supported Input
    } return

Pause & r::
    findCaret()
    Gui, RMAR:New, ,RMA Receipt
    Gui, RMAR:Add, Text, ,RMA Number
    Gui, RMAR:Add, Edit, vRMAnum
    Gui, RMAR:Add, Text, ,RMA Type
    Gui, RMAR:Add, Radio, vRMASt, Standard
    Gui, RMAR:Add, Radio, vRMAAd, Advanced
    Gui, RMAR:Add, Radio, vRMAOOW, Out Of Warranty
    Gui, RMAR:Add, Radio, vRMADOA, Dead On Arrival
    Gui, RMAR:Add, Text, ,Location
    Gui, RMAR:Add, Radio, vCan, Canada
    Gui, RMAR:Add, Radio, vUSA, United States of America
    Gui, RMAR:Add, Radio, vMex, Mexico
    Gui, RMAR:Add, Button, ,Submit
    Gui, RMAR:Show
    Return
    RMARButtonSubmit:
        Gui, RMAR:Submit
        Gui, RMAR:Destroy
    moveclick(x, y, wintitle)
    if (Can && (RMASt || RMAOOW)){
        Send, Your RMA{#} is: %RMAnum%{Enter}{Enter}There is no additional paperwork required, please ensure that you follow all instructions indicated in the initial RMA notification email carefully. Please reference the RMA{#} on the package and send defective unit to:{Enter}{Enter}Axis Communications, Inc.{Enter}90 Burnhamthorpe Rd W{Enter}Suite 1101{Enter}Mississauga, ON  L5B 3C3{Enter}CANADA{Enter}RMA{#}: %RMAnum%{Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
    } else if (Can && (RMAAd || RMADOA)){
        Send, Your RMA{#} is: %RMAnum%{Enter}{Enter}You do not need to accomplish any paperwork which may have been indicated in the initial RMA notification email. Do not ship your defective device to us until you have received the replacement. Please reference the RMA{#} on the package and send defective unit within 20 business days after the receipt of the replacement unit to:{Enter}{Enter}Axis Communications, Inc.{Enter}90 Burnhamthorpe Rd W{Enter}Suite 1101{Enter}Mississauga, ON  L5B 3C3{Enter}CANADA{Enter}RMA{#}: %RMAnum%{Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.}%ending%
    } else if (USA && (RMASt || RMAOOW)){
        Send, Your RMA{#} is: %RMAnum%{Enter}{Enter}There is no additional paperwork required, please ensure that you follow all instructions indicated in the initial RMA notification email carefully. Please reference the RMA{#} on the package and send defective unit to:{Enter}{Enter}Axis Communications, Inc.{Enter}c/o Scanfil{Enter}4345 Hamilton Mill Road - Suite 400{Enter}Buford, GA 30518{Enter}UNITED STATES OF AMERICA{Enter}RMA{#}: %RMAnum% {Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
    } else if (USA && (RMAAd || RMADOA)){
        Send, Your RMA{#} is: %RMAnum%{Enter}{Enter}You do not need to accomplish any paperwork which may have been indicated in the initial RMA notification email. Do not ship your defective device to us until you have received the replacement. Please reference the RMA{#} on the package and send defective unit within 20 business days after the receipt of the replacement unit to:{Enter}{Enter}Axis Communications, Inc.{Enter}c/o Scanfil{Enter}4345 Hamilton Mill Road - Suite 400{Enter}Buford, GA 30518{Enter}UNITED STATES OF AMERICA{Enter}RMA{#}: %RMAnum% {Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
    } else if (Mex){
        Send, Advanced RMA No. A-%RMAnum%{Enter}{Enter}We apologize for the inconvenience of having to do an RMA for your Axis product. An open box replacement product will be on its way to you shortly. Once the replacement unit(s) is received, please ship the defective unit(s) to the address listed below:{Enter}{Enter}Mexico, Ciudad Mexico{Enter}Axis Communications{Enter}Av. Insurgentes Sur 1647. Piso 8 - 801{Enter}Col. San José Insurgentes, Del. Benito Juárez{Enter}C. P. 03900{Enter}Ciudad de México, Distrito Federal{Enter}RMA{#}: %RMAnum%{Enter}Teléfono: {+}52 55 5271 2222{Enter}{Enter}Defective units must be returned within 30 days of receipt of the replacement product. Use the original container and packaging (or equivalent), assure adequate packing material is present around components to protect against rubbing and impacts. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
    } Return
;Chat Responses
PrintScreen & 1::
    Send, Hello, my name is %FName% and I will be assisting you with your RMA request. Please give me a moment to review this chat transcript before we begin.
    Return
PrintScreen & 2::
    findCaret()
    MsgBox, 4, information, Do you have the info needed to complete the RMA?,
    moveclick(x, y, wintitle)
    IfMsgBox, Yes
        Send, I have all of the information that I need to create the RMA, I will just take a couple of minutes and I will have an RMA number for you.
    IfMsgBox, No
        Send, Where would you like us to ship the camera once it is repaired or replaced, can I also get a good contact number for you?
        Return
PrintScreen & 3::
    findCaret()
    InputBox, RMAnum, RMA Number, Input RMA number,
    moveclick(x, y, wintitle)
    Send, Your RMA{#} is %RMAnum%. There will be a detailed email to follow. Is there anything else that I can assist you with today?
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
    findCaret()
    Gui, ISR:New, ,Issue Responses
    Gui, ISR:Add, text, ,What Is the Issue
    Gui, ISR:Add, Radio, vSD, Shipment Delay
    Gui, ISR:Add, Radio, vUC, Unit Not Checked In
    Gui, ISR:Add, Radio, vSI, RMA Stock Issue
    Gui, ISR:Add, Radio, vRP, Replacement Product
    Gui, ISR:Add, Radio, vBR, Bad RMA
    Gui, ISR:Add, Button, , Submit
    Gui, ISR:Show
    Return
    ISRButtonSubmit:
        Gui, ISR:Submit
        Gui, ISR:Destroy
    if (SD) {
        moveclick(x, y, wintitle)
        Send, I apologize that the camera(s) have not shipped yet. It seems our RMA facility is experiencing some delays and the system has slowed down considerably. They are listed in the outgoing state, but I cannot see that a UPS label has been created as of yet. I will reach out to my RMA coordinator to see if there is anything they can do to expedite this.%ending%
    } else if (UC){
        moveclick(x, y, wintitle)
        Send, I apologize that the camera(s) have not been checked in yet. It seems our RMA facility is experiencing some delays and the system has slowed down considerably. It would be helpful if you could provide a tracking so that I can have the package located and then I will reach out to my RMA coordinator to see if there is anything they can do to expedite this.%ending%
    } else if (SI){
        InputBox, product, Product, What is the product that is out of stock?
        moveclick(x, y, wintitle)
        Send, My RMA Facility has just informed me of a temporary stock issue with %product%. They currently do not have the inventory to advance one out to you, but have already ordered additional units to replenish stock. I will reach out with an update as soon as I am able. Please let me know if there is anything I can do in the meanwhile.{Enter}{Enter}I apologize for any inconvenience this causes.%ending%
    } else if (RP){
        Gui, RPISR:New, ,Replacement Product Info
        Gui, RPISR:Add, Text, ,Input the original product
        Gui, RPISR:Add, Edit, vProduct
        Gui, RPISR:Add, Text, ,Input the replacement product
        Gui, RPISR:Add, Edit, vReplace
        Gui, RPISR:Add, Text, ,Input the lint to the replacement product
        Gui, RPISR:Add, Edit, vRPL
        Gui, RPISR:Add, Text, ,Input the link to the replacement products datasheet
        Gui, RPISR:Add, Edit, vRPDL
        Gui, RPISR:Add, Text, ,Was It an Advanced RMA?
        Gui, RPISR:Add, Checkbox, vADRMA, Advanced RMA
        Gui, RPISR:Add, Button, , Submit
        Gui, RPISR:Show
        Return
        RPISRButtonSubmit:
            Gui, RPISR:Submit
            Gui, RPISR:Destroy
        moveclick(x, y, wintitle)
        if (ADRMA) {
            Send, My RMA Facility has notified me they no longer have stock in the %product%. Since we can not advance you out that model, we can offer a replacement. Please note this is an upgraded model, at no additional cost to you. Below are links to the replacement product, the %replace%. Please let me know if it is an acceptable replacement.{Enter}{Enter}%RPL%{Enter}%RPDL%%ending%
            Return
        } else if (!ADRMA) {
            Send, My RMA Facility has notified me they were unable to repair your %product%. Since it cannot be repaired, we can offer a replacement. Please note this is an upgraded model, at no additional cost to you. Below are links to the replacement product, the %replace%. Please let me know if it is an acceptable replacement.{Enter}{Enter}%RPL%{Enter}%RPDL%%ending%
            Return
        }  
    } else if (BR){
        InputBox, product, Product, Input the product
        moveclick(x, y, wintitle)
        Send, I apologize that you are is still experiencing issues with your %product%. I have requested that a replacement unit to be sent out immediately. I have also asked there be a UPS shipping label be created to bring back the defective unit. This will come in the form of an email from our RMA partner (Scanfil).%ending%
    }else {
        MsgBox, Not a valid input
    } Return

;Functions
findCaret() {
    global
    WinGetActiveTitle, wintitle
    if (A_CaretX = 0 || A_CaretY = 0 || A_CaretX = "" || A_CaretY = "")  {
        Acc_Caret := Acc_ObjectFromWindow(WinExist("ahk_exe Chrome_WidgetWin_1"), OBJID_CARET := 0xFFFFFFF8)
        Caret_Location := Acc_Location(Acc_Caret)
        x := Caret_Location.x
        y := Caret_Location.y     
    } 
    else { 
        x := A_CaretX
        y := A_CaretY
    }
    if (x = 0 || y = 0 || x = "" || y = ""){
        MsgBox, Caret position can not be determined. Beware
    }
    Return
}
moveclick(x, y, wintitle) {
    ;MsgBox, %wintitle%
    WinMaximize, %wintitle%
    Sleep, 1000
    MouseMove, x, y + 10, 0,
    MouseClick, Left
}
