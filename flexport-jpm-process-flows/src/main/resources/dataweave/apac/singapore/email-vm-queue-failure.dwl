%dw 2.0
output application/json
var emailBodyvar = p('apac.singapore.email.body.vmfailure')
var emailSubjectvar = p('apac.singapore.email.subject.vmfailure')
---
{
	
	toAddress : p('email.toaddress'),
	emailBody: emailBodyvar,
	emailSubject : emailSubjectvar
	
}