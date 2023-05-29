%dw 2.0
output application/json
var emailBodyVar = p('apac.singapore.email.body.mapping.savedsearch')
var emailSubjectVar = p('apac.singapore.email.subject.mapping.savedsearch')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
	emailAttachment: payload
}