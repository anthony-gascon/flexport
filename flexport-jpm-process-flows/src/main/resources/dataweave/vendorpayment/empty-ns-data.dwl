%dw 2.0
output application/json
var emailBodyVar = p('namea.vendor.payment.email.body.empty.savedsearch')
var emailSubjectVar = p('namea.vendor.payment.email.subject.empty.savedsearch')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
}