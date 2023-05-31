%dw 2.0
output application/json skipNullOn="everywhere"
---
(payload map ((item, index) -> 
{
(basic: item.basic filterObject ((value, key, index) -> value !=[])) if ( item.basic != null),
(vendorJoin: item.vendorJoin filterObject ((value, key, index) -> value !=[]))if( item.vendorJoin != null),
(vendorLineJoin : item.vendorLineJoin filterObject ((value, key, index) -> value !=[]) )if ( item.vendorLineJoin != null),
(customSearchJoin : item.customSearchJoin filterObject ((value, key, index) -> value !=[]) ) if ( item.customSearchJoin != null),
(paidTransactionJoin : item.paidTransactionJoin filterObject ((value, key, index) -> value !=[]) )  if ( item.paidTransactionJoin != null),
(subsidiaryJoin : item.subsidiaryJoin filterObject ((value, key, index) -> value !=[])) if ( item.subsidiaryJoin != null)

}
)) - {}
