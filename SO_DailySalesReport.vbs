set oPVX = CreateObject("ProvideX.Script")
oPVX.Init("C:\Sage\Sagev2023\MAS90\Home")
set oSS = oPVX.NewObject("SY_Session")

retVal = oSS.nSetUser("Raisul","")
retVal = oSS.nSetCompany("RAI")
retVal = oSS.nSetDate("S/O","20230620")
retVal = oSS.nSetModule("S/O")  

retVal = oSS.ologon()

secOBj = oSS.nSetProgram(oSS.nLookupTask("SO_Invoice_ui"))
Set oInvoice = oPVX.NewObject("SO_Invoice_bus", oSS)

Set dictBatches = CreateObject("Scripting.Dictionary")

retVal = oInvoice.nMoveFirst()
Do Until CBool(oInvoice.nEOF)
    batchNo = ""
    retVal2 = oInvoice.nGetValue("BatchNo$", batchNo)

    If retVal2 = 1 Then
        If Not dictBatches.Exists(batchNo) Then
            dictBatches.Add batchNo, True
        End If
    End If
	
    retVal = oInvoice.nMoveNext()
Loop

secOBj = oSS.nSetProgram(oSS.nLookupTask("SO_SalesJournal_ui"))
set oRpt = oPVX.NewObject("SO_SalesJournal_upd", oSS)

For Each batchNo In dictBatches.Keys
    retVal = oRpt.nSelectBatch(batchNo)
	if retVal < 1 Then
		retVal = oRpt.nCloseBatch(batchNo)
	End if
Next

retVal = oRpt.nSetPostingDate("20230620")
oRpt.nPDFSilent = 1
retVal = oRpt.nProcessReport("PRINT")
retVal = oRpt.nEndOfPDFConverterJob()
retVal = oRpt.nUpdate()	

oSS.nCleanup()
oSS.DropObject()

set oSS = Nothing
set oPVX = Nothing
