import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/bankData.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'BankSelect.dart';

class MyBankCardModify extends StatefulWidget {
  BankInfo bankInfo;
  MyBankCardModify(BankInfo eBankdata) {
    this.bankInfo = eBankdata;
  }

  @override
  State<StatefulWidget> createState() {
    return new _MyBankCardModifyState();
  }
}

class _MyBankCardModifyState extends State<MyBankCardModify> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  TextEditingController branchController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.bankInfo.cardUser;
    cardController.text = widget.bankInfo.cardNumber;
    branchController.text = widget.bankInfo.branch;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Bank card Modify'),
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
                    widget.bankInfo.bankName = code.name;
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
                          widget.bankInfo.bankName == null
                              ? 'Please choose the bank'
                              : widget.bankInfo.bankName,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: widget.bankInfo.bankName == null
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
                        widget.bankInfo.cardUser = val;
                      },
                      controller: nameController,
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
                        widget.bankInfo.cardNumber = val;
                      },
                      controller: cardController,
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
                        widget.bankInfo.branch = val;
                      },
                      controller: branchController,
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
        child: Text('Modify',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
        color: Color(0xffC74F3A),
        onPressed: () {
          toModifyBankCard();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );
  }

  toModifyBankCard() {
    if (widget.bankInfo == null ||
        widget.bankInfo.bankName == null ||
        widget.bankInfo.branch == null ||
        widget.bankInfo.cardNumber == null ||
        widget.bankInfo.cardUser == null) return;
    //添加到数据库
    Map map = {
      "uuid": widget.bankInfo.id,
      "cardUser": widget.bankInfo.cardUser,
      "bankName": widget.bankInfo.bankName,
      "cardNumber": widget.bankInfo.cardNumber,
      "branch": widget.bankInfo.branch
    };
    ECHttp.postDataJson('user/user-bank/updatebank', map).then((result) {
      if (result != null) {
        var jsonData = json.decode(result);
        if (jsonData['success']) {
          return true;
        }
      }
    });
    Navigator.of(context).pop(true);
  }
}
