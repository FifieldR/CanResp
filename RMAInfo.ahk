#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ending = {Enter}{Enter}Thank you for choosing Axis Communications as your IP Video Surveillance partner{!}{Enter}{Enter}Warm regards, {Enter}%FName%{Enter}%Title%{Enter}Axis Communications{Enter}Phone: 1-800-444-2947, option 2{Enter}Online Chat: http://www.axis.com/reg/chat.php{Enter}{Enter}

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
    Gui, RIR:Add, Radio, vSUSWat, Suspected Water or Surge
    Gui, RIR:Add, Radio, vQ60Pow, Q60 Powerboard
    Gui, RIR:Add, Radio, vP56Pow, P5624/35/E Powerboard
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
    } else if (SUSWat){
        buffer = Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Your %product% (SN: %serial%) is well within its warranty period. If you would like to start the Standard RMA process I will need to know a couple of things.{Enter}{Enter}1. The full shipping address{Enter}2. A contact phone number{Enter}{Enter}Once I get that information I will create an RMA for the defective unit.{Enter}NOTE: Standard RMA is free of charge, but can take 7-10 business days to complete once the unit is received at our repair facility. You would send us the device; we would test to verify the failure.{Enter}{Enter} Unfortunately, if our repair facility has determined that your %product% has been damaged due to ELECTRICAL SURGE OR WATER INTRUSION , this type of damage is not covered under warranty and therefore the warranty on this unit will be voided. To better assist please provide {Enter}{Enter}1. How long was this camera operational before this issue occurred?{Enter}2. Was this camera installed indoors or outdoors?{Enter}3. Can you upload a picture of the ethernet cabling used to connect this camera to the POE switch?{Enter}4. Can you upload a picture of the RJ-45 connector used to terminate this cameras ethernet cable?{Enter}5. Were there any electrical/lightning storms in the area lately?{Enter}6. Were there any power surges/outages in the area lately?{Enter}This will help determine if the manufactures installation instructions have been followed or if the %product% is a defect in manufacturing.%ending%
        SetToClip(buffer)
        return
        } else if (Q60Pow){
        Gui, Q60Info:New , ,Out of Warranty Info
        Gui, Q60Info:Add, Text, , How long was the warranty
        Gui, Q60Info:Add, Edit, vYear,
        Gui, Q60Info:Add, Button, , Submit
        Gui, Q60Info:Show
        Return
        Q60InfoButtonSubmit:
            Gui, Q60Info:Submit
            Gui, Q60Info:Destroy
        buffer = Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Unfortunately, our system shows that the warranty on your %product% (SN: %serial%) has expired. If you feel this is in error, please provide a dated billing or shipping receipt as proof of purchase in order to show that this unit is still within its original warranty period of: %year% year(s).{Enter}{Enter}If you have a Q60xx camera (indoor or outdoor version) that is out of warranty and will no longer power up, we can now attempt repair by replacing the power board at reduced cost. This reduced repair cost is only valid for cameras that will not power up.{Enter}{Enter}For any Q604x or Q605x series cameras, Axis Communications offers other repair or replacement options for cameras that have issues not associated with power problems. Unfortunately, there are no other repair or upgrade options for the Q603x series cameras.{Enter}{Enter}All cameras that are within warranty will follow the normal RMA process listed on our website:{Enter}https://www.axis.com/global/en/support/warranty-and-rma{Enter}{Enter}Here’s how we would proceed:{Enter}{Enter}• You will identify the issue is that the “camera doesn’t power up”. We would suggest to physically inspect the camera and make sure no lights come on the camera with a known good power source and cable.{Enter}{Enter}• We can attempt to repair by replacing the power board on the camera for a cost of $99 USD per board. Cost will be refunded if the power board replacement does not resolve the issue, there are no other upgrade options available.{Enter}{Enter}• We will need a credit card at the time of the call to process the RMA.{Enter}{Enter}• If power board replacement is successful, the camera will be returned to you via ups ground with a 90 warranty on repaired parts.{Enter}{Enter}• If the repair is unsuccessful you will be given a full refund for the $99 USD repair cost and the option to have Axis recycle or have the camera returned to you. Please call 1-800-444-2947 option 2 to proceed.%ending%
        SetToClip(buffer)
        return
        } else if (P56Pow){
        Gui, P56Info:New , ,Out of Warranty Info
        Gui, P56Info:Add, Text, , How long was the warranty
        Gui, P56Info:Add, Edit, vYear,
        Gui, P56Info:Add, Button, , Submit
        Gui, P56Info:Show
        Return
        P56InfoButtonSubmit:
            Gui, P56Info:Submit
            Gui, P56Info:Destroy
        buffer = Thank you for contacting Axis Communications. My name is %FName% and I will be assisting you with this case.{Enter}{Enter}Unfortunately, our system shows that the warranty on your %product% (SN: %serial%) has expired. If you feel this is in error, please provide a dated billing or shipping receipt as proof of purchase in order to show that this unit is still within its original warranty period of: %year% year(s).{Enter}{Enter}If you have a P5624-E/ P5624-E MkII or P5635-E/ P5635-E MkII series camera that is out of warranty and will no longer power up, we can now attempt repair by replacing the power board at a reduced cost. This reduced repair cost is only valid for cameras that will not power up.{Enter}{Enter}For any P5635-E  or P5635-E MkII series cameras, Axis Communications offers other repair or replacement options for cameras that have issues not associated with power problems. All cameras that are within warranty will follow the normal RMA process listed on our website: https://www.axis.com/global/en/support/warranty-and-rma{Enter}{Enter}Here’s how we would proceed:{Enter}{Enter}• You will identify the issue is that the “camera doesn’t power up”. We would suggest to physically inspect the camera and make sure no lights come on the camera with a known good power source and cable.{Enter}{Enter}• We can attempt to repair by replacing the power board on the camera for a cost of $99 USD per board. Cost will be refunded if the power board replacement does not resolve the issue, there are no other upgrade options available.{Enter}{Enter}• We will need a credit card at the time of the call to process the RMA.{Enter}{Enter}• If power board replacement is successful, the camera will be returned to you via ups ground with a 90 warranty on repaired parts.{Enter}{Enter}• If the repair is unsuccessful you will be given a full refund for the $99 USD repair cost and the option to have Axis recycle or have the camera returned to you. Please call 1-800-444-2947 option 2 to proceed.%ending%
        SetToClip(buffer)
        return
    } else{
        MsgBox Not a Supported Input
    } return