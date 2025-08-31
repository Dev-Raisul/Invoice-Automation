orderCurr=""
arDivision=""
custNo=""
salesPerson=""
custCurr=""
salesCurr=""
exchRate=""


Set oUI = oSession.AsObject(oSession.UI)

' Get the current order currency
retVal = oBusObj.GetValue("UDF_CURRENCY$", orderCurr)
retVal = oBusObj.GetValue("ARDivisionNo$",arDivision)
retVal = oBusObj.GetValue("CustomerNo$", custNo)
retVal = oBusObj.GetValue("SalespersonNo$", salesPerson)

' === 1. Check against Customer Default Currency ===
Dim oCustomer
Set oCustomer = oSession.AsObject(oSession.GetObject("AR_Customer_bus"))

retVal = oCustomer.SetKeyValue("ARDivisionNo$", arDivision)
retVal = oCustomer.SetKeyValue("CustomerNo$", custNo)
retVal = oCustomer.SetKey()

If retVal = 1 Then
	custCurr = ""
	retVal = oCustomer.GetValue("UDF_CURRENCY$", custCurr)
	If orderCurr <> "" And custCurr <> "" And orderCurr <> custCurr Then
		oUI.MessageBox("WARNING: Order currency (" & orderCurr & _
					") differs from Customer default currency (" & custCurr & ").")
	End If
End If
Set oCustomer = Nothing

' === 2. Check against Salesperson Default Currency (if stored in a UDF) ===
Dim oSales
Set oSales = oSession.AsObject(oSession.GetObject("AR_Salesperson_bus"))

retVal = oSales.SetKeyValue("SalespersonDivisionNo$", arDivision)
retVal = oSales.SetKeyValue("SalespersonNo$", salesPerson)
retVal = oSales.SetKey()

If retVal = 1 Then
	salesCurr = ""
	retVal = oSales.GetValue("UDF_CURRENCY$", salesCurr)   ' Assume UDF
	If orderCurr <> "" And salesCurr <> "" And orderCurr <> salesCurr Then
		oUI.MessageBox("WARNING: Order currency (" & orderCurr & _
					") differs from Salesperson default currency (" & salesCurr & ").")
	End If
End If
Set oSales = Nothing

' === 3. Pull exchange rate from UDT ===
Dim oUDT
Set oUDT = oSession.AsObject(oSession.GetObject("CM_UDTMaint_bus","AR_UDT_CURRENCYEXCHANGE"))

retVal = oUDT.SetKeyValue("UDF_CURRENCY$", orderCurr)
retVal = oUDT.SetKey()

If retVal = 1 Then
	exchRate = 0
	retVal = oUDT.GetValue("UDF_EXCHANGE_RATE", exchRate)
	If exchRate <> 0 Then
		retVal = oBusObj.SetValue("UDF_EXCHANGE_RATE", exchRate)
		oUI.MessageBox("Exchange Rate for " & orderCurr & " set to " & exchRate)
	End If
End If
Set oUDT = Nothing
