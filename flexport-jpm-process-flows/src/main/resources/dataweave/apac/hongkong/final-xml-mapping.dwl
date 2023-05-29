%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
output application/xml
var currencies = readUrl('classpath://data\currency.json')
var currency = (currencies map  {
	($.ID) : $.Code
})
var deliveryCodes = readUrl('classpath://data\deliveryCode.json')
var initialValue = 0
fun sumOfTrx() = do {
	var totalTrx = sum(payload map ((item, index) -> 
    if ( item.paidTransactionJoin == null ) sizeOf(item)  else if ( item.basic.'type' contains "CREN" ) sizeOf( groupCheck(item) ) else sizeOf(item.basic.internalId distinctBy ((item, index) -> item ) ) ))
	---
	totalTrx
}
fun groupCheck(data) = do{
	var intId = (((data groupBy ((item, index) -> item.paidTransactionJoin.tranId)) pluck ((value, key, index) -> value))..internalId) distinctBy ((item, index) -> item )
	var grpId =  ((data groupBy ((item, index) -> item.paidTransactionJoin.tranId)) pluck ((value, key, index) -> value))
	var removeCrenId = (intId --(data filter ((item, index) -> item.basic."type" == "CREN" )).basic.internalId)
	---
	(removeCrenId map ((value, index) ->  
                     flatten (grpId filter ((item, index) -> (item..basic.internalId contains  value) ))
                     )) - []
}
---
 Document @(xmlns: "urn:iso:std:iso:20022:tech:xsd:pain.001.001.03" , "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance" ) : {
   
     CstmrCdtTrfInitn :({
         GrpHdr :{
             MsgId : vars.uuid, 
             CreDtTm : now() as DateTime as String {format : "yyyy-MM-dd'T'HH:mm:ss"},
             NbOfTxs: sumOfTrx(),
             CtrlSum : sum(payload..amount),
             InitgPty :{
                 Nm : "Flexport Inc"
             }
         },
         (  payload map ((item, index) -> 
           
            PmtInf :{
                PmtInfId : "BATCHREFERENCE" ++ ( index+1 ) as String {format:'000000'},
                PmtMtd : "TRF",
                NbOfTxs : if (item.paidTransactionJoin == null)sizeOf(item) else if (item.basic.'type' contains "CREN") sizeOf( groupCheck(item) ) else  sizeOf(item.basic.internalId distinctBy ((item, index) -> item ) ) ,
                CtrlSum : sum(item.basic.amount),
                 (PmtTpInf : 
                 (
                  if (item.vendorJoin.custentity_payment_method.internalId[0] == "8" or item.vendorJoin.custentity_payment_method.internalId[0] == "7" or item.vendorJoin.custentity_payment_method.internalId[0] == "3") 
                            {SvcLvl : {
                                Cd : "URGP"
                            }                 
                            }
                            
                else if (item.vendorJoin.custentity_payment_method.internalId[0] == "10" or item.vendorJoin.custentity_payment_method.internalId[0] == "4")
                
                     
                            { SvcLvl : {
                                Cd : "NURG"
                            }
                           
                            }
                else 
                            { SvcLvl : {
                                Cd : "SEPA"
                            }
                                ,CtgyPurp : {
                                Cd : "SALA"
                            }
                            }
                             
                     )) ,
                ReqdExctnDt  : now() as String {format : 'yyyy-MM-dd'},
                Dbtr : {
                    Nm : 
                           item.customSearchJoin.customFieldList.custrecord_flexport_company_name[0] replace  "&amp;" with /&/,
                    PstlAdr :{
                        Ctry : 
                                  item.customSearchJoin.customFieldList.custrecord_flexport_bank_countrycode[0]
                    }
                },
                
                DbtrAcct: {
                    
                    Id :{
                        (
                        
                                Othr : {  
                                	Id : item.customSearchJoin.customFieldList.custrecord_flexport_bank_account_number[0]
                                }
                    )
                    },
                    Ccy :  item.customSearchJoin.customFieldList.custrecord_flexport_bank_currency[0]
               
                },
                (DbtrAgt : {
                    FinInstnId :{
                    	
                        BIC :  item.customSearchJoin.customFieldList.custrecord_flexport_bic[0] ,
                        PstlAdr :{
                            Ctry :   item.customSearchJoin.customFieldList.custrecord_flexport_bank_countrycode[0]  
                        }
                    }
                }),
                  (ChrgBr : "DEBT") if (item.vendorJoin.custentity_payment_method.internalId[0] == "8" or item.vendorJoin.custentity_payment_method.internalId[0] == "7" or item.vendorJoin.custentity_payment_method.internalId[0] == "3") ,
                      
                     (    item map ((vendorItem, index) -> 
                           CdtTrfTxInf :{
                           PmtId :{
                               InstrId : vendorItem.basic.internalId,
                               EndToEndId : vendorItem.basic.transactionNumber
                           },
                           Amt :{
                             InstdAmt  @( Ccy : vendorItem.basic.currency ) : vendorItem.basic.amount
                           }, 
                            (ChrgBr : "DEBT") if (item.vendorJoin.custentity_payment_method.internalId[0] == "10" or item.vendorJoin.custentity_payment_method.internalId[0] == "4") ,
                                   
                           ( ChqInstr :{
                                 
                                 ChqNb : vendorItem.basic.tranId,
                                 DlvryMtd :{
                                    Prtry : deliveryCodes[vendorItem.basic.custbody_jpm_check_delivery_code default "1"][0]
                                 },
                                 FrmsCd : "A1"
                           }) if(item.paidTransactionJoin != null),
                           
                           (IntrmyAgt1 : {
                             FinInstnId :{
                             BIC :  item.vendorJoin.custentity_intermediate_bank_bic[0],
                             Nm :  item.vendorJoin.custentity_intermediate_bank_name[0],
                             PstlAdr : { Ctry : item.vendorJoin.custentity_intermediate_bank_country[0] }
                            }
                           })if (  (vendorItem.vendorJoin.custentity_intermediate_bank_name != null)),
                           (CdtrAgt :{
                               FinInstnId :{
(BIC : vendorItem.vendorJoin.custentitybankroutingswift replace  /[^a-z0-9A-Z]/ with "")if(! isEmpty(vendorItem.vendorJoin.custentitybankroutingswift)),
                            (ClrSysMmbId :{
                                       MmbId :  (vendorItem.vendorJoin.custentity_local_routing_number replace  /[^a-z0-9A-Z]/ with "")
                                       })if(! isEmpty(vendorItem.vendorJoin.custentity_local_routing_number)),

                                       Nm : vendorItem.vendorJoin.custentitybankname,
                                       PstlAdr :{
                                           Ctry : vendorItem.vendorJoin.custentitybankcountry
                                       }
                                   
                               }
                           }) if (item.paidTransactionJoin == null),
                            Cdtr : {
                               Nm :  if (item.paidTransactionJoin == null )  vendorItem.vendorLineJoin.entityId replace  "&amp;" with /&/ default "" 
                                     else vendorItem.vendorJoin.entityId replace  "&amp;" with /&/ default "" ,
                               PstlAdr :{
                                   (StrtNm : vendorItem.vendorJoin.billAddress1) if ( vendorItem.vendorJoin.billAddress1 != null),
                                   PstCd : vendorItem.vendorJoin.billZipCode default "00000",
                                   (TwnNm : 
                                            vendorItem.vendorJoin.billCity) if (vendorItem.vendorJoin.billCity != null),
                                   (CtrySubDvsn :
                                            vendorItem.vendorJoin.billState) if (vendorItem.vendorJoin.billState != null),
                                    Ctry : 
                                            vendorItem.vendorJoin.billCountryCode                              }
                            }
,
                           ( CdtrAcct :{
                                Id : {
                            Othr :{
                                       Id : (vendorItem.vendorJoin.custentityaccountnumber replace "-" with "") replace " " with "" 
                                       }
                 
                            
                             
                     
                            }}) if(vendorItem.paidTransactionJoin == null),                                             
                            RmtInf :{
                                Ustrd : if (vendorItem.basic.memo != null ) vendorItem.basic.memo else "Flexport invoice payment",
                                
                            }
                           }
                         )
                         )
                        
                    }
                 
                  ))
             }   
             
               
        )
        }