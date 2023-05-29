%dw 2.0
output application/json
var emailBodyvar = p('apac.hongkong.email.body.vmfailure')
var emailSubjectvar = p('apac.hongkong.email.subject.vmfailure') 
---
{
	
	toAddress : p('email.toaddress'),
	emailBody: emailBodyvar,
	emailSubject : emailSubjectvar
	
}