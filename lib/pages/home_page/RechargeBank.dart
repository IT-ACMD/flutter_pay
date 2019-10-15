//这是转账页面
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/accountData.dart';
import 'package:flutter_app/data/bankData.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/pages/my_self/MyBankCardAdd.dart';
import 'package:flutter_app/services/AccountService.dart';
import 'package:flutter_app/services/BankService.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';
import 'PaymentPwd.dart';

class RechargeBank extends StatefulWidget {
  _RechargeBankState createState() => _RechargeBankState();
}

class _RechargeBankState extends State<RechargeBank> {
  AccountData _selectedAccount = eDefaulAccount;
  BankInfo _selectedBank = BankInfo();
  String _amountTransfer = '0.0';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Recharge'),
        ),
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    buildSelectAccount(),
                    Container(
                      color: Color(0xffeeeeee),
                      height: 1.0,
                    ),
                    buildPhoneTextField(),
                    Container(
                      color: Color(0xffeeeeee),
                      height: 1.0,
                    ),
                    buildBankCardChoose(),
                    Container(
                      color: Color(0xffeeeeee),
                      height: 1.0,
                    ),
                    buildConfirmButton(),
                  ],
                ))),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildSelectAccount() {
    return new GestureDetector(
      onTap: () {
        AccountService.showAcoutBottomSelect(context).then((index) {
          _selectedAccount = eAccountList[index];
          setState(() {});
        });
      },
      child: new Container(
        color: Colors.white,
        margin: new EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                'currency',
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff222222)),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 0.0),
              child: new Text(
                _selectedAccount.currency_code,
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff9A9A9A)),
              ),
            ),
            Image.asset(
              'images/arrow_right.png',
              width: 16.0,
              height: 16.0,
              fit: BoxFit.contain,
            ),
            Container(
              width: 11.0,
            )
          ],
        ),
      ),
    );
  }

  buildConfirmButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 15.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('Recharge',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Color(0xffC74F3A),
        onPressed: () {
          if (_selectedBank.id == null) {
            return showAlertDialog(this.context, 'Please select bank card');
          }
          if (_amountTransfer == null ||
              double.parse(_amountTransfer).isNaN ||
              double.parse(_amountTransfer) <= 0) {
            return showAlertDialog(
                this.context, 'Please enter the correct amount balance');
          }
          showModalBottomSheet<bool>(
            context: context,
            builder: (BuildContext context) {
              return PaymentPwd(context);
            },
          ).then((res) {
            if (!res) return;
            String url = "account/recharge";
            Map param = {
              "uuid": _selectedBank.id, //银行卡id
              "currencyUuid": _selectedAccount.currency_uuid, //币种
              "amount": _amountTransfer //转账额度
            };
            ECHttp.postDataJson(url, param).then((res) {
              if (res != null && res.length > 0) {
                var jsonData = json.decode(res);
                if (jsonData['success']) {
                  showAlertDialog(this.context, 'Recharge success').then((res) {
                    _selectedAccount.amount =
                        (double.parse(_selectedAccount.amount) -
                                double.parse(_amountTransfer))
                            .toString();
                    Navigator.of(context).pushNamed('home');
                  });
                }
              }
            });
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                4.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }

  //手机号登录文本框
  buildPhoneTextField() {
    return Container(
        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              'images/rmb.png',
              color: Color(0xff222222),
            ),
            Expanded(
                child: TextField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [
                _UsNumberTextInputFormatter(),
                LengthLimitingTextInputFormatter(6)
              ],
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'balance', //：${_selectedAccount.amount}',
                border: InputBorder.none,
              ),
              onChanged: (val) {
                //if (double.parse(val) <= double.parse(eDefaulAccount.amount)) {
                _amountTransfer = val;
                //}
              },
            )),
          ],
        ));
  }

  //选择银行卡
  buildBankCardChoose() {
    String text = 'Choose a bank card';
    if (_selectedBank.bankName != null && _selectedBank.bankName.length > 0)
      text = _selectedBank.bankName;
    return GestureDetector(
      onTap: () {
        if (eBankdatas.length <= 0) {
          ;
          return showMessageTwo(context,
                  'You do not have a bank card, whether to add a new bank card?')
              .then((setBank) {
            if (setBank) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return MyBankCardAdd();
              }));
            }
          });
        }
        BankService.showBankBottomSelect(context).then((index) {
          _selectedBank = eBankdatas[index];
          setState(() {});
        });
      },
      child: new Container(
        margin: new EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 5.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                text,
                style:
                    TextStyle(fontSize: 16.0, color: const Color(0xff222222)),
              ),
            ),
            Image.asset(
              'images/arrow_right.png',
              width: 16.0,
              height: 16.0,
              fit: BoxFit.contain,
            ),
            Container(
              width: 11.0,
            )
          ],
        ),
      ),
    );
  }
}

// 只允许输入小数
class _UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" &&
        value != defaultDouble.toString() &&
        strToFloat(value, defaultDouble) == defaultDouble) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
