//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class RechargeDtod extends StatefulWidget {
  _RechargeDtodState createState() => _RechargeDtodState();
}

class _RechargeDtodState extends State<RechargeDtod> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Cash withdrawal'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Text(
                  'Amount limitation：money（100-10000）\n\nService time：09：00-17：00（Mon-Sat）'
                  '\n\nService Description: Call customer service phone to'
                  'book cash, 2 hoursdoor-to-door delivery of money (service charge: 5 single pens)'
                  '\n\nHotline：+855-23230800\n\nScope of service: the periphery of service outlets',
                  style: TextStyle(color: Color(0xff222222), height: 1.25),
                )),
            buildCallButton(),
            buildReturnButton()
          ],
        )),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildCallButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('Call up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Color(0xffC74F3A),
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                4.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }

  buildReturnButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 16.0, 15.0, 24.0),
      height: 45.0,
      width: double.infinity,
      child: OutlineButton(
        child: Text('Return',
            style: TextStyle(
                color: Color(0xff8F8F8F),
                fontSize: 16.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        highlightedBorderColor: Color(0xff8F8F8F),
        borderSide: BorderSide(width: 2.0, color: Color(0xff8F8F8F)),
        onPressed: () {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                4.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }
}
