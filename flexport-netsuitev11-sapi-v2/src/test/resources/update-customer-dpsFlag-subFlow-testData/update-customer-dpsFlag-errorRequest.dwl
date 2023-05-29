%dw 2.0
output application/xml
skipNullOn="everywhere"
ns ns0 urn:messages_2020_2.platform.webservices.netsuite.com
ns ns01 urn:relationships.lists.webservices.netsuite.com
ns ns02 urn:core_2020_2.platform.webservices.netsuite.com
ns xsi http://www.w3.org/2001/XMLSchema-instance

---
{
	ns0#updateList: {
		ns0#record @("xmlns:ns0": ns0, "xmlns:ns01": ns01, xsi#"type": "ns01:Customer", externalId: "gid://flexport/Payments::NetsuiteCustomer/21131"): {
   		        
   		    ns01#customFieldList: {
		        StringCustomFieldRef__custentity_dps_flag__8201 : {
	        	    ns02#value: "T"
		      }
	        }
			
		}
	}
}