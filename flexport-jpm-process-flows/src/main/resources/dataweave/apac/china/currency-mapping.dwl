%dw 2.0
output application/json
import java!org::apache::commons::lang3::StringUtils
import * from dw::core::Arrays
var currencies = readUrl('classpath://data\currency.json')
var sym = readUrl('classpath://data\europeanAccentCharacters.json')

var currency = (currencies map  {($.ID) : $.Code} ) 
fun replaceEuroChar(entityId) = StringUtils::stripAccents(entityId) splitBy  ""
fun  mapping (item) = if(sym.k contains item) sym.v[indexOf(sym.k ,item)] else item
fun vendorName (data) = (data map ((item, index) -> mapping(item) )) reduce ((item, accumulator) -> accumulator ++ item )
---
payload map ((item, index) -> {
   basic : {
       currency : currency[item.basic.currency[0].searchValue.internalId][0],
       memo : item.basic.memo[0].searchValue,
       tranDate : item.basic.tranDate[0].searchValue,
       entity : item.basic.entity[0].searchValue.internalId,
       internalId : item.basic.internalId[0].searchValue.internalId,
       tranId : item.basic.tranId[0].searchValue,
       amount: if((item.paidTransactionJoin == null)) abs(item.basic.fxAmount[0].searchValue) else abs(item.basic.paidAmount[0].searchValue),
       account : item.basic.account[0].searchValue.internalId,
       transactionNumber : item.basic.transactionNumber[0].searchValue,
       ('type' : if (item.basic.'type'[0].searchValue == "_vendorCredit")
    	           "CREN"
    	       else 
    	          "CINV") ,
       ({(item.basic.customFieldList.customField map ((item, index) -> 
       	((item.scriptId) : item.searchValue.internalId) if(item.scriptId == "custbody_jpm_check_delivery_code")
       ))})}
,
   vendorJoin : {
    billState : item.vendorJoin.billState[0].searchValue,
    billAddress1 : item.vendorJoin.billAddress1[0].searchValue,
    billZipCode : item.vendorJoin.billZipCode[0].searchValue,
    billCountry : item.vendorJoin.billCountry[0].searchValue,
    billCountryCode : item.vendorJoin.billCountryCode[0].searchValue,
    ({(item.vendorJoin.customFieldList.customField map ((item, index) -> (item.scriptId) : item.searchValue))}),

    billAddress: item.vendorJoin.billAddress[0].searchValue,
    billCity : item.vendorJoin.billCity[0].searchValue,
    entityId : vendorName(replaceEuroChar(item.vendorJoin.entityId[0].searchValue))
   },

   vendorLineJoin : { 
       entityId : vendorName(replaceEuroChar(item.vendorJoin.entityId[0].searchValue))
       },
   
    customSearchJoin : {
        
        customFieldList :{
            (item.customSearchJoin.searchRowBasic[0].customFieldList.customField map ((item, index) -> (item.scriptId) : item.searchValue))
        }
    },
    
    (paidTransactionJoin :{
    	
    	
    	
    	  memo :  item.paidTransactionJoin.memo[0].searchValue,    
    	  tranId : item.paidTransactionJoin.tranId[0].searchValue,
    	  tranDate : item.paidTransactionJoin.tranDate[0].searchValue,
    	  paidAmount : item.basic.paidAmount[0].searchValue,
    	  currency :  currency[item.paidTransactionJoin.currency[0].searchValue.internalId][0]
    	  
    } ) if(item.paidTransactionJoin != null) 
   

   
}
 )
