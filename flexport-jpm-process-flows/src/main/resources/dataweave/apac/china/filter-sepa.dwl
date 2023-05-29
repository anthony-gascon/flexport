%dw 2.0
output application/json
---
(payload filter (($..custentity_payment_method.internalId contains  "11") 
)) filter ($..basic != null and $..vendorJoin != null and $..vendorLineJoin != null and $..customSearchJoin != null and (isEmpty($."customSearchJoin"."customFieldList") != true ))
