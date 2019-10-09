//这是收款码页面
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/qr_code/ReceiptAmount.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiptCode extends StatefulWidget {
  _ReceiptCodeState createState() => _ReceiptCodeState();
}

class _ReceiptCodeState extends State<ReceiptCode> {
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
            Container(
              padding: EdgeInsets.only(top: 23.0, bottom: 19.0),
              alignment: Alignment.center,
              child: Text(
                'Sweep and pay me',
                style: TextStyle(
                    color: Color(0xff222222),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            QrImage(
              version: 5,
              data: '这是收款码',
              size: 200,
            ),
            SizedBox(
              height: 26.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Text('Set amount',
                      style: TextStyle(
                          color: Color(0xff222222),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return ReceiptAmount(); 
                    }));
                  },
                ),
                Text(' | ',
                    style: TextStyle(
                        color: Color(0xffE1E1E1),
                        fontSize: 20.0,
                        letterSpacing: 5.0)),
                Text('Save pictures',
                    style: TextStyle(
                        color: Color(0xff222222),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(
              height: 26.0,
            )
          ],
        )));
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
