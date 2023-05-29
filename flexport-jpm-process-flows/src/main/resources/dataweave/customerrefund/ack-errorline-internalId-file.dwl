%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
output application/json

var payloadString = write(payload, "application/xml")
var payloadArr = lines(payloadString)

fun matchId(reverse, index) = 
     if (index <= sizeOf(reverse)) 
        if (reverse[index] contains  "<InstrId>")
            trim(reverse[index])
        else
            matchId(reverse, index + 1)   
     else
        " "       
fun findInternalId(arr) = matchId(arr[-1 to 0], 0)

---

vars.lineNumbers map ((item, index) ->
{
    "errorLineNumber" : item.lineNumber,
    "errorInfo" : item.info,
    "errorLineValue" : trim(payloadArr[item.lineNumber-1]),
    "internalId" : findInternalId(slice(payloadArr, 0, item.lineNumber))
} )
