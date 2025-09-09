retval=0

if oSession.CompanyCode = "TST" Then

chargeFlag=""
retval = oBusObj.GetValue("UDF_FREIGHT_BILLABLE$", chargeFlag)

freightAmt = 0
retval = oBusObj.GetValue("FREIGHTAMT", freightAmt)

freightCost = 0
retval = oBusObj.GetValue("UDF_FREIGHT_COSTS", freightCost)

if chargeFlag = "" Then
	oScript.SetError("Freight Billable must be Yes or No")
End If

if chargeFlag = "Yes" Then
	if freightAmt = 0 Then
		oScript.SetError("Freight Amount must be greater than 0")
	End If
End If

if chargeFlag = "No" Then
	if freightAmt > 0 Then
		oScript.SetError("Freight Amount must be 0")
	End If
End If

if freightCost=0 Then
	oScript.SetError("Freight Cost is mandatory")
End If

End if
