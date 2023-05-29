%dw 2.0
output application/json
var emailBodyVar = p('apac.china.email.body.mapping.savedsearch')
var emailSubjectVar = p('apac.china.email.subject.mapping.savedsearch')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
	emailAttachment: payload
}