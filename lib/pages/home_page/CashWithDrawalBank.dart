import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/check_sex_dialog.dart';
import 'package:flutter_app/widget/title_barA.dart';

class CashWithDrawalBank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CashWithDrawalBankState();
  }
}

class _CashWithDrawalBankState extends State<CashWithDrawalBank> {
  var defaultAvatar = 'images/default_avatar.png';
  var nikeName = 'xiaoxiao';
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Personal information'),
        ),
        body: new Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              new Container(
                height: 10.0,
                color: const Color(0xffF8F8F8),
              ),
              new GestureDetector(
                onTap: () {
                },
                child: new Container(
                  margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  height: 48.0,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          'CNY（0.00）',
                          style: TextStyle(
                              fontSize: 16.0, color: const Color(0xff222222)),
                        ),
                      ),
                      Image.asset(
                        'images/forward.png',
                        width: 16.0,
                        height: 16.0,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        width: 11.0,
                      )
                    ],
                  ),
                ),
              ),
              new Container(
                height: 10.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        'Card number',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff222222)),
                      ),
                    ),
                    new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                        child: Image.asset(
                          'images/card_number.png',
                          fit: BoxFit.contain,
                        )),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff222222)),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                      child: new Text(
                        'Name of cardholder',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff9A9A9A)),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new GestureDetector(
                //onTap: _showCheckSexDiaolog,
                child: new Container(
                  margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  height: 48.0,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          'Bank',
                          style: TextStyle(
                              fontSize: 16.0, color: const Color(0xff222222)),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 0.0),
                        child: new Text(
                          'Please choose the bank',
                          style: TextStyle(
                              fontSize: 16.0, color: const Color(0xff9A9A9A)),
                        ),
                      ),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 16.0,
                        height: 16.0,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        width: 11.0,
                      )
                    ],
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        'Amount of money',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff222222)),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                      child: new Text(
                        '',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff9A9A9A)),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              buildCashWithDrawalButton(),
              buildAutoSave(),
              new Expanded(
                child: new Container(
                  color: const Color(0xffF8F8F8),
                ),
              )
            ],
          ),
        ));
  }

  buildCashWithDrawalButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 33.0, 15.0, 10.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child: Text('Cash withdrawal',
            style: TextStyle(color: Colors.white, fontSize: 18.0)),
        color: Color(0xffC74F3A),
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );
  }

  Color selectRadioColor = Color(0xffC74F3A);
  Color unSelectRadioColor = Color(0xff949494);
  Color _radioColor = Color(0xffC74F3A);
  buildAutoSave() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Image.asset(
            'images/radio.png',
            color: _radioColor,
          ),
          onTap: () {
            setState(() {
              _radioColor = _radioColor == selectRadioColor
                  ? unSelectRadioColor
                  : selectRadioColor;
            });
          },
        ),
        SizedBox(
          width: 6.0,
        ),
        Text(
          'New card input directly, the system will automatically save',
          style: TextStyle(
              fontSize: 10.0,
              color: Color(0xff222222),
              fontWeight: FontWeight.w300),
        )
      ],
    );
  }

  ///
  /// 展示选择性别的弹窗
  ///
  _showCheckSexDiaolog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new CheckSexDialog(
            groupValue: groupValue,
            onChanged: (int e) => updateGroupValue(e),
          );
        });
  }

  updateGroupValue(int e) {
    Navigator.pop(context);
    setState(() {
      this.groupValue = e;
    });
  }
}
