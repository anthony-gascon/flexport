%dw 2.0
output application/json
var textdata = read(payload,"application/csv",{header:false})
var index = (textdata map (indx : $$) if ($.column_0 == "03")).indx
var comboresult = index map (textdata[$ to ((index[($$ + 1)]) -1)] default textdata[$ to -1])
---
comboresult