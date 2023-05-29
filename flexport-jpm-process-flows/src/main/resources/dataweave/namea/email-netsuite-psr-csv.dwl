output application/csv
---
vars.psrVariable map ((item, index) ->  
    {
	internalId: item.internalId
} ++ {
	(item.customFieldList.customField)
})