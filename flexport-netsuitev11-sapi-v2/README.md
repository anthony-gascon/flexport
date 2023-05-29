# flexport-netsuitev11-sapi-v2
Netsuite SAPI v2 endpoints

- endpoint : api/v2/customer  
  Method : PUT  
  Description : Updates the fields of customer objects.  
  Request-BodyType : application/xml  
  Example:   
 ```
<?xml version='1.0' encoding='UTF-8'?>
<ns0:updateList xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com">
  <ns0:record xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com" xmlns:ns01="urn:relationships_2020_2.lists.webservices.netsuite.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ns01:Customer" externalId="CustomerExternalId">
    <ns01:customFieldList xmlns:ns01="urn:relationships_2020_2.lists.webservices.netsuite.com">
      <StringCustomFieldRef__custentity_dps_flag__8201>
        <ns02:value xmlns:ns02="urn:core_2020_2.platform.webservices.netsuite.com">T</ns02:value>
      </StringCustomFieldRef__custentity_dps_flag__8201>
    </ns01:customFieldList>
  </ns0:record>
</ns0:updateList>
```
- endpoint : api/v2/customer/loan/invoice/{externalId}  
  Method : GET  
  Description: Search invoice with externalId.  
  Response-Type : application/json  
    
  
- endpoint : api/v2/vendor  
  Method : PUT  
  Description : Updates the fields of Vendor objects.  
  Request-BodyType : application/xml  
  Example:   
```
<?xml version='1.0' encoding='UTF-8'?>
<ns0:updateList xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com">
  <ns0:record xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com" xmlns:ns01="urn:relationships_2020_2.lists.webservices.netsuite.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ns01:Vendor" externalId="VendorExternalId">
    <ns01:customFieldList xmlns:ns01="urn:relationships_2020_2.lists.webservices.netsuite.com">
      <StringCustomFieldRef__custentity_dps_flag__8201>
        <ns02:value xmlns:ns02="urn:core_2020_2.platform.webservices.netsuite.com">T</ns02:value>
      </StringCustomFieldRef__custentity_dps_flag__8201>
    </ns01:customFieldList>
  </ns0:record>
</ns0:updateList>
```

- endpoint : api/v2/savesearch/customers  
  Method : GET  
  Description: Gets all the customers updated in the past 24 hours  
  Response Type : application/json        

- endpoint : api/v2/savesearch/vendors  
  Method : GET  
  Description: Gets all the vendors updated in the past 24 hours  
  Response Type : application/json  

- endpoint : api/v2/savesearch/invoices  
  Method : GET  
  Description: Gets all the invoices updated in the past 24 hours  
  Response Type : application/json  

- endpoint  : api/v2/savesearch/invoices
  Method : POST
  Description : Gets invoices based on the input soap request 
  Response Type : application/json
  Request BodyType : application/xml
  Example :
```
<?xml version='1.0' encoding='UTF-8'?>
<ns0:search xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com">
  <ns0:searchRecord xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ns01:TransactionSearchAdvanced" savedSearchId="4005" savedSearchScriptId="customsearch4005">
    <ns01:criteria>
      <ns01:applyingTransactionJoin>
        <ns02:lastModifiedDate xmlns:ns02="urn:common_2020_2.platform.webservices.netsuite.com" operator="within">
          <ns03:searchValue xmlns:ns03="urn:core_2020_2.platform.webservices.netsuite.com">2022-09-26T00:00:00.000000-07:00</ns03:searchValue>
          <ns03:searchValue2 xmlns:ns03="urn:core_2020_2.platform.webservices.netsuite.com">2022-09-26T00:05:00.000000-07:00</ns03:searchValue2>
        </ns02:lastModifiedDate>
      </ns01:applyingTransactionJoin>
    </ns01:criteria>
  </ns0:searchRecord>
</ns0:search>
```

- endpoint : api/v2/savesearch/contacts  
  Method : GET  
  Description: Gets all the contacts updated in the past 24 hours  
  Response Type : application/json  

  
- endpoint : api/v2/invoice  
  Method : POST  
  Description : Create invoice record in Netsuite.  
  Request-BodyType : application/xml  
  Example:   
```
<?xml version='1.0' encoding='UTF-8'?>
<ns0:addList xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com">
  <ns0:record xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com" xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ns01:Invoice">
    <ns01:entity xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com" externalId="gid://flexport/Payments::NetsuiteCustomer/36131"/>
    <ns01:tranDate xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">2022-08-04T10:19:05Z</ns01:tranDate>
    <ns01:department xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">
      <internalId>104</internalId>
    </ns01:department>
    <ns01:class xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">
      <internalId>16</internalId>
    </ns01:class>
    <ns01:subsidiary xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">
      <internalId>17</internalId>
    </ns01:subsidiary>
    <ns01:currency xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">
      <internalId>1</internalId>
    </ns01:currency>
    <ns01:dueDate xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">2022-08-05T10:44:10.468+05:30</ns01:dueDate>
    <ns01:memo xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">ch_2JmFPRVOXmLTEyWf1ILb5A08</ns01:memo>
    <ns01:account xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">
      <internalId>334</internalId>
    </ns01:account>
    <ns01:customFieldList xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">
      <StringCustomFieldRef__custbodydelivdate__537>
        <ns02:value xmlns:ns02="urn:core_2020_2.platform.webservices.netsuite.com">2022-09-05T10:44:10.468+05:30</ns02:value>
      </StringCustomFieldRef__custbodydelivdate__537>
    </ns01:customFieldList>
    <ns01:itemList xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com">
      <ns01:item>
        <ns01:item>
          <internalId>43762</internalId>
        </ns01:item>
        <amount>1000.0</amount>
        <description>Principal</description>
      </ns01:item>
	  <ns01:item>
        <ns01:item>
          <internalId>43742</internalId>
        </ns01:item>
        <amount>120.0</amount>
        <description>Interest</description>
      </ns01:item>
	  <ns01:item>
        <ns01:item>
          <internalId>43766</internalId>
        </ns01:item>
        <amount>180.0</amount>
        <description>Amount Not Financed</description>
      </ns01:item>
    </ns01:itemList>
  </ns0:record>
</ns0:addList>
```
	
- endpoint : api/v2/notes  
  Method : POST  
  Description : Create notes record in Netsuite.  
  Request-BodyType : application/xml  
  Example:   
```
<?xml version='1.0' encoding='UTF-8'?>
<ns0:addList xmlns:ns0="urn:messages.platform.webservices.netsuite.com">
  <ns0:record xmlns:ns0="urn:messages.platform.webservices.netsuite.com" xmlns:ns01="urn:customization.setup.webservices.netsuite.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ns01:CustomRecord">
    <ns01:customFieldList xmlns:ns01="urn:customization.setup.webservices.netsuite.com">
      <DateCustomFieldRef__custrecord_note_date__8414>
        <ns02:value xmlns:ns02="urn:core.platform.webservices.netsuite.com">2022-08-17T00:55:01.217+05:30</ns02:value>
      </DateCustomFieldRef__custrecord_note_date__8414>
      <StringCustomFieldRef__custrecord_note__8415>
        <ns02:value xmlns:ns02="urn:core.platform.webservices.netsuite.com">Error While Creating Invoice</ns02:value>
      </StringCustomFieldRef__custrecord_note__8415>
      <StringCustomFieldRef__custrecord_note_type__8416>
        <ns02:value xmlns:ns02="urn:core.platform.webservices.netsuite.com">Invoice-Error</ns02:value>
      </StringCustomFieldRef__custrecord_note_type__8416>
    </ns01:customFieldList>
  </ns0:record>
</ns0:addList>
```
- endpoint : api/v2/contact/{internalId}  
  Method : GET  
  Description: Search contact with internalId.  
  Response-Type : application/json  
  Example:   

```
[
    {
        "inboundAttachmentNames": [],
        "exceptionPayload": null,
        "inboundPropertyNames": [],
        "outboundAttachmentNames": [],
        "payload": {
            "record": {
                "@externalId": "accounting@ecopowerinc.com",
                "@internalId": "26513402",
                "@type": "listRel:Contact",
                "entityId": "Accounting Contact",
                "company": {
                    "@internalId": "17992733",
                    "name": "47797 - 703106 - Ecopower Inc. - CA Ecopower Inc.  -  CA"
                },
                "firstName": "Accounting",
                "lastName": "Contact",
                "email": "accounting@ecopowerinc.com",
                "isPrivate": "false",
                "isInactive": "false",
                "subsidiary": {
                    "@internalId": "25",
                    "name": "Flexport Canada Customs"
                },
                "dateCreated": "2022-05-12T15:09:02.000-07:00",
                "lastModifiedDate": "2022-07-16T11:37:14.000-07:00"
            }
        },
        "outboundPropertyNames": [],
        "attributes": {
            "transportHeaders": {
                "date": "Tue, 22 Nov 2022 19:45:50 GMT",
                "set-cookie": "NS_ROUTING_VERSION=LAGGING; path=/",
                "content-length": "2072",
                "vary": "User-Agent",
                "x-n-operationid": "a8a9294c-680d-4bc2-a215-597401848402",
                "connection": "keep-alive",
                "content-type": "text/xml;charset=utf-8",
                "p3p": "CP=\"CAO PSAa OUR BUS PUR\"",
                "strict-transport-security": "max-age=31536000",
                "akamai-grn": "0.aca83b17.1669146350.380ee413",
                "ns_rtimer_composite": "2024609221:706172746E6572733030392E70726F642E7376616C652E6E65746C65646765722E636F6D:80"
            },
            "transportAdditionalData": {
                "reasonPhrase": "OK",
                "statusCode": "200"
            },
            "soapHeaders": {
                "documentInfo": {
                    "documentInfo": {
                        "nsId": "WEBSERVICES_4134291_SB3_11222022159592744339769950_ed53e0a79"
                    }
                }
            }
        }
    }
]
```
- endpoint : api/v2/record?recordType={recordType}  
  Method : PUT  
  Description: Used to update objects on Netsuite by passing the record type and the payload
  Request-BodyType  : application/xml  
  Example: 	 

**Vendor Payment**
```
<?xml version='1.0' encoding='UTF-8'?>
<urn:updateList xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:urn="urn:messages_2020_2.platform.webservices.netsuite.com" xmlns:ns21="urn:purchases_2020_2.transactions.webservices.netsuite.com">
    <urn:record internalId="45590919" xsi:type="ns21:VendorPayment">        
        <ns21:memo>TEST962</ns21:memo>
    </urn:record>
</urn:updateList>
```
**Customer Refund**
```
<?xml version='1.0' encoding='UTF-8'?>
<urn:updateList xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:urn="urn:messages_2020_2.platform.webservices.netsuite.com" xmlns:urn1="urn:customers_2020_2.transactions.webservices.netsuite.com" xmlns:ns21="urn:customers_2020_2.transactions.webservices.netsuite.com">
    <urn:record internalId="45588874" xsi:type="ns21:CustomerRefund">
            <ns21:memo xsi:type="xsd:string">Strawberry13167584</ns21:memo>
    </urn:record>
</urn:updateList>
```
- endpoint : api/v2/savesearch?searchKey={searchKey}&pageSize={pageSize}&limit={limit}
  Method : POST  
  Description: Generic endpoint which will accept the Netsuite request object along with the query parameters to search on Netsuite and return the data.
  Request-BodyType  : application/xml  
  Example: 

**Vendor Payment**
```
<?xml version='1.0' encoding='UTF-8'?>
<ns0:search xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com">
  <ns0:searchRecord xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ns01:TransactionSearchAdvanced" savedSearchId="3041" savedSearchScriptId="customsearch3041">
    <ns03:criteria xmlns:ns03="urn:sales.transactions.webservices.netsuite.com">
      <ns03:basic>
      </ns03:basic>
    </ns03:criteria>
  </ns0:searchRecord>
</ns0:search>
```
**Customer Refund**
```
<?xml version='1.0' encoding='UTF-8'?>
<ns0:search xmlns:ns0="urn:messages_2020_2.platform.webservices.netsuite.com">
  <ns0:searchRecord xmlns:ns01="urn:sales_2020_2.transactions.webservices.netsuite.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ns01:TransactionSearchAdvanced" savedSearchId="5020" savedSearchScriptId="customsearch5020">
    <ns03:criteria xmlns:ns03="urn:sales.transactions.webservices.netsuite.com">
      <ns03:basic>
      </ns03:basic>
    </ns03:criteria>
  </ns0:searchRecord>
</ns0:search>
```
- endpoint : api/v2/file?folderId={folderId}&fileName={fileName}
  Method : POST  
  Description: Endpoint to upload a file to a folder in Netsuite, which will accept the input payload - xml or json (this will be the content of the file), folder and file name. 
  Request-BodyType  : application/xml  or application/json
  Example:

**XML Example**
```
<?xml version='1.0' encoding='UTF-8'?>
<Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <CstmrCdtTrfInitn>
    <GrpHdr>
      <MsgId>655f92cf896f40ee808081fca306f8da</MsgId>
      <CreDtTm>2023-04-18T22:40:16</CreDtTm>
      <NbOfTxs>44</NbOfTxs>
      <CtrlSum>651594.02</CtrlSum>
      <InitgPty>
        <Nm>Flexport Inc</Nm>
      </InitgPty>
    </GrpHdr>
 </CstmrCdtTrfInitn>
</Document>
```
**JSON Example**
```
{
  "Document": {
    "GrpHdr": {
      "MsgId": "655f92cf896f40ee808081fca306f8da",
      "CreDtTm": "2023-04-18T22:40:16",
      "NbOfTxs": "44",
      "CtrlSum": "651594.02",
      "InitgPty": {
        "Nm": "Flexport Inc"
      }
    }
  }
}
```
