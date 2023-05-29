%dw 2.0
output application/json
var emailBodyvar = p('apac.china.email.body.vmfailure')
var emailSubjectvar = p('apac.china.email.subject.vmfailure')
---
{
	
	toAddress : p('email.toaddress'),
	emailBody: emailBodyvar,
	emailSubject : emailSubjectvar
	
}