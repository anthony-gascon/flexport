%dw 2.0
output application/json
---
{
	
	toAddress : p('email.toaddress'),
	emailBody: p('email.subject.gach'),
	emailSubject : p('email.subject.gach'),
	emailAttachment : payload
	
}