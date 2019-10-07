//这是设置支付密码确认页面
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class SettingPaymentPwdConfig extends StatefulWidget {
  String firstCode = '';
  SettingPaymentPwdConfig(String payCode) {
    this.firstCode = payCode;
  }

  _SettingPaymentPwdConfigState createState() =>
      _SettingPaymentPwdConfigState();
}

class _SettingPaymentPwdConfigState extends State<SettingPaymentPwdConfig> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  String _againCode = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(onChange);
  }

  void onChange() {
    String text = _controller.text;
    //输入完6位密码后去验证
    if (text.length >= 6) {
      _againCode = text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarA(
        child:
            AppTitleBar(title: 'TinhTinh Setting Payment Password', size: 15.0),
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 132.0,
                  ),
                  buildHeadTitle(),
                  buildPaymentCodeInput(),
                  buildSureButton()
                ],
              ))),
    );
  }

  buildHeadTitle() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Text(
        'Please input again',
        style: TextStyle(
          fontSize: 18.0,
          color: Color(0xff222222),
        ),
      ),
    );
  }

  buildPaymentCodeInput() {
    return Container(
        margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 45.0),
        child: PinInputTextField(
          pinLength: 6,
          autoFocus: true,
          textInputAction: TextInputAction.go,
          enabled: true,
          controller: _controller,
          inputFormatter: [
            WhitelistingTextInputFormatter(RegExp("[0-9]")),
          ],
          decoration: UnderlineDecoration(
            textStyle: TextStyle(color: Color(0xff222222), fontSize: 20.0),
            enteredColor: Color(0xff555555),
            color: Color(0xff555555),
            lineHeight: 1.0,
            obscureStyle: ObscureStyle(
              isTextObscure: true,
              obscureText: '*', //☺️
            ),
          ),
        ));
  }

  buildSureButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 45.0,
      width: double.infinity,
      child: RaisedButton(
        child:
            Text('Sure', style: TextStyle(color: Colors.white, fontSize: 18.0)),
        color: Color(0xffC74F3A),
        onPressed: () {
          if (_againCode == widget.firstCode) {
            Map map = {'userPwd': _againCode};
            ECHttp.postDataJson('account/addPassword', map).then((res) {
              if (res != null && res.length > 0) {
                var jsonData = json.decode(res);
                bool data = jsonData['data'];
                if (jsonData['success'] && data) {
                  showMessageOne(context, 'Payment password set successfully')
                      .then((state) {
                    Navigator.of(context).pushNamed('home');
                  });
                }
              }
              return false;
            });
          } else {
            //两次密码不一致
            showMessageOne(
                    context, 'The two passwords are inconsistent, please reset')
                .then((state) {
              Navigator.pop(context);
            });
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );
  }
}
