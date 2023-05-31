%dw 2.0
output application/json
---
flatten(flatten(payload..payload) map ((item,index)-> item  pluck (value, key, index) -> value))