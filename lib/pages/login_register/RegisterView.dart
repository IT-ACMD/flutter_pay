import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/pages/country_select/CountryCodeSelectPage.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'loginView.dart';

/// 墨水瓶（`InkWell`）可用时使用的字体样式。
final TextStyle _availableStyle = TextStyle(
  color: const Color(0xffFF9481),
);

/// 墨水瓶（`InkWell`）不可用时使用的样式。
final TextStyle _unavailableStyle = TextStyle(
  color: const Color(0xFFCCCCCC),
);

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _codeKey = GlobalKey<FormState>();
  String _password, _phone, _phoenCode;
  bool isObscure = true;
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controllerCode = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();

  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = 'Get Verify Code';

  /// 倒计时的计时器。
  Timer _timer;

  /// 当前倒计时的秒数。
  int _seconds;

  ///倒计时秒数 默认60秒
  int countdown;

  @override
  void initState() {
    super.initState();
    _seconds = countdown = 60;
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
            Form(
              key: _codeKey,
              child: Column(
                children: <Widget>[
                  buildPhoneTextField(),
                  Container(
                    color: Color(0xffeeeeee),
                    height: 1.0,
                  ),
                  SizedBox(height: 30.0),
                  buildCodeTextField(),
                ],
              ),
            ),
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

  //去注册
  toRegister() {
    String code = _controllerCode.text;
    if (_verifyStr == 'Get Verify Code') {
      return showMessageOne(context, 'Please get the verification code first!');
    }
    var url = 'user/user/insert';
    Map map = {
      "phone": _phone,
      'phonecode': _phoenCode,
      'pwd': _password,
      'code': code
    };
    ECHttp.postDataJson(url, map, _phoenCode, _phone).then((result) {
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return CountryCodeSelect();
            })).then((code) {
              if (code != null) {
                _phoenCode = code.dialCode;
                setState(() {});
              }
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
          //autovalidate: true,
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
          //autovalidate: true,
          decoration: InputDecoration(
            hintText: 'New password',
            hintStyle: TextStyle(color: Color(0xffadadad), fontSize: 16.0),
            border: InputBorder.none,
          ),
          validator: (String value) {
            var emailReg = RegExp(r'^\d{6}$');
            if (!emailReg.hasMatch(value)) {
              return 'Please enter a 6-bit number code';
            }
          },
        )),
      ],
    );
  }

  //验证码文本框
  buildCodeTextField() {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextFormField(
          controller: _controllerCode,
          style: TextStyle(color: Colors.black),
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Code', //'Please enter your code',
            hintStyle: TextStyle(color: Color(0xffADADAD), fontSize: 16.0),
            border: InputBorder.none,
          ),
          autovalidate: true,
          onFieldSubmitted: (String value) {
            var emailReg = RegExp(r'^\d{4}$');
            if (!emailReg.hasMatch(value)) {
              return 'Please enter a 4-bit code';
            }
          },
        )),
        GestureDetector(
          child: Padding(
              child: Text(
                '$_verifyStr',
                style: inkWellStyle,
              ),
              padding: EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0)),
          onTap: (_seconds == countdown)
              ? () {
                  if (_codeKey.currentState.validate()) {
                    //获取验证码
                    toGetVerifyCode();
                  }
                }
              : null,
        ),
      ],
    );
  }

  //去获取验证码
  toGetVerifyCode() {
    var url = 'user/user/verification';
    Map map = {"phone": '$_phoenCode$_phone'};
    ECHttp.postDataJson(url, map, _phoenCode, _phone).then((result) {
      /*var url = 'code/sms?mobile=$_phone';
    List hears = [
      {'name': 'deviceId', 'value': '008'}
    ];
    ECHttp.getData(url, hears).then((result) {*/
      if (result != null) {
        _startTimer();
        inkWellStyle = _unavailableStyle;
        _verifyStr = '已发送$_seconds' + 's';
        setState(() {});
      } else {
        showMessageOne(
            context, 'This account does not exist. Please register first!');
      }
    }).catchError((e) {
      //执行失败会走到这里
      showMessageOne(context, 'Get verify vode error, please try again later!');
    }).whenComplete(() {
      //无论如何走这里
      //showMessageOne(context, 'The request has timed out, please try again later!');
    });
  }

  ///启动倒计时计时器
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = countdown;
        inkWellStyle = _availableStyle;
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = '已发送$_seconds' + 's';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }
}
