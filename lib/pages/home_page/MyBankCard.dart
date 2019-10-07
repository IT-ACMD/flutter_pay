//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class MyBankCard extends StatefulWidget {
  _MyBankCardState createState() => _MyBankCardState();
}

class _MyBankCardState extends State<MyBankCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Bank card'),
        ),
        body: Column(
          children: <Widget>[
            buildheadButton(),
          ],
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildheadButton() {
    return Container(
        width: double.infinity,
        height: 50.0,
        color: Color(0xfff8f8f8),
        child: RaisedButton.icon(
          elevation: 0.0,
          icon: Icon(Icons.search),
          color: Colors.white,
          label: Text(
            'Search',
            style: TextStyle(color: Color(0xffa3a3a3)),
          ),
          onPressed: () {},
        ));
  }
}
