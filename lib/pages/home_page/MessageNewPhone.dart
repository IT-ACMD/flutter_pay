//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class MessageNewPhone extends StatefulWidget {
  _MessageNewPhoneState createState() => _MessageNewPhoneState();
}

class _MessageNewPhoneState extends State<MessageNewPhone> {
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
                    buildText(),
                    Container(
                      color: Color(0xffeeeeee),
                      height: 1.0,
                    ),
                    buildPhoneTextField(),
                    buildNewPhoneButton(),
                  ],
                ))),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildText() {
    return InkWell(
      child: Container(
        color: Colors.white,
        height: 50.0,
        margin: new EdgeInsets.only(top: 10.0),
        child: new Row(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: Text('Country or region',
                  style: TextStyle(color: Color(0xff222222), fontSize: 16.0)),
            ),
            Expanded(
                child: Align(
              //padding: EdgeInsets.only(right: 0.0),
              alignment: Alignment.centerRight,
              child: Image.asset(
                'images/forward.png',
                height: 20.0,
                width: 20.0,
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        //Navigator.pushNamed(context, route);
      },
    );
  }

  buildPhoneTextField() {
    return Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Padding(
                child: Text(
                  '+855',
                  style: TextStyle(fontSize: 16.0, color: Color(0xff222222)),
                ),
                padding: EdgeInsets.fromLTRB(15.0, 14.0, 30.0, 14.0)),
            Expanded(
                child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: '',
                hintStyle: TextStyle(color: Color(0xffadadad), fontSize: 16.0),
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
