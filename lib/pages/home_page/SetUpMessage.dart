//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page/MessageNewMailBox.dart';
import 'package:flutter_app/pages/home_page/MessageNewPhone.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class SetUpMessage extends StatefulWidget {
  _SetUpMessageState createState() => _SetUpMessageState();
}

class _SetUpMessageState extends State<SetUpMessage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff8f8f8),
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Messages receiving'),
        ),
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    buildText(),
                    buildNewPhoneButton(),
                    buildNewMailboxButton(),
                  ],
                ))),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildText() {
    return Container(
        height: 50.0,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(left: 15.0),
        child: Text(
          '+86-17*******79',
          style: TextStyle(
              color: Color(0xff222222),
              fontSize: 18.0,
              fontWeight: FontWeight.w400),
        ));
  }

  buildNewPhoneButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 16.0),
      height: 40.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('Add a new cell phone',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Color(0xffC74F3A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MessageNewPhone();
          }));
        },
      ),
    );
  }

  buildNewMailboxButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 40.0),
      height: 40.0,
      width: double.infinity,
      child: OutlineButton(
        child: Text('Add a new mailbox',
            style: TextStyle(
                color: Color(0xff707070),
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
        highlightedBorderColor: Colors.white,
        borderSide: BorderSide(width: 1.0, color: Color(0xff7F7F7F)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MessageNewMailBox();
          }));
        },
      ),
    );
  }
}
