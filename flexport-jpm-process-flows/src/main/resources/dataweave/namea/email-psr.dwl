%dw 2.0
output application/json
---
{
	toAddress: p('email.toaddress'),
	emailBody: p('email.subject.psr'),
	emailSubject: p('email.subject.psr'),
	emailAttachment: payload
}