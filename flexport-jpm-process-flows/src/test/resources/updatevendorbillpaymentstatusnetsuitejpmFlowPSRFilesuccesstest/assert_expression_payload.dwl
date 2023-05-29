%dw 2.0
import * from dw::test::Asserts
---
payload must equalTo([
  {
    OrgnlInstrId: "33739749",
    OrgnlEndToEndId: "2018062512375680",
    TxSts: "ACSP",
    OrgnlTxRef: {
      Amt: {
        InstdAmt: "202.84"
      },
      ReqdExctnDt: "2021-06-02"
    }
  }
])