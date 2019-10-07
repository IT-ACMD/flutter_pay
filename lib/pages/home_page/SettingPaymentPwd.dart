//这是设置支付密码页面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/home_page/SettingPaymentPwdConfig.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import 'MyDrawer.dart';

class SettingPaymentPwd extends StatefulWidget {
  _SettingPaymentPwdState createState() => _SettingPaymentPwdState();
}

class _SettingPaymentPwdState extends State<SettingPaymentPwd> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  String payCode = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(onChange);
  }

  void onChange() {
    String text = _controller.text;
    //输入完6位密码后去验证
    if (text.length >= 6) {
      payCode = text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(
              title: 'TinhTinh Setting Payment Password', size: 15.0),
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
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildHeadTitle() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Text(
        'Please enter a new payment password',
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
          keyboardType: TextInputType.number,
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
          if (_formKey.currentState.validate()) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SettingPaymentPwdConfig(payCode);
            }));
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );
  }
}
