%dw 2.0
output application/json
---
((payload filter ((item, index) ->  
	(((item.customSearchJoin.customFieldList.custrecord_flexport_bank_account_number)
		endsWith  "625"
	) == true) 
	and (item.basic.currency != "USD")
)) groupBy ((tran, index) -> tran.basic.tranDate as DateTime as String {
	format: "dd-MM-yyyy"
}))