//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page/TransferAccountsConfirm.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class TransferAccounts extends StatefulWidget {
  _TransferAccountsState createState() => _TransferAccountsState();
}

class _TransferAccountsState extends State<TransferAccounts> {
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
                color: Color(0xffF8F8F8),
                child: Column(
                  children: <Widget>[
                    buildPhoneTextField(),
                    buildHintText(),
                    buildNextButton(),
                  ],
                ))),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildNextButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('Next step',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Color(0xffC74F3A),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return TransferAccountsConfirm();
          }));
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
        margin: EdgeInsets.only(top: 15.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
              //controller: _controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Counter account',
                hintStyle: TextStyle(color: Color(0xff222222), fontSize: 16.0),
                border: InputBorder.none,
              ),
            )),
            Padding(
                child: Image.asset(
                  'images/account_people_shape.png',
                  fit: BoxFit.cover,
                ),
                padding: EdgeInsets.fromLTRB(0.0, 14.0, 15.0, 14.0)),
          ],
        ));
  }

  buildHintText() {
    return Padding(
      child: Text(
        'Money will be transferred to each other\'s account in real time and cannot be returned.',
        style: TextStyle(fontSize: 12.0, color: Color(0xffAEAEAE)),
      ),
      padding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 15.0),
    );
  }
}
