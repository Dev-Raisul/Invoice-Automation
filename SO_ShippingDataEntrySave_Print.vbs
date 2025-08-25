set oPVX = CreateObject("ProvideX.Script")
oPVX.Init("C:\Sage\Sagev2023\MAS90\Home")
set oSS = oPVX.NewObject("SY_Session")


retVal = oSS.nSetUser("Raisul","")
retVal = oSS.nSetCompany("RAI")
retVal = oSS.nSetDate("S/O","20230620")
retVal = oSS.nSetModule("S/O")  

retVal = oSS.ologon()

Set oUI = oPVX.NewObject("SO_Shipping_ui", oSS)
Set oBusObj = oUI.oBusObj

orderNo = ""
retVal = oBusObj.GetValue("SalesOrderNo$", orderNo)
MsgBox("Current Sales Order No :"  & orderNo)
retVal = oBusObj.Write()

If retVal = 1 Then
	MsgBox("Shipping Data Entry saved successfully!")

secOBj = oSS.nSetProgram(oSS.nLookupTask("SO_InvoicePrinting_ui"))
set oRpt = oPVX.NewObject("SO_InvoicePrinting_rpt", oSS)


retVal = oRpt.nSelectReportSetting("STANDARD")
retVal = oRpt.nSetKeyValue("ModuleCode$", oSS.sModuleCode)
retVal = oRpt.nSetKeyValue("CompanyKey$", oSS.sCompanyKey)
retVal = oRpt.nSetKeyValue("ReportID$", "SO_INVOICEPRINTING_UI")
retVal = oRpt.nSetKeyValue("ReportSetting$", "STANDARD")
retVal = oRpt.nSetKeyValue("RowKey$", "00001")
retVal = oRpt.nSetKey()

retVal = oRpt.nSetValue("SelectField$", "Order Number")
retVal = oRpt.nSetValue("SelectFieldValue$", "Order Number")
retVal = oRpt.nSetValue("Tag$", "TABLE=SO_SALESORDERHEADER; COLUMN=SALESORDERNO$")
retVal = oRpt.nSetValue("Operand$", "=")
retVal = oRpt.nSetValue("Value1$", orderNo)
retVal = oRpt.nWrite()

oRpt.nReportType = 6
retval = oRpt.nInitReportEngine()
retVal = oRpt.nSetExportOptions(5, "\\CUSTOMDEV1\Sage\Sagev2023\Paperless\ShippingPrint_" & orderNo & ".pdf")
MsgBox(oRpt.sLastErrorMsg)
retVal = oRpt.nProcessReport("EXPORT")
MsgBox(oRpt.sLastErrorMsg)

oSS.nCleanup()
oSS.DropObject()

set oSS = Nothing
set oPVX = Nothing
