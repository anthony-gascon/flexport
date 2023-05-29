%dw 2.0
output application/json
var emailBodyVar =  Mule::p('namea.customer.refund.email.body.ack.file')
var emailSubjectVar = Mule::p('namea.customer.refund.email.subject.ack.file')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar
}