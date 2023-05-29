%dw 2.0
output application/json
---
payload map ((item, index) ->{
    "internalId": item.internalId,
    "customFieldList": {
        "customField": [
            {
        "StringCustomFieldRef__custbody_jpm_ack_psr_error_message" : vars.sftpPayload.Document.CstmrPmtStsRpt.OrgnlGrpInfAndSts.StsRsnInf.Rsn.Cd as String ++ " - " ++ vars.sftpPayload.Document.CstmrPmtStsRpt.OrgnlGrpInfAndSts.StsRsnInf.AddtlInf as String,
        "BooleanCustomFieldRef__custbody_jpm_ack_failed": true
            }
        ]
    }
} )
