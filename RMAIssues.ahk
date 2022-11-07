#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


RMAIs:
    Gui, ISR:New, ,Issue Responses
    Gui, ISR:Add, text, ,What Is the Issue
    Gui, ISR:Add, Radio, vSD, Shipment Delay
    Gui, ISR:Add, Radio, vUC, Unit Not Checked In
    Gui, ISR:Add, Radio, vSI, RMA Stock Issue
    Gui, ISR:Add, Radio, vRP, Replacement Product
    Gui, ISR:Add, Radio, vBR, Bad RMA
    Gui, ISR:Add, Radio, vPB, PowerBoard Follow Up
    Gui, ISR:Add, Radio, vWATDAM, Water/Surge Damage
    Gui, ISR:Add, Button, , Submit
    Gui, ISR:Show
    Return
    ISRButtonSubmit:
        Gui, ISR:Submit
        Gui, ISR:Destroy
    if (SD) {
        buffer = I apologize that the camera(s) have not shipped yet. It seems our RMA facility is experiencing some delays and the system has slowed down considerably. They are listed in the outgoing state, but I cannot see that a UPS label has been created as of yet. I will reach out to my RMA coordinator to see if there is anything they can do to expedite this.%ending%
        SetToClip(buffer)
    } else if (UC){
        buffer = I apologize that the camera(s) have not been checked in yet. It seems our RMA facility is experiencing some delays and the system has slowed down considerably. It would be helpful if you could provide a tracking so that I can have the package located and then I will reach out to my RMA coordinator to see if there is anything they can do to expedite this.%ending%
        SetToClip(buffer)
    } else if (SI){
        InputBox, product, Product, What is the product that is out of stock?
        buffer = My RMA Facility has just informed me of a temporary stock issue with %product%. They currently do not have the inventory to advance one out to you, but have already ordered additional units to replenish stock. I will reach out with an update as soon as I am able. Please let me know if there is anything I can do in the meanwhile.{Enter}{Enter}I apologize for any inconvenience this causes.%ending%
        SetToClip(buffer)
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
        if (ADRMA) {
            buffer = My RMA Facility has notified me they no longer have stock in the %product%. Since we can not advance you out that model, we can offer a replacement. Please note this is an upgraded model, at no additional cost to you. Below are links to the replacement product, the %replace%. Please let me know if it is an acceptable replacement.{Enter}{Enter}%RPL%{Enter}%RPDL%%ending%
            SetToClip(buffer)
            Return
        } else if (!ADRMA) {
            buffer = My RMA Facility has notified me they were unable to repair your %product%. Since it cannot be repaired, we can offer a replacement. Please note this is an upgraded model, at no additional cost to you. Below are links to the replacement product, the %replace%. Please let me know if it is an acceptable replacement.{Enter}{Enter}%RPL%{Enter}%RPDL%%ending%
            SetToClip(buffer)
            Return
        }  
    } else if (BR){
        InputBox, product, Product, Input the product
        buffer = I apologize that you are is still experiencing issues with your %product%. I have requested that a replacement unit to be sent out immediately. I have also asked there be a UPS shipping label be created to bring back the defective unit. This will come in the form of an email from our RMA partner (Scanfil).%ending%
        SetToClip(buffer)
        Return
    } else if (PB){
        InputBox, cost, Cost, Input the Full Out Of Warranty Cost
        reducedCost := cost - 99
        buffer = Unfortunately, the replacement power board we installed failed to resolve the issue. Upon investigation, it appears the__________ of the camera is what failed. If you would like to repair or replace the remaining components, the cost would be $%reducedCost%.00  USD. This is after the $99.00 USD you had already paid, as the typical cost for this model is $%cost%.00 USD.{Enter}{Enter}Please note that this cost covers anything and everything that had failed. If your original device is beyond repair, we will issue a replacement unit. Whether the unit is repaired or replaced, it will be covered by a 90 Day Warranty to back up our services.{Enter}{Enter}Please let me know how you'd like to proceed.%ending%
        SetToClip(buffer)
        Return
    } else if (WATDAM){
        Gui, WATINFO:New, ,Water/Surge Damage Info 
        Gui, WATINFO:Add, Text, , What is The Product
        Gui, WATINFO:Add, Edit, vWATProduct,
        Gui, WATINFO:Add, Text, , What is The Serial Number
        Gui, WATINFO:Add, Edit, vWATSerial,
        Gui, WATINFO:Add, Text, , What is The Case Number(or RMA Number If it was Advanced)
        Gui, WATINFO:Add, Edit, vWATCase,
        Gui, WATINFO:Add, Text, , What is the cost to repair
        Gui, WATINFO:Add, Edit, vWATCost,
        Gui, WATINFO:Add, Text, ,Was It an Advanced RMA?
        Gui, WATINFO:Add, Checkbox, vADV, Advanced RMA
        Gui, WATINFO:Add, Button, , Submit
        Gui, WATINFO:Show
        Return
        WATINFOButtonSubmit:
            Gui, WATINFO:Submit
            Gui, WATINFO:Destroy
        if (!ADV) {
            buffer = Unfortunately, our repair facility has determined that your %WATProduct% (SN: %WATSerial%) has been damaged due to ELECTRICAL SURGE OR WATER INTRUSION [please see photo(s) within your online case]. This type of damage is not covered under warranty and therefore the warranty on this unit has been voided.{Enter}{Enter}Optionally, we do have an Out of Warranty Repair RMA program. The cost to repair this product would be $%WATCost%.00 USD. To initiate the Out of Warranty Repair RMA program you need to call us at 800-444-2947 and select option 2. In order for us to process your credit card payment, please reference Case#: %WATCase% to expedite processing. For security reasons please do not provide any credit card information within the case.{Enter}{Enter}NOTE: Our Out of Warranty Repair program guarantees that you will receive back a working product. Axis will fully repair, refurbish and clean your product, or where necessary, replace your product with a fully refurbished unit. In either case, the repaired or replaced unit will be covered under the remainder of the original units remaining warranty period.%ending% 
            SetToClip(buffer)
            Return
        } else if (wADV) {
            buffer = Unfortunately, our repair facility has determined that your %WATProduct% (SN: %WATSerial%) has been damaged due to ELECTRICAL SURGE OR WATER INTRUSION [please see photo(s) within your online case]. This type of damage is not covered under warranty and therefore the warranty on this unit has been voided. Since you have already received a replacement unit from us, our RMA Coordinator will be sending you an invoice for the Out of Warranty cost of the unit ($%WATCost%.00 USD). If you wish to deal with this promptly rather than waiting for the invoice, please feel free to call our RMA Coordinator @ 1-800-444-2947, option 2; please reference RMA #%WATCase% to expedite processing.%ending%
            SetToClip(buffer)
            Return
        }
        Return
    }else {
        MsgBox, Not a valid input
    } Return