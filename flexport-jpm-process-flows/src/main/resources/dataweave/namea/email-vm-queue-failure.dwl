%dw 2.0
output application/json
---
{
	
	toAddress : p('email.toaddress'),
	emailBody: p('email.body.vmfailure'),
	emailSubject : p('email.subject.vmfailure')
	
}