%dw 2.0
var textdata = read(payload,"application/csv",{header:false})
output application/json
---
textdata map ((item, index) -> if(item.column_8 == "3/" and item.column_0 == "01") {
    "column_0": item.column_0,
    "column_1": item.column_1,
    "column_2": item.column_2,
    "column_3": item.column_3,
    "column_4": item.column_4,
    "column_5": item.column_5,
    "column_6":  item.column_6,
    "column_7": item.column_7,
    "column_8": "2/"
  }   else item )