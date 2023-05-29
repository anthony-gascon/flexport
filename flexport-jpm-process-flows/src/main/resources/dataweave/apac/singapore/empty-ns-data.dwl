%dw 2.0
output application/json
var emailBodyVar = p('apac.singapore.email.body.empty.savedsearch')
var emailSubjectVar = p('apac.singapore.email.subject.empty.savedsearch')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
}