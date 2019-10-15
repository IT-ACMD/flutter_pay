//这是转账页面
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyBankCardAdd.dart';
import 'MyBankCardModify.dart';

class MyBankCard extends StatefulWidget {
  _MyBankCardState createState() => _MyBankCardState();
}

class _MyBankCardState extends State<MyBankCard> {
  //eBankdatas
  @override
  void initState() {
    getUserBankAll().then((res) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: buildTitleBar(),
        ),
        body: Column(
          children: <Widget>[
            buildheadButton(),
            buildBankList(),
          ],
        ));
  }

  buildBankList() {
    return Expanded(
        child: ListView.builder(
      itemCount: eBankdatas.length,
      itemBuilder: renderRow,
      padding: const EdgeInsets.all(0.0),
    ));
  }

  Widget renderRow(BuildContext context, int index) {
    Color single = Color(0xff617CFF);
    Color plus = Color(0xffCD5036);
    Color bgcolor = index % 2 == 0 ? single : plus;
    Color bbgcolor = index % 2 == 0 ? plus : single;
    final item = eBankdatas[index];
    return Dismissible(
      onDismissed: (_) {
        //参数暂时没有用到，则用下划线表示
        List hears = [
          {'name': 'authorization', 'value': 'bearer ${eUserInfo.accessToken}'},
        ];
        ECHttp.getData('user/user-bank/deletebank?uuid=${item.id}', hears)
            .then((res) {
          if (res != Null) {
            var object1 = json.decode(res);
            if (object1['success']) {
              eBankdatas.removeAt(index);
            }
          }
        });
      }, // 监听
      movementDuration: Duration(milliseconds: 500),
      key: Key(item.toString()),
      child: InkWell(
        child: Container(
          height: 100.0,
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.only(top: 3.0),
          decoration: BoxDecoration(
              color: bgcolor,
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 0.0),
                child: Image.asset(
                  eBankdatas[index].logo,
                  fit: BoxFit.cover,
                  height: 36.0,
                  width: 36.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        eBankdatas[index].bankName,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                      child: Text(
                        eBankdatas[index].cardNumber,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                      child: Text(
                        eBankdatas[index].cardUser,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 12.0, 0.0),
                child: Text(
                  'RMB',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MyBankCardModify(eBankdatas[index]);
          })).then((isChange) {
            if (isChange) {
              //获取所有银行卡
              getUserBankAll().then((res) {
                setState(() {});
              });
            }
          });
        },
      ),
      background: Container(
        color: bbgcolor,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return false;
        } else {
          return await showMessageTwo(
              context, 'Are you sure you want to delete the bank card?');
        }
      },
    );
  }

  buildTitleBar() {
    return Container(
        height: 90.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover)),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Row(
              children: <Widget>[
                Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      child: Image.asset(
                        'images/arrow_left.png',
                        height: 24.0,
                        width: 30.0,
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    child: Text(
                      'TinhTinh Bank card',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    padding: EdgeInsets.only(left: 11.0),
                  ),
                ),
                InkWell(
                  child: Image.asset(
                    'images/add.png',
                    height: 35.0,
                    width: 35.0,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MyBankCardAdd();
                    })).then((isChange) {
                      if (isChange) {
                        //获取所有银行卡
                        getUserBankAll().then((res) {
                          setState(() {});
                        });
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ));
  }

  buildheadButton() {
    return Container(
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        width: double.infinity,
        height: 50.0,
        color: Color(0xfff8f8f8),
        child: RaisedButton.icon(
          elevation: 0.0,
          icon: Icon(Icons.search),
          color: Colors.white,
          label: Text(
            'Search',
            style: TextStyle(color: Color(0xffa3a3a3)),
          ),
          onPressed: () {},
        ));
  }
}
