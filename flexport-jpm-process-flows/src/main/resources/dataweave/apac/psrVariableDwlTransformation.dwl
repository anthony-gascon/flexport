%dw 2.0
output application/json skipNullOn="everywhere"
---
payload map ((item, index) ->{
    "internalId": item.OrgnlInstrId,
    "customFieldList": {
        "customField": [
            {
        "StringCustomFieldRef__custbody_jpm_ack_psr_error_message" : if(item.TxSts=="RJCT") (item.StsRsnInf.Rsn.Cd ++ "-" ++ item.StsRsnInf.AddtlInf) else (null),
        ("BooleanCustomFieldRef__custbody_jpm_psr_failed":  true ) if(item.TxSts=="RJCT"),
        ("BooleanCustomFieldRef__custbodysvbexport" : true ) if(item.TxSts =="ACSP"),
        "StringCustomFieldRef__custbody_jpm_paid_currency": item.OrgnlTxRef.Amt.InstdAmt.'@Ccy' default "",
        "StringCustomFieldRef__custbody_jpm_paid_amount": item.OrgnlTxRef.Amt.InstdAmt.'__text' default ""
            }
        ]
    }
})