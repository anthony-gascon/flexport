{
  "inboundAttachmentNames": [],
  "exceptionPayload": null,
  "inboundPropertyNames": [],
  "outboundAttachmentNames": [],
  "payload": {
    "Document": {
      "CstmrPmtStsRpt": {
        "GrpHdr": {
          "MsgId": "M-ID-177326",
          "CreDtTm": "2021-06-01T04:44:43.0Z",
          "InitgPty": {
            "Id": {
              "OrgId": {
                "Othr": {
                  "Id": "JP Morgan",
                  "SchmeNm": {
                    "Cd": "BANK"
                  }
                }
              }
            }
          }
        },
        "OrgnlGrpInfAndSts": {
          "OrgnlMsgId": "5a0ea5d0dcf14f65a0ab92b45360399c",
          "OrgnlMsgNmId": "pain.001",
          "OrgnlNbOfTxs": "45",
          "OrgnlCtrlSum": "4277084.260",
          "GrpSts": "PART",
          "NbOfTxsPerSts": {
            "DtldNbOfTxs": "44",
            "DtldSts": "ACSP",
            "DtldCtrlSum": "4273184.260"
          },
          "NbOfTxsPerSts": {
            "DtldNbOfTxs": "1",
            "DtldSts": "RJCT",
            "DtldCtrlSum": "3900.000"
          }
        },
        "OrgnlPmtInfAndSts": {
          "OrgnlPmtInfId": "BATCHREFERENCE000001",
          "TxInfAndSts": {
            "OrgnlInstrId": "33739749",
            "OrgnlEndToEndId": "2018062512375680",
            "TxSts": "ACSP",
            "OrgnlTxRef": {
              "Amt": {
                "InstdAmt" @("Ccy": "USD"): "202.84"
              },
              "ReqdExctnDt": "2021-06-02"
            }
          }
        }
      }
    }
  },
  "outboundPropertyNames": [],
  "attributes": {
    "symbolicLink": false,
    "regularFile": true,
    "directory": false,
    "path": "/test/1test_JPM_PSR_file_PSOURCE1.xml",
    "size": 1470,
    "name": "1test_JPM_PSR_file_PSOURCE1.xml",
    "timestamp": |2021-06-04T14:15:07|
  }
}