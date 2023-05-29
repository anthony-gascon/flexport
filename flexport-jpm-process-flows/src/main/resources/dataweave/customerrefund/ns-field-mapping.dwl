%dw 2.0
import * from dw::core::Arrays
output application/json  skipNullOn = "everywhere"
---
(payload map ((item, index) -> {
	(basic: item.basic filterObject ((value, key, index) -> value != [])) if (item.basic != null),
	(customerMainJoin: item.customerMainJoin filterObject ((value, key, index) -> value != [])) if (item.customerMainJoin != null),
	(customSearchJoin: item.customSearchJoin filterObject ((value, key, index) -> value != [])) if (item.customSearchJoin != null)
})) - {
}