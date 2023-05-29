%dw 2.0
ns ns0 urn:messages_2020_2.platform.webservices.netsuite.com
ns ns01 urn:sales_2020_2.transactions.webservices.netsuite.com
ns ns02 urn:common_2020_2.platform.webservices.netsuite.com
ns ns03 urn:core_2020_2.platform.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance
output application/xml
---
{
	ns0#search: {
		ns0#searchRecord @("xmlns:ns0": ns0, "xmlns:ns01": ns01, xsi#"type": "ns01:TransactionSearch"): {
			ns01#basic: {
				ns02#customFieldList: {
					ns03#customField @(scriptId: p('customer.refund.searchBy.fields.fileName'), internalId: p('customer.refund.searchBy.fields.fileName.internalId'), operator: 'is' , xsi#"type": "ns03:SearchStringCustomField"): {
						ns03#searchValue: vars.URIParam.msgId
					}
				}
			}
		}
	}
}