%dw 2.0
import * from dw::test::Asserts
var curdate = now()  as String {format: "MM/dd/yyyy"}
---
payload must equalTo([
  {
    "customFieldList": {
      "customField": [
        {
          "DoubleCustomFieldRef__custrecord_jpm_paid_amount": 2866071.98,
          "StringCustomFieldRef__custrecord_jpm_fx_rate": "",
          "StringCustomFieldRef__custrecord_jpm_tran_ref_num": curdate,
          "StringCustomFieldRef__custrecord_jpm_bank_account_number": "000000712538625",
          "StringCustomFieldRef__custrecord_jpm_bank_currency": "USD"
        }
      ]
    }
  },
  {
    "customFieldList": {
      "customField": [
        {
          "DoubleCustomFieldRef__custrecord_jpm_paid_amount": 500.00,
          "StringCustomFieldRef__custrecord_jpm_fx_rate": "",
          "StringCustomFieldRef__custrecord_jpm_tran_ref_num": curdate,
          "StringCustomFieldRef__custrecord_jpm_bank_account_number": "000000712538625",
          "StringCustomFieldRef__custrecord_jpm_bank_currency": "USD"
        }
      ]
    }
  },
  {
    "customFieldList": {
      "customField": [
        {
          "DoubleCustomFieldRef__custrecord_jpm_paid_amount": 394711.89,
          "StringCustomFieldRef__custrecord_jpm_fx_rate": "",
          "StringCustomFieldRef__custrecord_jpm_tran_ref_num": "NONREF",
          "StringCustomFieldRef__custrecord_jpm_bank_account_number": "000000712538625",
          "StringCustomFieldRef__custrecord_jpm_bank_currency": "USD"
        }
      ]
    }
  },
  {
    "customFieldList": {
      "customField": [
        {
          "DoubleCustomFieldRef__custrecord_jpm_paid_amount": 195080.00,
          "StringCustomFieldRef__custrecord_jpm_fx_rate": "",
          "StringCustomFieldRef__custrecord_jpm_tran_ref_num": "NONREF",
          "StringCustomFieldRef__custrecord_jpm_bank_account_number": "000000712538625",
          "StringCustomFieldRef__custrecord_jpm_bank_currency": "USD"
        }
      ]
    }
  },
  {
    "customFieldList": {
      "customField": [
        {
          "DoubleCustomFieldRef__custrecord_jpm_paid_amount": 124922.57,
          "StringCustomFieldRef__custrecord_jpm_fx_rate": "",
          "StringCustomFieldRef__custrecord_jpm_tran_ref_num": "NONREF",
          "StringCustomFieldRef__custrecord_jpm_bank_account_number": "000000712538625",
          "StringCustomFieldRef__custrecord_jpm_bank_currency": "USD"
        }
      ]
    }
  },
  {
    "customFieldList": {
      "customField": [
        {
          "DoubleCustomFieldRef__custrecord_jpm_paid_amount": 67511.28,
          "StringCustomFieldRef__custrecord_jpm_fx_rate": "",
          "StringCustomFieldRef__custrecord_jpm_tran_ref_num": "NONREF",
          "StringCustomFieldRef__custrecord_jpm_bank_account_number": "000000712538625",
          "StringCustomFieldRef__custrecord_jpm_bank_currency": "USD"
        }
      ]
    }
  }
])