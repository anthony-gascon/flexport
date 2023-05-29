%dw 2.0
output application/json
---
if ( vars.source == ('China') ) "chinafile"
else if ( vars.source ==  ('Hongkong') ) "hongkongfile"
else 
"singaporefile"