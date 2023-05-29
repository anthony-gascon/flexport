%dw 2.0
output application/json
---
{
	
	toAddress : p('email.toaddress'),
	emailBody: p('email.subject.netsuite'),
	emailSubject : p('email.subject.netsuite'),
	emailAttachment : payload
	
}