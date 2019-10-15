//这是转账页面
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/accountData.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/services/AccountService.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';
import 'PaymentPwd.dart';

class TransferAccountsConfirm extends StatefulWidget {
  String cardId = '';
  TransferAccountsConfirm(String cardId) {
    this.cardId = cardId;
  }

  _TransferAccountsConfirmState createState() =>
      _TransferAccountsConfirmState();
}

class _TransferAccountsConfirmState extends State<TransferAccountsConfirm> {
  AccountData _selectedAccount = eDefaulAccount;
  String _amountTransfer = '0.0';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Transfer accounts'),
        ),
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    buildhead(),
                    buildSelectAccount(),
                    buildPhoneTextField(),
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
        margin: new EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
        height: 48.0,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                'Currency',
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
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('Confirm transfer',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Color(0xffC74F3A),
        onPressed: () {
          showModalBottomSheet<bool>(
            context: context,
            builder: (BuildContext context) {
              return PaymentPwd(context);
            },
          ).then((res) {
            if (!res) return;
            String url = "account/Transfer";
            Map param = {
              "currencyUuid": _selectedAccount.currency_uuid, //币种
              "userUuid": widget.cardId, //被转账卡号
              "amount": _amountTransfer //转账额度
            };
            //showLoadingDialog(this.context, '正在转账中,请稍后。。。');
            ECHttp.postDataJson(url, param).then((res) {
              if (res != null && res.length > 0) {
                var jsonData = json.decode(res);
                if (jsonData['success']) {
                  //showLoadingDialog(this.context, '已转账成功');
                  showAlertDialog(this.context, 'Transfer success').then((res) {
                    _selectedAccount.amount =
                        (double.parse(_selectedAccount.amount) -
                                double.parse(_amountTransfer))
                            .toString();
                    Navigator.of(context).pushNamed('home');
                  });
                }
              }
            });
            //showLoadingDialog(this.context, '正在转账中,请稍后。。。');
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
        margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Transfer amount',
              style: TextStyle(color: Color(0xff222222), fontSize: 16.0),
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [_UsNumberTextInputFormatter()],
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15.0),
                  prefixIcon: ImageIcon(
                    AssetImage('images/rmb.png'),
                    color: Color(0xff222222),
                  ),
                  hintText: 'balance：${_selectedAccount.amount}'),
              onChanged: (val) {
                if (double.parse(val) <= double.parse(eDefaulAccount.amount)) {
                  _amountTransfer = val;
                }
              },
            ),
          ],
        ));
  }

  buildhead() {
    return Container(
        padding: EdgeInsets.only(top: 50.0, bottom: 34.0),
        child: Image.asset(
          'images/default_avatar.png',
          height: 80.0,
          width: 80.0,
          fit: BoxFit.contain,
        ));
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
