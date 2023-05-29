%dw 2.0
ns ns0 urn:messages_2020_2.platform.webservices.netsuite.com
ns ns01 urn:customers_2020_2.transactions.webservices.netsuite.com
ns ns02 urn:core_2020_2.platform.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance
output application/xml  skipNullOn="everywhere"
---
{
  ns0#updateList: {
    (payload map ((item, index) -> 
      ns0#record @("xmlns:ns0": ns0, "xmlns:ns01": ns01, xsi#"type": "ns01:CustomerRefund", internalId: item.internalId): {
        ns01#customFieldList: {
          StringCustomFieldRef__custbody_jpm_ack_psr_error_message: {
            ns02#value: item.customFieldList.customField.StringCustomFieldRef__custbody_jpm_ack_psr_error_message
          },
          BooleanCustomFieldRef__custbody_jpm_ack_failed: {
            ns02#value: item.customFieldList.customField.BooleanCustomFieldRef__custbody_jpm_ack_failed
          }
        }
      }
    ))
  }
}