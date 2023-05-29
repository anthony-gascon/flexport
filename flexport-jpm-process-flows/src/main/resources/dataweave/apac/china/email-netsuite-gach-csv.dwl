%dw 2.0
output application/csv
---
payload map ((item, index) ->  
    {
	internalId: item.internalId
} ++ {
	(item.customFieldList.customField)
})