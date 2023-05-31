%dw 2.0
output application/json
var emailBodyVar = p('namea.vendor.payment.email.body.mapping.savedsearch')
var emailSubjectVar = p('namea.vendor.payment.email.subject.mapping.savedsearch')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
	emailAttachment: payload
}