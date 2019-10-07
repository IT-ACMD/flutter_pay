//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class MessageNewMailBox extends StatefulWidget {
  _MessageNewMailBoxState createState() => _MessageNewMailBoxState();
}

class _MessageNewMailBoxState extends State<MessageNewMailBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff8f8f8),
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Add a new cell phone'),
        ),
        body: SingleChildScrollView(
            child: Container(
                color: Color(0xfff8f8f8),
                child: Column(
                  children: <Widget>[
                    buildPhoneTextField(),
                    buildNewPhoneButton(),
                  ],
                ))),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildPhoneTextField() {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                hintText: ' new mailbox',
                hintStyle: TextStyle(color: Color(0xff222222), fontSize: 18.0),
                border: InputBorder.none,
              ),
            )),
          ],
        ));
  }

  buildNewPhoneButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 16.0),
      height: 40.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('Add to',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Color(0xffC74F3A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        onPressed: () {},
      ),
    );
  }
}
