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
    if (item.paidTransactionJoin == null)sizeOf(item)  else if (item.basic.'type' contains "CREN") sizeOf( groupCheck(item) ) else sizeOf(item.basic.internalId distinctBy ((item, index) -> item ) ) ))
    ---
    totalTrx
}

fun groupCheck(data) = do{
	              var intId = (((data groupBy ((item, index) -> item.paidTransactionJoin.tranId) ) pluck ((value, key, index) -> value ))..internalId) distinctBy ((item, index) -> item )
                  var grpId =  ((data groupBy ((item, index) -> item.paidTransactionJoin.tranId)) pluck ((value, key, index) -> value))
                  var removeCrenId = (intId --(data filter ((item, index) -> item.basic."type" == "CREN" )).basic.internalId)   
                    ---
				 (removeCrenId map ((value, index) ->  
					 flatten (grpId filter ((item, index) -> ( item..basic.internalId contains  value) ))
					 )) - []
					}

---
Document @(xmlns :"urn:iso:std:iso:20022:tech:xsd:pain.001.001.03" , "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance" ) : {
   
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
                PmtMtd : if (item.vendorJoin.custentity_payment_method.internalId[0] == "8" or item.vendorJoin.custentity_payment_method.internalId[0] == "7" or item.vendorJoin.custentity_payment_method.internalId[0] == "3" or item.vendorJoin.custentity_payment_method.internalId[0] == "10" or item.vendorJoin.custentity_payment_method.internalId[0] == "4") 
                            "TRF"
                else 
                             "CHK",
                NbOfTxs : if (item.paidTransactionJoin == null)sizeOf(item) else if (item.basic.'type' contains "CREN") sizeOf( groupCheck(item) ) else  sizeOf(item.basic.internalId distinctBy ((item, index) -> item ) ) ,
                CtrlSum : sum(item.basic.amount),
                 (PmtTpInf : 
                 (
                  if (item.vendorJoin.custentity_payment_method.internalId[0] == "8" or item.vendorJoin.custentity_payment_method.internalId[0] == "7" or item.vendorJoin.custentity_payment_method.internalId[0] == "3") 
                            SvcLvl : {
                                Cd : "URGP"
                            }
                else 
                            { SvcLvl : {
                                Cd : "NURG"
                            }
                            	,LclInstrm : {
                                Cd : "CCD"
                            }
                            }
                             
                     )) if (item.paidTransactionJoin == null),
                ReqdExctnDt  : now() as String {format : 'yyyy-MM-dd'},
                Dbtr : {
                    Nm : if ( item.basic.'type' contains "CREN" ) 
                    		(item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_company_name[0] replace  "&amp;" with /&/
                         else  item.customSearchJoin.customFieldList.custrecord_flexport_company_name[0] replace  "&amp;" with /&/,
                    PstlAdr :{
                        Ctry : if ( item.basic.'type' contains "CREN" )
                                  (item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_bank_countrycode[0]
                              else 
                                  item.customSearchJoin.customFieldList.custrecord_flexport_bank_countrycode[0]
                    },
                    (Id :{
                        OrgId :{
                            Othr :{
                                Id : if ( item.basic.'type' contains "CREN" )
                                      (item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_ach_id[0]
                                     else  item.customSearchJoin.customFieldList.custrecord_flexport_ach_id[0],
                                SchmeNm :{
                                    Prtry :  if ( item.basic.'type' contains "CREN" )
                                      (item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_ach_sch[0]
                                     else  item.customSearchJoin.customFieldList.custrecord_flexport_ach_sch[0]
                                }
                            }
                        }
                    }) if (item.vendorJoin.custentity_payment_method.internalId[0] == "10" or item.vendorJoin.custentity_payment_method.internalId[0] == "4")
                },
                
                DbtrAcct: {
                	
                	Id :{
                		Othr :{
                			Id :  if ( item.basic.'type' contains "CREN" )
                                      (item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_bank_account_number[0]
                                     else  item.customSearchJoin.customFieldList.custrecord_flexport_bank_account_number[0]
                		}
                		
                	},
                	Ccy : if ( item.basic.'type' contains "CREN" )
                               (item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_bank_currency[0]
                          else  item.customSearchJoin.customFieldList.custrecord_flexport_bank_currency[0]
               
                },
                DbtrAgt : {
                    FinInstnId :{
                        BIC : if ( item.basic.'type' contains "CREN" )
                               (item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_bic[0]
                              else  item.customSearchJoin.customFieldList.custrecord_flexport_bic[0] ,
                        ClrSysMmbId : {
                            MmbId : if ( item.basic.'type' contains "CREN" )
                               (item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_member_id[0]
                              else  item.customSearchJoin.customFieldList.custrecord_flexport_member_id[0] ,
                        },
                        PstlAdr :{
                            Ctry : if ( item.basic.'type' contains "CREN" )
                               (item filter $.basic.'type' == "CINV").customSearchJoin.customFieldList.custrecord_flexport_bank_countrycode[0]
                              else  item.customSearchJoin.customFieldList.custrecord_flexport_bank_countrycode[0]  
                        }
                    }
                },
                     ( if (item.paidTransactionJoin == null)
                         item map ((vendorItem, index) -> 
                           CdtTrfTxInf :{
                           PmtId :{
                               InstrId : vendorItem.basic.internalId,
                               EndToEndId : vendorItem.basic.transactionNumber
                           },
                           Amt :{

                             InstdAmt  @( Ccy : vendorItem.basic.currency ) : vendorItem.basic.amount
                           },         
                           ( ChqInstr :{
                           	     
                           	     ChqNb : vendorItem.basic.tranId,
                           	     DlvryMtd :{
                           	     	Prtry : deliveryCodes[vendorItem.basic.custbody_jpm_check_delivery_code default "1"][0]
                           	     },
                           	     FrmsCd : "A1"
                           }) if(item.paidTransactionJoin != null),
                           (ChrgBr : "DEBT") if (item.vendorJoin.custentity_payment_method.internalId[0] == "8" or item.vendorJoin.custentity_payment_method.internalId[0] == "7" or item.vendorJoin.custentity_payment_method.internalId[0] == "3") ,
                           (IntrmyAgt1 : {
                           	 FinInstnId :{
                           	 BIC :  item.vendorJoin.custentity_intermediate_bank_bic[0],
                           	 Nm :  item.vendorJoin.custentity_intermediate_bank_name[0],
                           	 PstlAdr : { Ctry : item.vendorJoin.custentity_intermediate_bank_country[0] }
                           	}
                           })if ( !isEmpty(vendorItem.vendorJoin.custentity_intermediate_bank_name)),
                           (CdtrAgt :{

                               FinInstnId :{
                                       (
                 
                 if (isNumeric(vendorItem.vendorJoin.custentitybankroutingswift))
                            ClrSysMmbId :{
                                       MmbId :  (vendorItem.vendorJoin.custentitybankroutingswift replace  "-" with "") replace " " with ""
                                       }
                 
                            else {BIC : (vendorItem.vendorJoin.custentitybankroutingswift replace  "-" with "") replace " " with ""}
                             
                     )
                                       ,
                                       Nm : vendorItem.vendorJoin.custentitybankname,
                                       PstlAdr :{
                                           Ctry : vendorItem.vendorJoin.custentitybankcountry
                                       }
                                   
                               }
                           }) if (item.paidTransactionJoin == null),
                            Cdtr : {
                               Nm :  if (item.paidTransactionJoin == null ) vendorItem.vendorLineJoin.entityId replace  "&amp;" with /&/ default "" 
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
                                Id : (
                 
                 if (isNumeric(vendorItem.vendorJoin.custentityaccountnumber[0-1]))
                            Othr :{
                                       Id : (vendorItem.vendorJoin.custentityaccountnumber replace "-" with "") replace " " with "" 
                                       }
                 
                            else { IBAN : (vendorItem.vendorJoin.custentityaccountnumber replace "-" with "") replace " " with ""}
                             
                     )
                            }) if(vendorItem.paidTransactionJoin == null),
                            
                            (InstrForDbtrAgt : p('mapping.countrycode.PH'))  if(vendorItem.vendorJoin.custentitybankcountry == "PH" ),
                            (InstrForDbtrAgt : p('mapping.countrycode.ID'))  if(vendorItem.vendorJoin.custentitybankcountry == "ID" ),
                            (InstrForDbtrAgt : p('mapping.countrycode.KR'))  if(vendorItem.vendorJoin.custentitybankcountry == "KR" ),
                            (InstrForDbtrAgt : p('mapping.countrycode.CNY'))  if(vendorItem.basic.currency == "CNY" ),
                            RmtInf :{

                                Ustrd : if (vendorItem.basic.memo != null ) vendorItem.basic.memo else "Flexport invoice payment",
                                
                            }
                           }
                         )
                         else  (
                          ( (   if (item.basic.'type' contains "CREN") groupCheck(item)  else (item groupBy $.basic.internalId ) pluck $ )) map  ( (itemValue, index) -> 	 
                           CdtTrfTxInf :{
                           PmtId :{
                               InstrId :  if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").basic.internalId[0] else  itemValue.basic.internalId[0],
                               EndToEndId :if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").basic.transactionNumber[0] else  itemValue.basic.transactionNumber[0] 
                           },
                           Amt :{

                             InstdAmt  @( Ccy : if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").basic.currency[0] else  itemValue.basic.currency[0] ) : sum(itemValue.basic..amount)
                           },
                           
                           ( ChqInstr :{
                           	     
                           	     ChqNb : if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").basic.tranId[0]
								           else  itemValue.basic.tranId[0],
                           	     DlvryMtd :{
                           	     	Prtry : deliveryCodes[if (item.basic.'type' contains "CREN") (item filter $.basic.'type' == "CINV").basic.custbody_jpm_check_delivery_code[0] default "1" else  itemValue.basic.custbody_jpm_check_delivery_code[0] default "1"][0]
                           	     },
                           	     FrmsCd : "A1"
                           	
                           }) if(item.paidTransactionJoin != null),
                           (CdtrAgt :{
                               FinInstnId :{  
                                       (
						 if (isNumeric( if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.custentitybankroutingswift[0] 
								           else  itemValue.vendorJoin.custentitybankroutingswift[0]))
									ClrSysMmbId :{
											   MmbId : if (itemValue.basic.'type' contains "CREN") ((itemValue filter $.basic.'type' == "CINV").vendorJoin.custentitybankroutingswift[0]  replace  "-" with "") replace " " with ""
								           else  (itemValue.vendorJoin.custentitybankroutingswift[0] replace  "-" with "") replace " " with ""
											   }
						 
									else {BIC : if (itemValue.basic.'type' contains "CREN") ((itemValue filter $.basic.'type' == "CINV").vendorJoin.custentitybankroutingswift[0] replace  "-" with "") replace " " with ""
								           else  (itemValue.vendorJoin.custentitybankroutingswift[0] replace  "-" with "") replace " " with ""}
									 
							 )
											   ,
											   Nm : if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.custentitybankname[0] 
								           else  itemValue.vendorJoin.custentitybankname[0] ,
											   PstlAdr :{
												   Ctry : if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.custentitybankcountry[0] 
								           else  itemValue.vendorJoin.custentitybankcountry[0]
											   }
										   
									   }
								   }) if (item.paidTransactionJoin == null),
									Cdtr : {
									   Nm :  if (item.paidTransactionJoin == null ) 
                                                    if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorLineJoin.entityId[0] 
								                    else  itemValue.vendorLineJoin.entityId[0]
											 else if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.entityId[0] 
								                    else  itemValue.vendorJoin.entityId[0]  ,
									   PstlAdr :{
										   (StrtNm : if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.billAddress1[0] 
								           else  itemValue.vendorJoin.billAddress1[0]) if ( itemValue.vendorJoin.billAddress1[0] != null),
										   PstCd : if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.billZipCode[0] default "00000" 
								           else  itemValue.vendorJoin.billZipCode[0] default "00000",
										   (TwnNm :  if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.billCity[0] 
								           else  itemValue.vendorJoin.billCity[0]
													) if (item.vendorJoin.billCity[index] != null),
										   (CtrySubDvsn : if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.billState[0] 
								           else  itemValue.vendorJoin.billState[0]
													) if (item.vendorJoin.billState[index] != null),
											Ctry :  if (itemValue.basic.'type' contains "CREN") (itemValue filter $.basic.'type' == "CINV").vendorJoin.billCountryCode[0] 
								           else  itemValue.vendorJoin.billCountryCode[0]
													                           }
									}
		,
								   ( CdtrAcct :{
										Id : (
						 
						 if (isNumeric( if (itemValue.basic.'type' contains "CREN") ((itemValue filter $.basic.'type' == "CINV").vendorJoin.custentityaccountnumber[0])[0-1] 
								           else  (itemValue.vendorJoin.custentityaccountnumber[0])[0-1] ))
									Othr :{
											   Id : if (itemValue.basic.'type' contains "CREN") ((itemValue filter $.basic.'type' == "CINV").vendorJoin.custentityaccountnumber[0] replace "-" with "") replace " " with ""
								           else  (itemValue.vendorJoin.custentityaccountnumber[0]  replace "-" with "") replace " " with ""
											   }
						 
									else { IBAN : if (itemValue.basic.'type' contains "CREN") ((itemValue filter $.basic.'type' == "CINV").vendorJoin.custentityaccountnumber[0] replace "-" with "") replace " " with "" 
								           else  (itemValue.vendorJoin.custentityaccountnumber[0]  replace "-" with "") replace " " with "" }
									 
							 )
									}) if(itemValue.paidTransactionJoin == null),
									
									(InstrForDbtrAgt : p('mapping.countrycode'))  if((itemValue.vendorJoin.billCountry[0] contains "_philippines" ) or (itemValue.vendorJoin.billCountry[0] contains "_koreaRepublicOf" ) ),
									

									RmtInf :{

										Ustrd : if (itemValue.basic.memo[0] != null ) itemValue.basic.memo[0] else "Flexport invoice payment",
										(itemValue map ((vendorItem, index) -> 
											Strd :{
											RfrdDocInf :{
											
													Tp:{
														
														CdOrPrtry:{
															 Cd:  vendorItem.basic.'type'
															 
														}
														
													},
													Nb : vendorItem.paidTransactionJoin.tranId,
													RltdDt : vendorItem.paidTransactionJoin.tranDate as DateTime as String { format: "yyyy-MM-dd" }},
													RfrdDocAmt :{
														DuePyblAmt @(Ccy : vendorItem.paidTransactionJoin.currency ) :  vendorItem.paidTransactionJoin.paidAmount,
														DscntApldAmt @(Ccy : vendorItem.paidTransactionJoin.currency ) : "0.00",
														(RmtdAmt @(Ccy : vendorItem.paidTransactionJoin.currency ) : vendorItem.paidTransactionJoin.paidAmount) if ( vendorItem.basic.'type' == "CINV"),
														(CdtNoteAmt @(Ccy : vendorItem.paidTransactionJoin.currency )	 : vendorItem.paidTransactionJoin.paidAmount) if( vendorItem.basic.'type'== "CREN")
													},
													CdtrRefInf:   { Ref : (vendorItem.paidTransactionJoin.memo withMaxSize 30 ) default vendorItem.paidTransactionJoin.tranId}
												
											
										}
									   )
									   
									 ) 
									}
								   }
								 ))
							 )
						
					}
				 
				  ))
			 }   

			 
			   
		)
		}