import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loginView.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _phone;
  bool isObscure = true;
  Color _eyeColor;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(onChange);
  }

  void onChange() {
    String text = _controller.text;
    _phone = text;
    eUserInfo.phone = text;
  }

  @override
  Widget build(BuildContext context) {
    //默认设置宽度1080px, 高度1920px
    ScreenUtil.instance.init(context);
    //设置宽750 高1334，根据系统字体进行缩放
    //ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920, allowFontScaling: true)..init(context);
    return Scaffold(
        body: Material(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 35.0),
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            buildTitle(),
            SizedBox(height: 50.0),
            buildPhoneAddress(),
            Container(
              color: Color(0xffeeeeee),
              height: 1.0,
            ),
            SizedBox(height: 30.0),
            buildPhoneTextField(),
            Container(
              color: Color(0xffeeeeee),
              height: 1.0,
            ),
            buildLoginButton(context),
          ],
        ),
      ),
    ));
  }

  Widget buildOtherText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        '其他登陆方式',
        style: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
    );
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("没有账号？"),
              GestureDetector(
                child: Text(
                  "点击注册",
                  style: TextStyle(color: Colors.green),
                ),
                onTap: () {
                  //TODO跳转到注册页面
                  print("去注册");
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }

  DefaultTextStyle buildUserProtocolText() {
    return DefaultTextStyle(
        style: TextStyle(color: Colors.white, fontSize: 11.0),
        textAlign: TextAlign.left,
        child: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
            text: '注册即同意 心电 ',
          ),
          TextSpan(
            text: '用户协议',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
          TextSpan(
            text: ' 和 ',
          ),
          TextSpan(
            text: '隐私政策',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          )
        ])
            //'    ',
            //style: TextStyle(color: Colors.white, fontSize: 11.0),
            ));
  }

  buildLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 34.0),
      height: ScreenUtil().setHeight(140.0), //45 * 420/160
      //width: ScreenUtil().setWidth(870.0), //270 * 420/160
      child: RaisedButton(
        child: Text('Register',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Color(0xffC74F3A),
        onPressed: () async {
          if (eIsTest) {
            /*Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => route == null);*/
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) {
              return LoginView();
            }), (route) => route == null);
          }
          if (_formKey.currentState.validate()) {
            var url = 'user/user/insert';
            Map map = {"phone": _phone};
            var result = await ECHttp.postDataJson(url, map);
            if (result != null) {
              var jsonData = json.decode(result);
              if (jsonData['success']) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return LoginView();
                }), (route) => route == null);
              }
            }
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                8.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  //手机号归属地
  buildPhoneAddress() {
    return Row(
      children: <Widget>[
        Padding(
            child: Text(
              'Location of mobile phone number',
              style: TextStyle(fontSize: 14.0, color: Color(0xff222222)),
            ),
            padding: EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0)),
        Expanded(
          child: Container(),
        ),
        Padding(
            child: Text(
              'CHINA',
              style: TextStyle(fontSize: 12.0, color: Color(0xff222222)),
            ),
            padding: EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0)),
      ],
    );
  }

  //手机号登录文本框
  buildPhoneTextField() {
    return Row(
      children: <Widget>[
        Padding(
            child: Text(
              '+86',
              style: TextStyle(fontSize: 16.0, color: Color(0xff222222)),
            ),
            padding: EdgeInsets.fromLTRB(0.0, 14.0, 40.0, 14.0)),
        Expanded(
            child: TextFormField(
          controller: _controller,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Please enter your cell phone number',
            hintStyle: TextStyle(color: Color(0xffadadad), fontSize: 16.0),
            border: InputBorder.none,
          ),
          validator: (String value) {
            var emailReg = RegExp(
                r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
            if (!emailReg.hasMatch(value)) {
              return '请输入正确的手机号';
            }
          },
        
        )),
      ],
    );
  }

  buildTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 40.0),
      child: Text(
        'Register',
        style: TextStyle(fontSize: 26.0, color: Colors.black),
      ),
    );
  }
}
