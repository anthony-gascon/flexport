%dw 2.0
ns ns0 urn:messages_2020_2.platform.webservices.netsuite.com
ns ns01 urn:customers_2020_2.transactions.webservices.netsuite.com
ns ns02 urn:core_2020_2.platform.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance
output application/xml  skipNullOn = "everywhere"
---
{
	ns0#updateList: {
		(vars.psrVariable map ((item, index) -> 
      ns0#record @("xmlns:ns0": ns0, "xmlns:ns01": ns01, xsi#"type": "ns01:VendorPayment", internalId: item.internalId): {
			ns01#customFieldList: {
				(StringCustomFieldRef__custbody_jpm_ack_psr_error_message: {
					ns02#value: item.customFieldList.customField.StringCustomFieldRef__custbody_jpm_ack_psr_error_message
				}) if (! isEmpty(item.customFieldList.customField.StringCustomFieldRef__custbody_jpm_ack_psr_error_message)),
				(BooleanCustomFieldRef__custbody_jpm_psr_failed: {
					ns02#value: item.customFieldList.customField.BooleanCustomFieldRef__custbody_jpm_psr_failed
				}) if(! isEmpty(item.customFieldList.customField.BooleanCustomFieldRef__custbody_jpm_psr_failed)),
				BooleanCustomFieldRef__custbodysvbexport: {
					ns02#value: item.customFieldList.customField.BooleanCustomFieldRef__custbodysvbexport
				},
				StringCustomFieldRef__custbody_jpm_paid_currency: {
					ns02#value: item.customFieldList.customField.StringCustomFieldRef__custbody_jpm_paid_currency
				},
				StringCustomFieldRef__custbody_jpm_paid_amount: {
					ns02#value: item.customFieldList.customField.StringCustomFieldRef__custbody_jpm_paid_amount
				}
			}
		}
    ))
	}
}