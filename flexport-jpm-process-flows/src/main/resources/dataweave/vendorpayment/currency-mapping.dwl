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
       currency : currency[(item.basic.currency.searchValue."@internalId" as Number)][0],
       memo : item.basic.memo.searchValue,
       tranDate : item.basic.tranDate.searchValue,
       entity : item.basic.entity.searchValue."@internalId",
       internalId : item.basic.internalId.searchValue."@internalId",
       tranId : item.basic.tranId.searchValue,
       amount: if((item.paidTransactionJoin == null)) abs(item.basic.fxAmount.searchValue) else abs(item.basic.paidAmount.searchValue),
       account : item.basic.account.searchValue."@internalId",
       transactionNumber : item.basic.transactionNumber.searchValue,
       ('type' : if (item.basic.'type'.searchValue == "_vendorCredit")
    	           "CREN"
    	       else 
    	          "CINV"),
       ({(item.basic.customFieldList mapObject ((item, index) -> 
       	((item."@scriptId") : item.searchValue."@internalId") if(item."@scriptId" == "custbody_jpm_check_delivery_code")
       ))})
    },
    vendorJoin: {
        billState : item.vendorJoin.billState.searchValue,
        billAddress1 : item.vendorJoin.billAddress1.searchValue,
        billZipCode : item.vendorJoin.billZipCode.searchValue,
        billCountry : item.vendorJoin.billCountry.searchValue,
        billCountryCode : item.vendorJoin.billCountryCode.searchValue,
        ({(item.vendorJoin.customFieldList mapObject ((item, index) -> (item."@scriptId") : if(typeOf(item.searchValue) as String == "Object" ) {
            "internalId": item.searchValue."@internalId",
            "typeId": item.searchValue."@typeId"
        } else item.searchValue ))}),
        billAddress: item.vendorJoin.billAddress.searchValue,
        billCity : item.vendorJoin.billCity.searchValue,
        entityId : vendorName(replaceEuroChar(item.vendorJoin.entityId.searchValue))
    },

    vendorLineJoin : { 
        entityId : vendorName(replaceEuroChar(item.vendorJoin.entityId.searchValue))
    },
    customSearchJoin : {
        
        customFieldList :{
            (item.customSearchJoin.searchRowBasic.customFieldList mapObject ((item, index) -> (item."@scriptId") : item.searchValue))
        }
    },
    (paidTransactionJoin :{
    	  memo :  item.paidTransactionJoin.memo.searchValue,    
    	  tranId : item.paidTransactionJoin.tranId.searchValue,
    	  tranDate : item.paidTransactionJoin.tranDate.searchValue,
          paidAmount : item.basic.paidAmount.searchValue,
          currency: currency[item.paidTransactionJoin.currency.searchValue."@internalId" as Number][0]
    } ) if(item.paidTransactionJoin != null) 

}
 )
