%dw 2.0
output application/json
---
(payload filter (($..custentity_payment_method.'@internalId' contains "10") or ($..custentity_payment_method.'@internalId' contains "4"))) filter ($..basic != null and $..customerMainJoin != null and $..customSearchJoin != null and (isEmpty($."customSearchJoin") != true))