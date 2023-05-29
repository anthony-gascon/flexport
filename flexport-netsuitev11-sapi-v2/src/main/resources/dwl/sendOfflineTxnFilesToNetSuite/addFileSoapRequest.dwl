%dw 2.0
output application/xml

ns ns0 urn:messages_2020_2.platform.webservices.netsuite.com
ns ns01 urn:filecabinet_2020_2.documents.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance
ns ns02 urn:core_2020_2.platform.webservices.netsuite.com
---
{
	ns0#add: {
		ns0#record @("xmlns:ns01": ns01, xsi#"type": "ns01:File"): {
			ns01#name: vars.fileName ,
			ns01#content: payload,
			ns01#folder @(internalId: vars.folderId): {
				
			}
		}
	}
}