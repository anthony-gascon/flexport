%dw 2.0
output application/json 
---
payload.updateListResponse.writeResponseList.*writeResponse map ((item, index) -> 
{
	internalId: item.baseRef.'@internalId',
	status: item.status.'@isSuccess'
}
)