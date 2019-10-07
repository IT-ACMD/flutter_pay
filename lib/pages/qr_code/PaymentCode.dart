//这是付款码页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentCode extends StatefulWidget {
  _PaymentCodeState createState() => _PaymentCodeState();
}

class _PaymentCodeState extends State<PaymentCode> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Payment code'),
        ),
        body: Container(
            color: Color(0xffDB6B52),
            child: Column(
              children: <Widget>[
                buildhead(),
                buildPhoneTextField(),
              ],
            )));
  }

  buildhead() {
    return Container(
        color: Colors.white,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(27.0, 38.0, 27.0, 10.0),
        child: Center(
            child: Column(
          children: <Widget>[
            ClipPath(
              clipper: TopClipper(),
              child: Container(
                alignment: Alignment.center,
                height: 37.0,
                color: Color(0xffE3AE8A),
                child: Text(
                  'Payment member',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                'View the big picture',
                style: TextStyle(color: Color(0xff222222), fontSize: 12.0),
              ),
            ),
            QrImage(
              version: 5,
              data: '这是二维码的内容个锤字',
              size: 200,
              /*embeddedImage: AssetImage(
                      'images/default_avatar.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(30, 30),
                  ),*/
            ),
            SizedBox(
              height: 26.0,
            ),
            Container(
              height: 1.0,
              color: Color(0xffeeeeee),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 17.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Image.asset(
                        'images/payment_account.png',
                        width: 22.0,
                        height: 22.0,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      'Payment account',
                      style:
                          TextStyle(color: Color(0xff222222), fontSize: 16.0),
                    )),
                  ],
                ),
              ),
              onTap: () {
                //TODO 选择付款账户
              },
            )
          ],
        )));
  }

  buildPhoneTextField() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 13.0),
        padding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Reminder：',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              '*Payment code only supports payment of POS scanner receipts\n'
              '*Do not save pictures or use them for other purposes\n'
              '*Single consumption amount exceeding 2,000, need to enter payment password',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  height: 1.5),
            ),
          ],
        ));
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 13);
    //梯形四点
    path.lineTo(size.width / 3, size.height - 13);
    path.lineTo(size.width / 3 + 5, size.height);
    path.lineTo(size.width / 3 * 2 - 5, size.height);
    path.lineTo(size.width / 3 * 2, size.height - 13);

    path.lineTo(size.width, size.height - 13);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
