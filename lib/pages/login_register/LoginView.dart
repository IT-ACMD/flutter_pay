import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/pages/country_select/CountryCodeSelectPage.dart';
import 'package:flutter_app/pages/login_register/RegisterView.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  String _phoenCode, _password, _phone, _countryCode;
  bool isObscure = true;
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

  TextEditingController _controller = new TextEditingController();
  TextEditingController _controllerp = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(onChange);
    _controllerp.addListener(onChangep);
    _phoenCode = '+855';
    _countryCode = 'Cambodia';
  }

  void onChange() {
    String text = _controller.text;
    _phone = text;
    eUserInfo.phone = text;
  }

  void onChangep() {
    String text = _controllerp.text;
    _password = text;
  }

  @override
  Widget build(BuildContext context) {
    //默认设置宽度1080px, 高度1920px
    ScreenUtil.instance.init(context);
    //设置宽750 高1334，根据系统字体进行缩放
    //ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920, allowFontScaling: true)..init(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.srcOver),
        ),
      ),
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
            buildCountryCode(),
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
            SizedBox(height: 30.0),
            buildPwdTextField(),
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
      margin: EdgeInsets.only(top: 30.0),
      height: ScreenUtil().setHeight(140.0),
      width: double.infinity,
      child: OutlineButton(
        child: Text('Register',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
        color: Colors.white,
        highlightedBorderColor: Colors.white,
        borderSide: BorderSide(width: 1.0, color: Colors.white),
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
                      /*item['title'] == '微信'
                          ? authToWechat(context)
                          : authToQQ(context);*/
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
    if (_phone == null) {
      return showMessageOne(context, '_phone is null');
    }

    if (_phoenCode == null) {
      return showMessageOne(context, '_phoenCode is null');
    }

    if (_password == null) {
      return showMessageOne(context, '_password is null');
    }

    if (_password.length < 6) {
      return showMessageOne(context, 'Please enter your 6-digit password!');
    }

    var url = 'user/user/login';
    Map map = {'phone': _phone, 'pwd': _password, 'phonecode': _phoenCode};
    ECHttp.postDataJson(url, map).then((result) {
      if (result != null) {
        var jsonData = json.decode(result);
        if (jsonData['success']) {
          //showMessageOne(context, jsonData['data']);
          //去获取token
          toGetToken();
        } else {
          showMessageOne(context, jsonData['data']);
        }
      }
    });
  }

  toGetToken() {
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

  //国家代码选择框
  buildCountryCode() {
    return InkWell(
      child: Row(
        children: <Widget>[
          Text(
            _phoenCode,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
            _countryCode,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          Padding(
              child: Image.asset('images/arrow_right.png', color: Colors.white),
              padding: EdgeInsets.fromLTRB(15.0, 14.0, 5.0, 14.0)),
        ],
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return CountryCodeSelect();
        })).then((code) {
          if (code != null) {
            _phoenCode = code.dialCode;
            _countryCode = code.name;
            setState(() {});
          }
        });
        /*changeRegion(context).then();*/
      },
    );
  }

  //手机号登录文本框
  buildPhoneTextField() {
    return TextFormField(
      controller: _controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Phone', //'Please enter your cell phone number',
        hintStyle: TextStyle(color: Color(0xffADADAD), fontSize: 16.0),
        border: InputBorder.none,
        errorStyle: TextStyle(color: Color(0xffFF9481), fontSize: 12.0),
      ),
      validator: (String value) {
        var emailReg;
        if (_phoenCode == '+86') {
          emailReg = RegExp(
              r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
        } else if (_phoenCode == '+855') {
          emailReg = RegExp(r'^\d{8}$');
        }
        if (!emailReg.hasMatch(value)) {
          return 'Please enter the correct phone number';
        }
      },
    );
  }

  static IconData visible = Icons.visibility_off;
  static IconData unVisible = Icons.visibility;
  IconData selIcon = visible;

  buildPwdTextField() {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextField(
          controller: _controllerp,
          inputFormatters: [LengthLimitingTextInputFormatter(6)],
          style: TextStyle(color: Colors.white),
          obscureText: selIcon == visible ? true : false,
          decoration: InputDecoration(
            hintText: 'Passworld',
            hintStyle: TextStyle(color: Color(0xffADADAD), fontSize: 16.0),
            border: InputBorder.none,
          ),
        )),
        GestureDetector(
          child: Padding(
              child: Icon(
                selIcon,
                color: Colors.white,
              ),
              padding: EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 14.0)),
          onTap: () {
            selIcon = selIcon == visible ? unVisible : visible;
            setState(() {});
          },
        ),
      ],
    );
  }

  buildTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 40.0),
      child: Text(
        'Sign in',
        style: TextStyle(fontSize: 26.0, color: Colors.white),
      ),
    );
  }
}
