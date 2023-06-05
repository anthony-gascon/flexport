%dw 2.0
output application/xml
ns ns0 urn:messages_2020_2.platform.webservices.netsuite.com
ns ns01 urn:sales_2020_2.transactions.webservices.netsuite.com
ns ns02 urn:common_2020_2.platform.webservices.netsuite.com
ns ns03 urn:core_2020_2.platform.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance
---
{
	ns0#search: {
		ns0#searchRecord @("xmlns:ns0": ns0,"xmlns:ns01": ns01, xsi#"type": "ns01:TransactionSearchAdvanced",  savedSearchId: p('vendor.payment.savesearch.savedSearchId') , savedSearchScriptId: 'p('vendor.payment.savesearch.savedSearchScriptId')'): {
		}
	}
}