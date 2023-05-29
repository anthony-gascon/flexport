%dw 2.0
output application/json
---
((payload filter ((item, index) ->  
	(((item.customSearchJoin.customFieldList.custrecord_flexport_bank_account_number) endsWith  "625") == true) and (item.basic.currency == "USD") and (item.customerMainJoin.billCountryCode == "US") and  (! (item.customerMainJoin.custentitybankname contains  "JPMORGAN CHASE"))
)) groupBy ((tran, index) -> tran.basic.tranDate as DateTime as String {
	format: "dd-MM-yyyy"
}))