%dw 2.0
output application/json
---
(payload groupBy ((tran, index) -> tran.basic.tranDate as DateTime as String {
	format: "dd-MM-yyyy"
}))