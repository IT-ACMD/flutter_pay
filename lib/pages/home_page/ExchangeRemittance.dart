//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page/ChoiceCurrency.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class ExchangeRemittance extends StatefulWidget {
  _ExchangeRemittanceState createState() => _ExchangeRemittanceState();
}

class _ExchangeRemittanceState extends State<ExchangeRemittance> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Exchange remittance'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Color(0xffCB604E),
              height: 160.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  buildText(),
                  buildCard()
                ],
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildText() {
    return Text.rich(
      TextSpan(
          text: 'Excellent exchange rate pen saving',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              height: 1.25),
          children: <TextSpan>[
            TextSpan(
                text: '\nNo currency conversion fee\nHow much to pay',
                style: TextStyle(fontSize: 16.0, color: Color(0xffFBC0B6))),
          ]),
      softWrap: false,
    );
  }

  buildCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      margin: EdgeInsets.all(20.0),
      color: Colors.white,
      //semanticContainer: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Update 1 minute ago',
              style: TextStyle(color: Color(0xff727272)),
            ),
          ),
          buildAccount('images/usd.png', 'USD', '100', ''),
          Container(
            height: 1.0,
            color: Color(0xffF8F7F7),
          ),
          buildAccount('images/cny.png', 'CNY', '713.21', ''),
          Container(
            height: 1.0,
            color: Color(0xffF8F7F7),
          ),
          SizedBox(
            height: 70.0,
          )
        ],
      ),
    );
  }

  buildAccount(url, title, value, link) {
    return Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            Image.asset(
              url,
              width: 33.0,
              height: 20.0,
            ),
            SizedBox(
              width: 6.0,
            ),
            Text(
              title,
              style: TextStyle(color: Color(0xff727272), fontSize: 16.0),
            ),
            SizedBox(
              width: 13.0,
            ),
            InkWell(
              child: Image.asset(
                'images/forward.png',
                width: 16.0,
                height: 16.0,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ChoiceCurrency();
                }));
              },
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              value,
              style: TextStyle(
                  color: Color(0xff222222),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5.0,
            ),
          ],
        ));
  }
}
