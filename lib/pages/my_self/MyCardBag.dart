//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

class MyCardBag extends StatefulWidget {
  _MyCardBagState createState() => _MyCardBagState();
}

class _MyCardBagState extends State<MyCardBag> {
  final redImg = 'images/red_envelopes.png';
  final couImg = 'images/coupon.png';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh My card bag'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            buildOption(redImg, 'Red envelopes', ''),
            Container(
              height: 1.0,
              color: Color(0xffF8F7F7),
            ),
            buildOption(couImg, 'Coupon', ''),
          ],
        )));
  }

  buildOption(image, title, route) {
    return InkWell(
      child: Container(
        color: Colors.white,
        height: 50.0,
        padding: new EdgeInsets.fromLTRB(12.0, 0.0, 10.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Image.asset(image, width: 24.0, height: 24.0),
            new Padding(
              padding: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: Text(title,
                  style: TextStyle(color: Color(0xff222222), fontSize: 16.0)),
            ),
            Expanded(
                child: Align(
                    //padding: EdgeInsets.only(right: 0.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '(0)',
                      style:
                          TextStyle(color: Color(0xff222222), fontSize: 18.0),
                    )))
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
