//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class ContactUs extends StatefulWidget {
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Contact Us'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            buildhead(),
          ],
        )),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildhead() {
    return Container(
        color: Color(0xffC74F3A),
        width: double.infinity,
        padding: EdgeInsets.only(top: 36.0, bottom: 100.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/contact_us.png',
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 11.0,
            ),
            Text(
              'Need Help？',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 3.0,
            ),
            Text(
              'Contact us 24/7 by selecting NY Channel you prefer below',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600),
            ),
            
            SizedBox(
              height: 150.0,
            ),
            buildReturnButton(),
            SizedBox(
              height: 10.0,
            ),
            buildFaceBookButton(),
            SizedBox(
              height: 10.0,
            ),
            buildCallButton()
          ],
        ));
  }

  buildReturnButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 0.0),
      height: 45.0,
      width: double.infinity,
      child: OutlineButton(
        child: Text('LEAVE FEEDBACK',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
        color: Colors.white,
        highlightedBorderColor: Colors.white,
        borderSide: BorderSide(width: 2.0, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                4.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }

  buildFaceBookButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('FACEBOOK MESSENGER',
            style: TextStyle(
                color: Color(0xffC74F3A),
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
        color: Colors.white,
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                4.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }

  buildCallButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('CALL HOTLINE',
            style: TextStyle(
                color: Color(0xffC74F3A),
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
        color: Colors.white,
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                4.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }
}
