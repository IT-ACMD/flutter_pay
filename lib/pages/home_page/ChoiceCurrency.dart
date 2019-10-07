//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class ChoiceCurrency extends StatefulWidget {
  _ChoiceCurrencyState createState() => _ChoiceCurrencyState();
}

class _ChoiceCurrencyState extends State<ChoiceCurrency> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Choice of currency'),
        ),
        body: Column(
          children: <Widget>[
            buildheadButton(),
            buildText(),
            buildListview(context),
          ],
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildheadButton() {
    return Container(
        color: Color(0xffececec),
        child: FlatButton(
          color: Colors.white,
          child: Text(
            'Search for currency names or abbreviations',
            style: TextStyle(color: Color(0xffa3a3a3)),
          ),
          onPressed: () {},
        ));
  }

  buildText() {
    return Container(
        color: Color(0xfff8f8f8),
        child: Text(
          'Currency in common use',
          style: TextStyle(color: Color(0xff222222)),
        ));
  }

  buildListview(context) {
    return Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                'USD',
                style: TextStyle(color: Color(0xff222222), fontSize: 16.0),
              ),
            );
          },
        ));
  }
}
