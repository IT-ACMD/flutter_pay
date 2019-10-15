//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class CashWithDrawal extends StatefulWidget {
  _CashWithDrawalState createState() => _CashWithDrawalState();
}

class _CashWithDrawalState extends State<CashWithDrawal> {
  final bankImg = 'images/cash_to_bank_card.png';
  final dtodImg = 'images/dtod_recharge.png';
  final dotImg = 'images/dot_recharge.png';

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
            buildOption(
                bankImg,
                'Cash to Bank Card',
                '\nMoney will be presented to your designated bank\n card, convenient and fast!',
                '提现银行卡'),
            Container(
              height: 1.0,
              color: Color(0xffF8F7F7),
            ),
            buildOption(dtodImg, 'Cash on Reservation \n(door-to-door service)',
                '\nService time：9：00-17：00', '预约充值'),
            Container(
              height: 1.0,
              color: Color(0xffF8F7F7),
            ),
            buildOption(dotImg, 'Dot gain',
                '\nAll outlets in the city can go to the store for free', ''),
          ],
        )),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildOption(image, title, description, route) {
    return InkWell(
      child: Container(
        color: Colors.white,
        height: 65.0,
        padding: new EdgeInsets.fromLTRB(12.0, 0.0, 10.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Image.asset(image, width: 42.0, height: 42.0),
            new Padding(
                padding: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text.rich(
                  TextSpan(
                      text: title,
                      style:
                          TextStyle(color: Color(0xff222222), fontSize: 16.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: description,
                          style: TextStyle(
                              color: Color(0xff929292), fontSize: 10.0),
                        )
                      ]),
                  softWrap: true,
                )),
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
        Navigator.pushNamed(context, route);
      },
    );
  }
}
