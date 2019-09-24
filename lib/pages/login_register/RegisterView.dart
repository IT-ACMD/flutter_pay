import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loginView.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  String _password, _phone, _phoenCode;
  bool isObscure = true;
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoenCode = '+855';
    _controller.addListener(onChange);
    _controllerPwd.addListener(onChangeP);
  }

  void onChange() {
    String text = _controller.text;
    _phone = text;
    eUserInfo.phone = text;
  }

  void onChangeP() {
    String text = _controllerPwd.text;
    _password = text;
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
              height: 80.0,
            ),
            buildTitle(),
            SizedBox(height: 20.0),
            /*buildPhoneAddress(),
            Container(
              color: Color(0xffeeeeee),
              height: 1.0,
            ),*/
            SizedBox(height: 30.0),
            buildPhoneTextField(),
            Container(
              color: Color(0xffeeeeee),
              height: 1.0,
            ),
            SizedBox(height: 30.0),
            buildPwdTextField(),
            Container(
              color: Color(0xffeeeeee),
              height: 1.0,
            ),
            buildRegisterButton(context),
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

  buildRegisterButton(BuildContext context) {
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
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) {
              return LoginView();
            }), (route) => route == null);
          }
          if (_formKey.currentState.validate()) {
            toRegister();
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                8.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }

  toRegister() {
    var url = 'user/user/insert';
    Map map = {"phone": _phone, 'pwd': _password, 'phonecode': _phoenCode};
    ECHttp.postDataJson(url, map).then((result) {
      if (result != null) {
        var jsonData = json.decode(result);
        if (jsonData['success'] && jsonData['data'].indexOf('成功') != -1) {
          showMessageOne(context, 'Registration Successful!').then((res) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (BuildContext context) {
              return LoginView();
            }), (route) => route == null);
          });
        } else if (jsonData['data'].indexOf('已存在') != -1) {
          showMessageOne(context, 'The user already exists!');
        }
      }
    }).catchError((e) {
      //执行失败会走到这里
      showMessageOne(context, 'Register error, please try again later!');
    });
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
              'Contury', //'Location of mobile phone number',
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
        InkWell(
          child: Row(
            children: <Widget>[
              Text(
                _phoenCode,
                style: TextStyle(fontSize: 16.0, color: Color(0xff222222)),
              ),
              Padding(
                  child: Image.asset('images/arrow_right.png',
                      color: Colors.black),
                  padding: EdgeInsets.fromLTRB(15.0, 14.0, 20.0, 14.0)),
            ],
          ),
          onTap: () {
            changeRegion(context).then((val) {
              _phoenCode = val;
              setState(() {});
            });
          },
        ),
        Expanded(
            child: TextFormField(
          controller: _controller,
          style: TextStyle(color: Color(0xff222222)),
          decoration: InputDecoration(
            hintText: 'Phone', //'Please enter your cell phone number',
            hintStyle: TextStyle(color: Color(0xffadadad), fontSize: 16.0),
            border: InputBorder.none,
          ),
          validator: (String value) {
            var emailReg;
            if (_phoenCode == '+86') {
              emailReg = RegExp(
                  r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
            } else if (_phoenCode == '+855') {
              emailReg = RegExp(r'^\d{6,}$');
            }
            if (!emailReg.hasMatch(value)) {
              return 'Please enter the correct phone number';
            }
          },
        )),
      ],
    );
  }

  //手机号登录文本框
  buildPhoneTextField1() {
    return Row(
      children: <Widget>[
        Padding(
            child: Text(
              '+855',
              style: TextStyle(fontSize: 16.0, color: Color(0xff222222)),
            ),
            padding: EdgeInsets.fromLTRB(0.0, 14.0, 40.0, 14.0)),
        Expanded(
            child: TextFormField(
          controller: _controller,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Phone', //'Please enter your cell phone number',
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

  buildPwdTextField() {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextFormField(
          controller: _controllerPwd,
          style: TextStyle(color: Colors.black),
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'new passworld',
            hintStyle: TextStyle(color: Color(0xffadadad), fontSize: 16.0),
            border: InputBorder.none,
          ),
          validator: (String value) {
            var emailReg = RegExp(r'^\d{6}$');
            if (!emailReg.hasMatch(value)) {
              return 'Please enter a 6-bit code';
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
