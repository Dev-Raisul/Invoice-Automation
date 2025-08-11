retval=0
chargeFlag=""
retval = oBusObj.GetValue("UDF_FREIGHT_BILLABLE$", chargeFlag)

freightAmt = 0
retval = oBusObj.GetValue("FREIGHTAMT", freightAmt)

freightCost = 0
retval = oBusObj.GetValue("UDF_FREIGHT_COSTS", freightCost)


if chargeFlag = "Y" Then
	if freightAmt = 0 Then
		oScript.SetError("Freight Amount must be greater than 0")
	End If
End If

if chargeFlag = "N" Then
	if freightAmt > 0 Then
		oScript.SetError("Freight Amount must be 0")
	End If
End If

if freightCost=0 Then
	oScript.SetError("Freight Cost is mandatory")
End If
