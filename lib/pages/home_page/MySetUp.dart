//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class MySetUp extends StatefulWidget {
  _MySetUpState createState() => _MySetUpState();
}

class _MySetUpState extends State<MySetUp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Set up'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            buildOption('Account displays', '', 1, ''),
            Container(
              height: 1.0,
              color: Color(0xffF8F7F7),
            ),
            buildOption('Messages receiving', '', 1, '消息接收'),
            Container(
              height: 1.0,
              color: Color(0xffF8F7F7),
            ),
            buildOption('Edition', 'V2.7.0', 0, ''),
            buildLogoutButton(),
          ],
        )),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildOption(title, value, type, route) {
    Widget imageW = Image.asset(
      'images/forward.png',
      height: 20.0,
      width: 20.0,
    );

    Widget valueW = Text(
      value,
      style: TextStyle(color: Color(0xff222222), fontSize: 18.0),
    );

    return InkWell(
      child: Container(
        color: Colors.white,
        height: 50.0,
        padding: new EdgeInsets.fromLTRB(12.0, 0.0, 10.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: Text(title,
                  style: TextStyle(color: Color(0xff222222), fontSize: 16.0)),
            ),
            Expanded(
                child: Align(
              //padding: EdgeInsets.only(right: 0.0),
              alignment: Alignment.centerRight,
              child: type == 1 ? imageW : valueW,
            ))
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  buildLogoutButton() {
    return Container(
      margin: EdgeInsets.only(
          top: 34.0, left: 40.0, right: 40.0, bottom: 10.0), //270 * 420/160
      height: 45.0,
      width: double.infinity,
      child: OutlineButton(
        child: Text('Logout',
            style: TextStyle(
                color: Color(0xff8F8F8F),
                fontSize: 18.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Colors.white,
        borderSide: BorderSide(width: 1.0, color: Color(0xffd6d6d6)),
        onPressed: () {
          showMessageTwo(context,
                  'After the exit will not delete any historical data, the next login can still use the account.')
              .then((res) {
            if (res) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                28.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }
}
