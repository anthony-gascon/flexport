%dw 2.0
output application/json
var emailBodyVar = if(vars.source == ("China")) Mule::p('apac.china.email.body.ns.update') else
				   if(vars.source == "Hongkong") Mule::p('apac.hongkong.email.body.ns.update')  else 
				   Mule::p('email.subject.netsuite')

var emailSubjectVar = if(vars.source == ("China")) Mule::p('apac.china.email.subject.ns.update') else 
					  if(vars.source == "Hongkong") Mule::p('apac.hongkong.email.subject.ns.update')  else 
				      Mule::p('email.subject.netsuite')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
	emailAttachment: payload
}