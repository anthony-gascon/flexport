  %dw 2.0
output application/json
---
(((payload filter ((item, index) -> ((item.attributes.name contains "PSOURCE") and  (item.attributes.name contains "APACSingapore")) )) orderBy $.attributes.timestamp)[-1 to 0]).*attributes.name[0]