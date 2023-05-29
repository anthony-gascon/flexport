%dw 2.0
output application/json
var emailBodyVar = p('apac.hongkong.email.body.empty.savedsearch')
var emailSubjectVar = p('apac.hongkong.email.subject.empty.savedsearch')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
}