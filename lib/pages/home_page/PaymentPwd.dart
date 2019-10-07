//这是转账页面
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_app/widget/title_barA.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'package:crypto/crypto.dart';

class PaymentPwd extends StatefulWidget {
  BuildContext _context = null;

  PaymentPwd(BuildContext context) {
    this._context = context;
  }

  _PaymentPwdState createState() => _PaymentPwdState();
}

class _PaymentPwdState extends State<PaymentPwd> {
  TextEditingController _controller = TextEditingController();

  String _PaymentPwd = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(onChange);
  }

  void onChange() {
    String text = _controller.text;
    //输入完6位密码后去验证
    if (text.length >= 6) {
      _PaymentPwd = md5.convert((utf8.encode(text))).toString();
      toVerifyCode();
    }
  }

  //去获取验证码
  toVerifyCode() {
    Map map = {
      'userPwd': _PaymentPwd,
    };
    ECHttp.postDataJson('account/paymentPasswor', map).then((data) {
      if (data != null && data.length > 0) {
        var jsonData = json.decode(data);
        if (jsonData['data'] == '密码正确') {
          Navigator.of(context).pop(true);
        } else {
          _controller.text = '';
          _PaymentPwd = '';
          showMessageOne(widget._context, 'Password error please re-enter');
        }
      }
    }).catchError((e) {
      //执行失败会走到这里
      _controller.text = '';
      _PaymentPwd = '';
      showMessageOne(widget._context, 'The request failed, please try again later');
    }).whenComplete(() {
      //无论如何走这里
      //showMessageOne(widget._context, 'The request has timed out, please try again later!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: buildBackButton(),
          backgroundColor: Colors.white,
          elevation: 1.0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[buildPhoneTextField()],
        )));
  }

  buildBackButton() {
    return Row(children: <Widget>[
      IconButton(
        padding: EdgeInsets.all(0.0),
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 20,
        color: Color(0xffacacac),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      Center(
          child: Text('Please input a password',
              style: TextStyle(
                fontSize: 18.0,
                color: Color(0xff222222),
              ))),
    ]);
  }

  //支付密码文本框
  buildPhoneTextField() {
    return Container(
        margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: PinInputTextField(
          pinLength: 6,
          autoFocus: true,
          textInputAction: TextInputAction.go,
          enabled: true,
          controller: _controller,
          decoration: BoxTightDecoration(
            textStyle: TextStyle(color: Color(0xff222222), fontSize: 20.0),
            //strokeColor: Color(0xFF726E74),
            solidColor: Colors.white, //背景颜色
            strokeColor: Color(0xffD9D9D9), //格子边框颜色
            radius: Radius.circular(5.0),
            obscureStyle: ObscureStyle(
              isTextObscure: true,
              obscureText: '*', //☺️
            ),
          ),
        ));
  }
}
