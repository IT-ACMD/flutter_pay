//这是demo页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class DemoPage extends StatefulWidget {
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Pay'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[],
        )),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }
}
