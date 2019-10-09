import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/bankData.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'BankSelect.dart';

class MyBankCardAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyBankCardAddState();
  }
}

class _MyBankCardAddState extends State<MyBankCardAdd> {
  BankInfo newbank = BankInfo();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Personal information'),
        ),
        body: new Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              new GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return BankSelect();
                  })).then((code) {
                    newbank.bankName = code.name;
                    setState(() {});
                  });
                },
                child: new Container(
                  margin: new EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                  height: 48.0,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          'Bank',
                          style: TextStyle(
                              fontSize: 16.0, color: const Color(0xff222222)),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 0.0),
                        child: new Text(
                          newbank.bankName == null
                              ? 'Please choose the bank'
                              : newbank.bankName,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: newbank.bankName == null
                                  ? Color(0xff9A9A9A)
                                  : Color(0xff222222)),
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
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 16.0, color: const Color(0xff222222)),
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (val) {
                        newbank.cardUser = val;
                      },
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(color: Color(0xff222222), fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Name of cardholder',
                        hintStyle: TextStyle(
                            fontSize: 16.0, color: const Color(0xff9A9A9A)),
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Card number',
                      style: TextStyle(
                          fontSize: 16.0, color: const Color(0xff222222)),
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (val) {
                        newbank.cardNumber = val;
                      },
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(color: Color(0xff222222), fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Please enter the card number',
                        hintStyle: TextStyle(
                            fontSize: 16.0, color: const Color(0xff9A9A9A)),
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Text(
                      'Sub branch',
                      style: TextStyle(
                          fontSize: 16.0, color: const Color(0xff222222)),
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (val) {
                        newbank.branch = val;
                      },
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(color: Color(0xff222222), fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: 'Bank Card Branch',
                        hintStyle: TextStyle(
                            fontSize: 16.0, color: const Color(0xff9A9A9A)),
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              buildCashWithDrawalButton(),
              new Expanded(
                child: new Container(
                  color: const Color(0xffF8F8F8),
                ),
              )
            ],
          ),
        ));
  }

  buildCashWithDrawalButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 33.0, 15.0, 10.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('Add to',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
        color: Color(0xffC74F3A),
        onPressed: () {
          if (newbank == null ||
              newbank.bankName == null ||
              newbank.branch == null ||
              newbank.cardNumber == null ||
              newbank.cardUser == null) return;
          //添加到数据库
          Map map = {
            "cardUser": newbank.cardUser,
            "bankName": newbank.bankName,
            "cardNumber": newbank.cardNumber,
            "branch": newbank.branch
          };
          ECHttp.postDataJson('user/user-bank/insertbank', map).then((result) {
            if (result != null) {
              var jsonData = json.decode(result);
              if (jsonData['success']) {
                return true;
              }
            }
          });
          Navigator.of(context).pop(true);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );
  }
}
