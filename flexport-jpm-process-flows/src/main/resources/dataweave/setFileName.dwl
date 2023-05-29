%dw 2.0
output application/json
---
if (vars.source == "China")(p('apac.china.sftp.filename'))
else if (vars.source == "Singapore")(p('apac.singapore.sftp.filename'))
else if (vars.source == "Hongkong")(p('apac.hongkong.sftp.filename'))
else if (vars.source == "CustomerRefund") p('namea.customer.refund.sftp.filename')
else
"Source country is not correct "