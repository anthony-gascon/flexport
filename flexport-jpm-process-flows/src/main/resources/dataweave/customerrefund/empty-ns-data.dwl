%dw 2.0
output application/json
var emailBodyVar = p('namea.customer.refund.email.body.empty.savedsearch')
var emailSubjectVar = p('namea.customer.refund.email.subject.empty.savedsearch')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
}