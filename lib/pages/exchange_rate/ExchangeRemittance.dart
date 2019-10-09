//这是转账页面
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/pages/home_page/PaymentPwd.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ChoiceCurrency.dart';

class ExchangeRemittance extends StatefulWidget {
  _ExchangeRemittanceState createState() => _ExchangeRemittanceState();
}

class _ExchangeRemittanceState extends State<ExchangeRemittance> {
  String fromCurrency, fromImage, fromValue, fromId;
  String toCurrency, toImage, toValue, toId;
  //当前汇率
  double currencyRate = 7.1314;
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  @override
  void initState() {
    fromCurrency = efromCurrency != null ? efromCurrency['currency'] : 'USD';
    fromImage = 'flags/us.png';
    toCurrency = etoCurrency != null ? etoCurrency['currency'] : 'CNY';
    toImage = 'flags/cn.png';
    fromId = efromCurrency != null ? efromCurrency['id'] : '0';
    toId = etoCurrency != null ? etoCurrency['id'] : '1';
    _controller.text = '100';
    _controller2.text = '713.21';
    _controller.addListener(onChange);
    _controller2.addListener(onChangep);
    super.initState();
  }

  void onChange() {
    String text = _controller.text;
    _controller2.text = (double.parse(text) * currencyRate).toString();
  }

  void onChangep() {
    String text = _controller2.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Exchange remittance'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Color(0xffCB604E),
              height: 160.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 8.0,
                  ),
                  buildText(),
                  buildCard(),
                ],
              ),
            )
          ],
        ));
  }

  buildRegisterButton() {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      height: 40.0, //ScreenUtil().setHeight(140.0), //45 * 420/160
      width: 200.0,
      child: RaisedButton(
        child: Text('Confirm',
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        color: Color(0xffC74F3A),
        onPressed: () {
          toExchange();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    );
  }

  toExchange() {
    showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return PaymentPwd(context);
      },
    ).then((res) {
      if (!res) return;
      String url = "account/exchangerate";
      Map param = {
        "currencyUuid": fromId, //币种
        "currencyUuids": toId,
        "amount": _controller.text, //转账额度
        "amounts": _controller2.text,
      };
      ECHttp.postDataJson(url, param).then((res) {
        if (res != null && res.length > 0) {
          var jsonData = json.decode(res);
          if (jsonData['success']) {
            showAlertDialog(this.context, 'Exchange success').then((res) {
              Navigator.of(context).pushNamed('home');
            });
          }
        }
      });
      //showLoadingDialog(this.context, '正在转账中,请稍后。。。');
    });
  }

  buildText() {
    return Text.rich(
      TextSpan(
          text: 'Excellent exchange rate pen saving',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              height: 1.25),
          children: <TextSpan>[
            TextSpan(
                text: '\nNo currency conversion fee\nHow much to pay',
                style: TextStyle(fontSize: 16.0, color: Color(0xffFBC0B6))),
          ]),
      softWrap: false,
    );
  }

  buildCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      margin: EdgeInsets.all(20.0),
      color: Colors.white,
      //semanticContainer: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Update 1 minute ago',
              style: TextStyle(color: Color(0xff727272)),
            ),
          ),
          buildFromAccount(fromImage, fromCurrency, '100', true),
          Container(
            height: 1.0,
            color: Color(0xffF8F7F7),
          ),
          buildToAccount(toImage, toCurrency, '713.21', false),
          Container(
            height: 1.0,
            color: Color(0xffF8F7F7),
          ),
          buildRegisterButton(),
          Container(
            height: 25.0,
          ),
        ],
      ),
    );
  }

  buildFromAccount(url, title, value, isfrom) {
    return Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            InkWell(
              child: Row(
                children: <Widget>[
                  Image.asset(
                    url,
                    package: 'country_code_picker',
                    width: 33.0,
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(color: Color(0xff727272), fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 13.0,
                  ),
                  Image.asset(
                    'images/forward.png',
                    width: 16.0,
                    height: 16.0,
                  ),
                ],
              ),
              onTap: () {
                toChangeFromOrTo(isfrom);
              },
            ),
            Expanded(
                child: TextField(
              textAlign: TextAlign.right,
              controller: _controller,
              style: TextStyle(color: Color(0xffadadad), fontSize: 16.0),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            )),
          ],
        ));
  }

  toChangeFromOrTo(isfrom) {
    String currency = isfrom ? fromCurrency : toCurrency;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ChoiceCurrency();
    })).then((val) {
      if (val != null && currency != val.currency) {
        if (isfrom) {
          fromCurrency = val.currency;
          fromId = val.id;
          fromImage = 'flags/${val.code.toLowerCase()}.png';
        } else {
          toCurrency = val.currency;
          toId = val.id;
          toImage = 'flags/${val.code.toLowerCase()}.png';
        }
        List hears = [
          {'name': 'authorization', 'value': 'bearer ${eUserInfo.accessToken}'},
        ];
        ECHttp.getData(
                'currency/tpay-currency-exchange-rate/get?currencyFrromUuid=$fromId&currencyToUuid=$toId',
                hears)
            .then((result) {
          if (result != null && result.length > 0) {
            var object1 = json.decode(result);
            if (object1['success']) {
              currencyRate = double.parse(object1['data']);
              _controller2.text =
                  (double.parse(_controller.text) * currencyRate).toString();
            }
          }
        });

        setState(() {});
      }
    });
  }

  buildToAccount(url, title, value, isfrom) {
    return Container(
        height: 50.0,
        child: Row(
          children: <Widget>[
            InkWell(
              child: Row(
                children: <Widget>[
                  Image.asset(
                    url,
                    package: 'country_code_picker',
                    width: 33.0,
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(color: Color(0xff727272), fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 13.0,
                  ),
                  Image.asset(
                    'images/forward.png',
                    width: 16.0,
                    height: 16.0,
                  ),
                ],
              ),
              onTap: () {
                toChangeFromOrTo(isfrom);
              },
            ),
            Expanded(
                child: TextField(
              enabled: false,
              textAlign: TextAlign.right,
              controller: _controller2,
              style: TextStyle(color: Color(0xffadadad), fontSize: 16.0),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            )),
          ],
        ));
  }
}
