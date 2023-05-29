%dw 2.0
output application/json
---
if (vars.source == "China")(p('apac.china.ns.folderId'))
else if (vars.source == "Singapore")(p('apac.singapore.ns.folderId'))
else if (vars.source == "Hongkong")(p('apac.hongkong.ns.folderId'))
else if (vars.source == "CustomerRefund")(p('namea.customer.refund.ns.folderId'))
else
"Source country is not correct "