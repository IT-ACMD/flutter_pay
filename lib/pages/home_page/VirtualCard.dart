//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class VirtualCard extends StatefulWidget {
  _VirtualCardState createState() => _VirtualCardState();
}

class _VirtualCardState extends State<VirtualCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Virtual card'),
        ),
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    buildhead(),
                    buildPhoneTextField(),
                    buildConfirmButton(),
                    SizedBox(
                      height: 100.0,
                    )
                  ],
                ))),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildConfirmButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('ISSUE NOW',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
        color: Color(0xffC74F3A),
        onPressed: () async {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                4.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }

  buildPhoneTextField() {
    return Container(
        margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'choose virtual card type',
              style: TextStyle(
                  color: Color(0xff222222),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 11.0,
            ),
            Row(
              children: <Widget>[
                Image.asset(
                  'images/visa.png',
                ),
                Expanded(
                  child: Container(),
                ),
                Image.asset('images/mastercard.png'),
              ],
            ),
            SizedBox(
              height: 19.0,
            ),
            buildTextField('images/wallet.png'),
            SizedBox(
              height: 13.0,
            ),
            buildTextField('images/at.png'),
            SizedBox(
              height: 13.0,
            ),
            buildTextField('images/phone.png'),
            SizedBox(
              height: 13.0,
            ),
            buildTextField('images/money.png'),
            SizedBox(
              height: 30.0,
            ),
          ],
        ));
  }

  buildTextField(img) {
    return TextField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        border: OutlineInputBorder(),
        prefixIcon: ImageIcon(AssetImage(img)),
      ),
    );
  }

  buildhead() {
    return Container(
        color: Color(0xffC74F3A),
        width: double.infinity,
        padding: EdgeInsets.only(top: 36.0, bottom: 30.0),
        child: Center(
            child: Column(
          children: <Widget>[
            Image.asset(
              'images/virtual_card.png',
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 11.0,
            ),
            Text(
              'Virtual card',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            )
          ],
        )));
  }
}
