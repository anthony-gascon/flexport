%dw 2.0
output application/json
var emailBodyVar = if(vars.fileName contains ("Hongkong")) p('apac.hongkong.email.subject.psr') else ""
var emailSubjectVar = if(vars.fileName contains ("Hongkong")) p('apac.hongkong.email.subject.psr') else ""
---
{
	toAddress: p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
	emailAttachment: payload
}