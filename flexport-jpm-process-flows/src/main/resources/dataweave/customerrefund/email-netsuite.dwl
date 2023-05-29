%dw 2.0
output application/json
var emailBodyVar = if(vars.source == ("China")) Mule::p('apac.china.email.body.ns.update') 
				   else if(vars.source == "Hongkong") Mule::p('apac.hongkong.email.body.ns.update')
				   else if(vars.source == "CustomerRefund") Mule::p('namea.customer.refund.email.body.ns.update')	   
				   else Mule::p('apac.singapore.email.body.ns.update') 
				  

var emailSubjectVar = if(vars.source == ("China")) Mule::p('apac.china.email.subject.ns.update') 
					  else if(vars.source == "Hongkong") Mule::p('apac.hongkong.email.subject.ns.update')  
					  else if(vars.source == "CustomerRefund") Mule::p('namea.customer.refund.email.subject.ns.update')
					  else Mule::p('apac.singapore.email.subject.ns.update')
---
{
	toAddress: Mule::p('email.toaddress'),
	emailBody: emailBodyVar,
	emailSubject: emailSubjectVar,
	emailAttachment: payload
}