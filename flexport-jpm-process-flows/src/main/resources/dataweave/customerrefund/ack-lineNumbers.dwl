%dw 2.0
output application/json

fun getLineNumber(message) = do{
var arr = message splitBy  " "
var lineIndex = (arr indexOf(upper("Line"))) + 1
---
arr[lineIndex] as Number
}

var lineNumbers = payload.Document.CstmrPmtStsRpt.OrgnlGrpInfAndSts.*StsRsnInf map ((item, index) -> {
   "lineNumber" : getLineNumber(upper(item.AddtlInf)),
   "info" : item.*AddtlInf[1]
} )

---
lineNumbers
