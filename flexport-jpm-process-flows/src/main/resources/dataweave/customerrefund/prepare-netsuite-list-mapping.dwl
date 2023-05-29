%dw 2.0
output application/java 
--- 
(vars.payloadCopy.internalId  map ( (item,index) -> {
	
	internalId  : item,
	customFieldList :{
		customField : [
			StringCustomFieldRef__custbody_jpm_payment_file_name : vars.setFileName replace  "/" with "" ++  vars.uuid,
			BooleanCustomFieldRef__custbody_payment_sent_jpm : true
		]
	}
	
}	
)) 