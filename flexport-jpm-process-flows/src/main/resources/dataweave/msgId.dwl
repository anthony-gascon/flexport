%dw 2.0
output application/json
var sftpfilename =  if(vars.source == "Hongkong") Mule::p('apac.hongkong.sftp.filename')  else 
            		if(vars.source == "China") Mule::p('apac.china.sftp.filename') else if
            		(vars.source == "Singapore") Mule::p('apac.singapore.sftp.filename') else if
            		(vars.source == "CustomerRefund") Mule::p('namea.customer.refund.sftp.filename') 
            		else Mule::p('sftp.filename')
---
{
	"msgId" : sftpfilename  replace  "/" with "" as String ++ vars.sftpPayload.Document.CstmrPmtStsRpt.OrgnlGrpInfAndSts.OrgnlMsgId as String
}