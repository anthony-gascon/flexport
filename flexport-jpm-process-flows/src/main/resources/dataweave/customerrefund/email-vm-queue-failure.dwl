%dw 2.0
output application/json
var emailBodyvar = p('namea.customer.refund.email.body.vmfailure')
var emailSubjectvar = p('namea.customer.refund.email.subject.vmfailure')
---
{
	toAddress: p('email.toaddress'),
	emailBody: emailBodyvar,
	emailSubject: emailSubjectvar
}