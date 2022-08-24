#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ending = {Enter}{Enter}Thank you for choosing Axis Communications as your IP Video Surveillance partner{!}{Enter}{Enter}Warm regards, {Enter}%FName%{Enter}%Title%{Enter}Axis Communications{Enter}Phone: 1-800-444-2947, option 2{Enter}Online Chat: http://www.axis.com/reg/chat.php

RMAIn:
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
        buffer = Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the Standard RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}Once I get that information I will create an RMA for the defective unit.{Enter}NOTE: Standard RMA is free of charge, but can take 7-10 business days to complete once the unit is received at our repair facility. You would send us the device; we would test to verify the failure. If we can repair it we will, but if it is not repairable we will send you a replacement unit.%ending%
        SetToClip(buffer)
        Return
    }else if (RMAAd & partner){
        buffer = Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the Advance Replacement RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}Once I get that information I can create an RMA for the defective unit.{Enter}{Enter}NOTE: With the Advanced Replacement program, a replacement device would be sent to you via UPS ground within the next few days. We ask that you return the defective camera within 20 business days of receipt of the replacement unit.%ending%
        SetToClip(buffer)
        Return
    }else if (RMAAd & !partner){
        InputBox, MSRP, MSRP, What is the MSRP?,
        buffer = Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the Advanced RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}For our Advanced Replacement RMA program, a replacement device would be sent to you via UPS ground only after receiving the Advanced Replacement Authorization form via fax. A link to the Advanced Replacement Authorization form would be sent to you via an automated email once the Advanced Replacement has been processed by Axis Technical Support.{Enter}{Enter}Some important notes about the Advanced Replacement: A $30 service fee plus a $20 per camera fee will be charged to the credit card provided on the Advanced Replacement Authorization form.  A hold would be placed on the CC for the MSRP of the camera ($%MSRP%.00 USD), this hold is released after our repair facility has received the defective unit.  A replacement camera would be shipped within 24 to 48 hours after receiving the form. We ask that you return the defective camera within 20 business days of receipt of the replacement unit.%ending%
        SetToClip(buffer)
        Return
    } else if (RMADOA & partner){
        buffer = Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the 30-Day Replacement RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}Once I get that information I can create an RMA for the defective camera.{Enter}{Enter}NOTE: For a 30-Day Replacement RMA we will overnight ship a new unit to you if it is within 30 days of purchase. A replacement unit will be shipped within the next business day and it will come with a UPS Return Shipment Label for the defective. We ask that you return the defective unit within 20 business days of receipt of the replacement unit.%ending%
        SetToClip(buffer)
        Return
    } else if (RMADOA & !partner){
        InputBox, MSRP, MSRP, What is the MSRP?,
        buffer = Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the 30-Day Replacement RMA process I will need to know a couple of things. Once I get this information I can create an RMA for the defective unit.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}3. Which 30-Day Replacement RMA Option you prefer as detailed below{Enter}{Enter}Option 1 (30-Day Replacement RMA with Credit Card Hold):{Enter}For this option, we will ship a new unit only after receiving the DOA (Cross Shipment) form via fax, a link to the Cross Shipment form would be sent to you via an automated email. A hold would be placed on the CC for the MSRP of the unit ($%MSRP%.00 USD), this hold is released after our repair facility has received the defective unit. A new replacement unit would be shipped within 24 to 48 hours after receiving the form. We ask that you return the defective camera within 20 business days of receipt of the replacement unit.{Enter}{Enter}Option 2 (30-Day Replacement RMA without Credit Card Hold):{Enter}For this option, we will ship a new unit within 24 to 48 hours ONLY after receiving the defective unit at our repair facility.%ending%
        SetToClip(buffer)
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
        buffer =  Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Unfortunately, our system shows that the warranty on your %product% (SN: %serial%) has expired. If you feel this is in error, please provide a dated billing or shipping receipt as proof of purchase in order to show that this unit is still within its original warranty period of: %year% year(s).{Enter}{Enter}Optionally, we do have an Out of Warranty Repair RMA program. The cost to repair this product would be $%cost%.00 USD. To initiate the Out of Warranty Repair RMA program you need to call us at 800-444-2947 and select option 2. In order for us to process your credit card payment, please reference Case#: %case% to expedite processing. For security reasons please do not provide any credit card information within the case.{Enter}{Enter}NOTE: Our Out of Warranty Repair program guarantees that you will receive back a working product. Axis will fully repair, refurbish and clean your product, or where necessary, replace your product with a fully refurbished unit. In either case, the repaired or replaced unit will be covered under our standard RMA for 90 days.%ending%
        SetToClip(buffer)
        Return
    } else{
        MsgBox Not a Supported Input
    } return