%dw 2.0
output application/json
var emailBodyVar = if(vars.fileName contains ("China")) Mule::p('apac.china.email.subject.psr') 
				   else if(vars.fileName contains ("Hongkong")) Mule::p('apac.hongkong.email.subject.psr')
				   else if (vars.fileName contains ("Singapore")) Mule::p('apac.singapore.email.subject.psr')
            	   else Mule::p('email.subject.psr')


var emailSubjectVar = if(vars.fileName contains ("China")) Mule::p('apac.china.email.subject.psr') 
                      else if(vars.fileName contains ("Hongkong")) Mule::p('apac.hongkong.email.subject.psr')  
                      else if (vars.fileName contains ("Singapore")) Mule::p('apac.singapore.email.subject.psr')
                      else Mule::p('email.subject.psr')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
	emailAttachment: payload
}