%dw 2.0
output application/csv
---
vars.prepareListEmail map ((item, index) ->  
    {
	internalId: item.internalId
} ++ {
	(item.customFieldList.customField)
})