%dw 2.0
output application/json
import java!org::apache::commons::lang3::StringUtils
import * from dw::core::Arrays
var currencies = readUrl('classpath://data\currency.json')
var sym = readUrl('classpath://data\europeanAccentCharacters.json')
var currency = (currencies map  {
	($.ID) : $.Code
})
fun replaceEuroChar(entityId) = StringUtils::stripAccents(entityId) splitBy  ""
fun  mapping (item) = if ( sym.k contains item ) sym.v[indexOf(sym.k ,item)] else item
fun vendorName (data) = (data map ((item, index) -> mapping(item) )) reduce ((item, accumulator) -> accumulator ++ item)
---
payload map ((item, index) -> {
	basic: {
		'type': item.basic.'type'.searchValue,
		memo: item.basic.memo.searchValue,
		postingPeriod: item.basic.memo.searchValue,
		account: item.basic.account.searchValue,
		department: item.basic.department.searchValue."@internalId",
		entity: item.basic.entity.searchValue."@internalId",
		amount: abs(item.basic.fxAmount.searchValue),
		internalId: item.basic.internalId.searchValue."@internalId",
		tranDate: item.basic.tranDate.searchValue,
		tranId: item.basic.tranId.searchValue,
		currency: currency[item.basic.currency.searchValue.'@internalId'][0],
		transactionNumber: item.basic.transactionNumber.searchValue,
		(item.basic.customFieldList mapObject ((value, key, index) -> {
			(value."@scriptId"): value.searchValue
		}))
	},
	customerMainJoin: {
		altName: item.customerMainJoin.altName.searchValue,
		billState : item.customerMainJoin.billState.searchValue,
		billAddress1 : item.customerMainJoin.billAddress1.searchValue,
		billZipCode : item.customerMainJoin.billZipCode.searchValue,
		billCity:  item.customerMainJoin.billCity.searchValue,
		billCountry: item.customerMainJoin.billCountry.searchValue,
		billCountryCode: item.customerMainJoin.billCountryCode.searchValue,
		(item.customerMainJoin.customFieldList mapObject ((value, key, index) -> {
			(value."@scriptId"): value.searchValue
		}))
	},
	customSearchJoin: {
		customFieldList :(item.customSearchJoin.searchRowBasic.customFieldList mapObject ((value, key, index) -> {
			(value."@scriptId"): value.searchValue
		}))
	}
})