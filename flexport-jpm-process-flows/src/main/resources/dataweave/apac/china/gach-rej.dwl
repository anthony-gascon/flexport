%dw 2.0
output application/json skipNullOn="everywhere"
---
payload map ((item, index) ->{
    "internalId": item.OrgnlInstrId,
    "customFieldList": {
        "customField": [
            {
        "StringCustomFieldRef__custbody_jpm_ack_psr_error_message" : item.OrgnlPmtInfAndSts.OrgnlPmtInfId,
        ("BooleanCustomFieldRef__custbodysvbexport" : false ) 
            }
        ]
    }
})