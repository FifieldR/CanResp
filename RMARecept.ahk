#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

RMARe:
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
    Gui, RMAR:Add, Text, , Are They A Partner
    Gui, RMAR:Add, Checkbox, vPartner, Partner
    Gui, RMAR:Add, Button, ,Submit
    Gui, RMAR:Show
    Return
    RMARButtonSubmit:
        Gui, RMAR:Submit
        Gui, RMAR:Destroy
    if (Can && (RMASt || RMAOOW)){
        buffer = Your RMA{#} is: %RMAnum%{Enter}{Enter}There is no additional paperwork required, please ensure that you follow all instructions indicated in the initial RMA notification email carefully. Please reference the RMA{#} on the package and send defective unit to: %canLoc%RMA{#}: %RMAnum%{Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
        SetToClip(buffer)
    } else if (Can && (RMAAd || RMADOA)){
        buffer = Your RMA{#} is: %RMAnum%{Enter}{Enter}You do not need to accomplish any paperwork which may have been indicated in the initial RMA notification email. Do not ship your defective device to us until you have received the replacement. Please reference the RMA{#} on the package and send defective unit within 20 business days after the receipt of the replacement unit to: %canLoc%{Enter}RMA{#}: %RMAnum%{Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
        SetToClip(buffer)
    } else if (USA && (RMASt || RMAOOW)){
        buffer = Your RMA{#} is: %RMAnum%{Enter}{Enter}There is no additional paperwork required, please ensure that you follow all instructions indicated in the initial RMA notification email carefully. Please reference the RMA{#} on the package and send defective unit to: %usaLoc%RMA{#}: %RMAnum% {Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
        SetToClip(buffer)
    } else if (USA && (RMAAd || RMADOA)){
        buffer = Your RMA{#} is: %RMAnum%{Enter}{Enter}You do not need to accomplish any paperwork which may have been indicated in the initial RMA notification email. Do not ship your defective device to us until you have received the replacement. Please reference the RMA{#} on the package and send defective unit within 20 business days after the receipt of the replacement unit to: %usaLoc%RMA{#}: %RMAnum% {Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
        SetToClip(buffer)
    } else if (Mex){
        buffer = Advanced RMA No. A-%RMAnum%{Enter}{Enter}We apologize for the inconvenience of having to do an RMA for your Axis product. An open box replacement product will be on its way to you shortly. Once the replacement unit(s) is received, please ship the defective unit(s) to the address listed below: %mexLoc%RMA{#}: %RMAnum%{Enter}Teléfono: {+}52 55 5271 2222{Enter}{Enter}Defective units must be returned within 30 days of receipt of the replacement product. Use the original container and packaging (or equivalent), assure adequate packing material is present around components to protect against rubbing and impacts. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}{Enter}NOTE:{Enter}1. Do NOT put any of these accessories inside the shipping box unless advised otherwise:{Enter}- Power supplies{Enter}- Removable Batteries from Axis Installation Displays (i.e.: T8412, T8414, T8415){Enter}- Network or printer cables{Enter}- Camera stands{Enter}- SD Cards{Enter}- Modules (if not the defective part){Enter}- Card Readers (if not the defective part){Enter}- Back boxes{Enter}- Frames{Enter}- Additional boards{Enter}- Cables (if not the defective part){Enter}- Backplates{Enter}{Enter}2. For Standard and Out of Warranty RMAs: If product is not received within 30 days, this RMA will close.{Enter}3. Disassembly or opening the product itself can result in voided warranty.{Enter}4. Our RMA facility will return your repaired or replacement product in the original factory defaulted state.%ending%
        SetToClip(buffer)
    } Return