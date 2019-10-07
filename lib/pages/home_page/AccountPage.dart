//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

class AccountPage extends StatefulWidget {
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Account'),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: <Widget>[
            buildhead(),
            buildPhoneTextField(),
          ],
        ))));
  }
  
  buildPhoneTextField() {
    return Container(
        color: Colors.white,
        width: double.infinity,
        margin: EdgeInsets.only(top: 13.0),
        padding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Mobile Savings Account',
              style: TextStyle(
                  color: Color(0xff222222),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'our most popular bank account that helps you reach saving goals with competitive interest rate and other features',
              style: TextStyle(
                  color: Color(0xff8A8A8A), fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8.0,
            ),
            InkWell(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'OPEN NEW ACCOUNT',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xffC74F3A),
                      fontWeight: FontWeight.w500),
                ),
                Image.asset(
                  'images/forward.png',
                  height: 12.0,
                  width: 12.0,
                  fit: BoxFit.contain,
                  color: Color(0xffC74F3A),
                )
              ],
            ))
          ],
        ));
  }

  buildhead() {
    return Container(
        color: Color(0xffC74F3A),
        width: double.infinity,
        padding: EdgeInsets.only(top: 36.0, bottom: 30.0),
        child: Center(
            child: Column(
          children: <Widget>[
            Image.asset(
              'images/account.png',
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 11.0,
            ),
            Text(
              'Account',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            )
          ],
        )));
  }
}
