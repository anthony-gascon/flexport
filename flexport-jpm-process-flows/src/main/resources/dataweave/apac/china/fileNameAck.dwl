%dw 2.0
output application/json
---
(((payload filter ((item, index) -> ((item.attributes.name contains "ACK") and (item.attributes.name contains "APACChina") ) )) orderBy $.attributes.timestamp)[-1 to 0]).*attributes.name[0]