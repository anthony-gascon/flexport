%dw 2.0
output application/xml
ns ns0 urn:messages_2020_2.platform.webservices.netsuite.com
ns ns01 urn:common_2020_2.platform.webservices.netsuite.com
ns ns02 urn:core_2020_2.platform.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance
---
{
    ns0#search: {
        ns0#searchRecord @("xmlns:ns01": ns01, xsi#"type": "ns01:ContactSearchBasic"): {
            ns01#internalId @(operator: "anyOf"): {
                ns02#searchValue @("type": "contact" , internalId : attributes.uriParams.'internalId'): {}
            }
        }
    }
}