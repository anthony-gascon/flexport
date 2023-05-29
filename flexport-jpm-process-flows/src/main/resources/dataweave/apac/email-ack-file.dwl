%dw 2.0
output application/json
var emailBodyVar = if(vars.source == ("China")) Mule::p('apac.china.email.body.ack.file') 
				   else if(vars.source == "Hongkong") Mule::p('apac.hongkong.email.body.ack.file')
				   else if(vars.source == "Singapore") Mule::p('apac.singapore.email.body.ack.file') 
				   else Mule::p('email.subject.netsuite')

var emailSubjectVar = if(vars.source == ("China")) Mule::p('apac.china.email.subject.ack.file') 
					  else if(vars.source == "Hongkong") Mule::p('apac.hongkong.email.subject.ack.file') 
					  else if (vars.source == "Singapore") Mule::p('apac.singapore.email.subject.ack.file')
					  else Mule::p('email.subject.netsuite')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar
	}