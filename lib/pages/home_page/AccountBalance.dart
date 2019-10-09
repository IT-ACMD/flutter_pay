//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class AccountBalance extends StatefulWidget {
  _AccountBalanceState createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
  @override
  void initState() {
    getAccountList().then((res) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Account balance'),
        ),
        body: ListView.builder(
          itemCount: eAccountList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                '${eAccountList[index].currency_code}',
                style: TextStyle(color: Color(0xff222222), fontSize: 16.0),
              ),
              trailing: Text(
                '${eAccountList[index].amount}',
                style: TextStyle(color: Color(0xffC74F3A), fontSize: 18.0),
              ),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }
}
