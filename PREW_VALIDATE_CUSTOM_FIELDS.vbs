retval = 0

chargeFlag = ""
retval = oBusObj.GetValue("UDF_FREIGHT_BILLABLE$", chargeFlag)  

currencyCode = ""
retval = oBusObj.GetValue("UDF_CURRENCY", currencyCode)       

exchangeRate = 0
retval = oBusObj.GetValue("UDF_EXCHANGE_RATE", exchangeRate)   

If Trim(chargeFlag) = "" Then
    oScript.SetError("Charge Freight to Customer must be selected (Y or N).")
End If

If Trim(currencyCode) = "" Then
    oScript.SetError("Currency must be selected.")
End If

If exchangeRate = 0 Then
    oScript.SetError("Currency Exchange Rate must be entered.")
End If

If UCase(Trim(currencyCode)) = "CAD" Then
    If Abs(exchangeRate - 1) < 0.0001 Then
        oScript.SetError("If Currency is CAD, Exchange Rate must not be 1.000.")
    End If
End If
