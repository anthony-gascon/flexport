%dw 2.0
output application/json
---
if ( attributes.queryParams.filename contains ('China') ) "chinafile"
else if ( attributes.queryParams.filename contains ('HongKong') ) "hongkongfile"
else if ( attributes.queryParams.filename contains (p('namea.customer.refund.vm.publish.condition.filename')) ) "customerrefundfile"
else 
"singaporefile"