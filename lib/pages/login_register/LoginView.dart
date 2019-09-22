import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/pages/login_register/RegisterView.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharesdk/sharesdk.dart';

/// 墨水瓶（`InkWell`）可用时使用的字体样式。
final TextStyle _availableStyle = TextStyle(
  color: const Color(0xFFC74F3A),
);

/// 墨水瓶（`InkWell`）不可用时使用的样式。
final TextStyle _unavailableStyle = TextStyle(
  color: const Color(0xFFCCCCCC),
);

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _phone;
  bool isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      'title': "微信",
      'icon':
          'images/3.0x/WX.png', //Image.asset('images/QQ.png'),//ImageIcon(AssetImage("assets/images/微信.png")),
    },
    {
      'title': "QQ",
      'icon': 'images/QQ.png', //ImageIcon(AssetImage("images/QQ.png"))
    }
  ];

  /// 倒计时的计时器。
  Timer _timer;

  /// 当前倒计时的秒数。
  int _seconds;

  ///倒计时秒数 默认60秒
  int countdown;

  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = 'Get Verify Code';

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _seconds = countdown = 60;
    ShareSDKRegister register = ShareSDKRegister();
    register.setupWechat(
        "wx617c77c82218ea2c", "c7253e5289986cf4c4c74d1ccc185fb1");
    register.setupQQ("100371282", "aed9b0303e3ed1e27bae87c33761161d");
    //注册
    ShareSDK.regist(register);
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
            buildPhoneTextField(),
            Container(
              color: Color(0xffeeeeee),
              height: 1.0,
            ),
            SizedBox(height: 30.0),
            buildCodeTextField(),
            Container(
              color: Color(0xffeeeeee),
              height: 1.0,
            ),
            buildLoginButton(context),
            buildRegisterButton(),
          ],
        ),
      ),
    ));
  }

  buildRegisterButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      height: 45.0,
      width: double.infinity,
      child: OutlineButton(
        child: Text('Register',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
        color: Colors.black,
        highlightedBorderColor: Colors.white,
        borderSide: BorderSide(width: 2.0, color: Colors.black),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return RegisterView();
          }));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                4.0)), //StadiumBorder(side: BorderSide()),
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
                  print("去注册");
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: _loginMethod
          .map((item) => Builder(
                builder: (context) {
                  return Listener(
                    child: IconButton(
                        //icon: ImageIcon(AssetImage('images/QQ.png'),color: Color.fromARGB(0, 0, 0, 0)),//item['icon'],
                        //color: Theme.of(context).iconTheme.color),
                        icon: Image.asset(item[
                            'icon']), //ImageIcon(AssetImage('images/QQ.png')),
                        iconSize: 50.0,
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            content: new Text("${item['title']}登录"),
                            action: new SnackBarAction(
                              label: "取消",
                              onPressed: () {},
                            ),
                          ));
                        }),
                    onPointerUp: (PointerUpEvent event) {
                      item['title'] == '微信'
                          ? authToWechat(context)
                          : authToQQ(context);
                    },
                  );
                },
              ))
          .toList(),
    );
  }

  buildLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 34.0),
      height: ScreenUtil().setHeight(140.0), //45 * 420/160
      //width: ScreenUtil().setWidth(870.0), //270 * 420/160
      child: RaisedButton(
        child: Text('Sign in',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0) //Theme.of(context).primaryTextTheme.headline,
            ),
        color: Color(0xffC74F3A),
        onPressed: () async {
          if (eIsTest) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => route == null);
          }
          if (_formKey.currentState.validate()) {
            //= 执行登录方法
            toLogin();
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                8.0)), //StadiumBorder(side: BorderSide()),
      ),
    );
  }

  //去登陆
  toLogin() {
    if (_verifyStr == 'Get Verify Code') {
      return showMessageOne(context, 'Please get the verification code first!');
    }
    var url = 'authentication/mobile';
    String params = 'mobile=$_phone'
        '&smsCode=1234';
    ECHttp.postData(url, params).then((result) {
      if (result != null && result.length > 0) {
        var object = json.decode(result);
        eUserInfo.accessToken = object['access_token'];
        afterLogin();
        Navigator.pushNamedAndRemoveUntil(
            context, 'home', (route) => route == null);
      }
    }).catchError((e) {
      //执行失败会走到这里
      showMessageOne(context, 'Login error, please try again later!');
    }).whenComplete(() {
      //无论如何走这里
      //showMessageOne(context, 'The request has timed out, please try again later!');
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
            hintStyle: TextStyle(color: Color(0xffadadad), fontSize: 12.0),
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

  //验证码文本框
  buildCodeTextField() {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextFormField(
          //controller: _controller,
          style: TextStyle(color: Colors.black),
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Please enter your code',
            hintStyle: TextStyle(color: Color(0xffadadad), fontSize: 12.0),
            border: InputBorder.none,
          ),
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
              ? () async {
                  if (_formKey.currentState.validate()) {
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
    var url = 'code/sms?mobile=$_phone';
    List hears = [
      {'name': 'deviceId', 'value': '008'}
    ];
    ECHttp.getData(url, hears).then((result) {
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

  buildTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 40.0),
      child: Text(
        'Sign in',
        style: TextStyle(fontSize: 26.0, color: Colors.black),
      ),
    );
  }

  void authToWechat(BuildContext context) {
    ShareSDK.auth(ShareSDKPlatforms.wechatSession, null,
        (SSDKResponseState state, Map user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }

  void getUserInfoToWechat(BuildContext context) {
    ShareSDK.getUserInfo(ShareSDKPlatforms.wechatSession,
        (SSDKResponseState state, Map user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }

  void authToQQ(BuildContext context) {
    ShareSDK.getUserInfo(ShareSDKPlatforms.qq,
        (SSDKResponseState state, Map user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }

  void showAlert(SSDKResponseState state, Map content, BuildContext context) {
    print("--------------------------> state:" + state.toString());
    String title = "失败";
    switch (state) {
      case SSDKResponseState.Success:
        title = "成功";
        break;
      case SSDKResponseState.Fail:
        title = "失败";
        break;
      case SSDKResponseState.Cancel:
        title = "取消";
        break;
      default:
        title = state.toString();
        break;
    }
  }
}
