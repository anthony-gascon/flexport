%dw 2.0
import * from dw::core::Strings
var data = (payload map (value ) ->   if((value[0] ~= "16" or value[0] ~= "88" )) value else null) filter (value, index) -> (value != null)
var index = (data map (indx : $$) if ($.column_0 == "16")).indx
var comboresult = index map {(data[$ to ((index[($$ + 1)]) -1)] default data[$ to -1])}
var headerdata = (payload map (value ) ->   if((value[0] ~= "03")) value else null) filter (value, index) -> (value != null)

fun getAmount(item) = (if (((item."column_2" as String ) [-1 to -2])  == "00" as String) 
((item."column_2" / 100)) as String {format: "#.00"}
else 
if (((item."column_2" as String ) [-1])  == "0" as String) 
((item."column_2" / 100)) as String {format: "#.00"}
else ((item."column_2") / 100) ) as Number
fun getYourRef(item) = ((item filterObject ((value) -> value contains "YOUR REF" ))."column_1")  replace "YOUR REF=" with("") default ""
fun getfxch(item) = (substringAfter(((valuesOf( ((item) filterObject ((value) -> value != "88"))) reduce ($$ ++ $)) replace " " with("")),"FXEXCH=")) replace  /[^(0-9).]/ with "" default ""
var curdate = now()  as String {format: "MM/dd/yyyy"}
output application/json 
---
comboresult map ((item) ->

    {
        "customFieldList": {
            "customField": [
                {
                    "DoubleCustomFieldRef__custrecord_jpm_paid_amount":  getAmount(item),
                    "StringCustomFieldRef__custrecord_jpm_fx_rate":  getfxch(item) withMaxSize 6,  
                    "StringCustomFieldRef__custrecord_jpm_tran_ref_num":  if(getYourRef(item) == "") curdate else getYourRef(item),
					"StringCustomFieldRef__custrecord_jpm_bank_account_number":  headerdata."column_1"[0],
					"StringCustomFieldRef__custrecord_jpm_bank_currency":headerdata."column_2"[0]
                }
            ]
        }
    }

)
