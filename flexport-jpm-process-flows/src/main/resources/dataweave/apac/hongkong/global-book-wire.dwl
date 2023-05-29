%dw 2.0
output application/json
---

( (payload filter ((item, index) ->  
	 
	  !(item.vendorJoin.custentitybankname contains  "JPMORGAN CHASE")  ) 
) ) groupBy ((tran, index) -> (tran.basic.tranDate as DateTime as String { format: "dd-MM-yyyy" }) ++ tran.customSearchJoin.id )	 	