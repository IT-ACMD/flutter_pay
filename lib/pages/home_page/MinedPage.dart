//这是转账页面
import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/pages/user_self/UserInfoPage.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class MinedPage extends StatefulWidget {
  _MinedPageState createState() => _MinedPageState();
}

class _MinedPageState extends State<MinedPage> {
  /// 默认的头像
  var defaultAvatar = 'images/default_avatar.png';
  var accountImg = 'images/account_balance.png';
  var bagImg = 'images/my_card_bag.png';
  var courtesyImg = 'images/nvite_courtesy.png';
  var bankImg = 'images/bank_card.png';
  var setImg = 'images/set_up.png';
  var aboutImg = 'images/about_us.png';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Pay'),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xFFF8F8F8),
            height: 2200.0,
            child: ListView(children: <Widget>[
              Column(
                children: <Widget>[
                  buildUserBack(), //用户背景
                  SizedBox(
                    height: 16.0,
                  ),
                  buildOption(accountImg, 'Account balance', '账户余额'),
                  SizedBox(
                    height: 16.0,
                  ),
                  buildOption(bagImg, 'My card bag', '我的卡包'),
                  buildOption(courtesyImg, 'nvite courtesy', ''),
                  buildOption(bankImg, 'Bank card', '我的银行卡'),
                  buildOption(setImg, 'Set up', '我的设置'),
                  SizedBox(
                    height: 16.0,
                  ),
                  buildOption(aboutImg, 'About us', '联系我们'),
                ],
              )
            ]),
          ),
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildUserBack() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 10.0, 16.0),
        color: Color(0xffC74F3A),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipOval(
                child: Image.asset(
              defaultAvatar,
              width: 64.0,
              height: 64.0,
            )),
            Container(
                height: 64.0,
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      eUserInfo.name,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    Expanded(
                      child: Text(''),
                    ),
                    Container(
                        height: 22.0,
                        margin: EdgeInsets.only(bottom: 6.0),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: Text(
                            eUserInfo.pwdPhone,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          color: Color.fromARGB(50, 241, 244, 243),
                          highlightColor: Colors.white, //按下颜色
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          onPressed: () {},
                        )),
                  ],
                )),
            Expanded(
                child: Align(
              //padding: EdgeInsets.only(right: 0.0),
              alignment: Alignment.centerRight,
              child: Image.network(
                'https://lanhu.oss-cn-beijing.aliyuncs.com/SketchSlicePng489e0346717505fbb500e123746fe63e',
                height: 20.0,
                width: 20.0,
                color: Colors.white,
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new UserInfoPage()),
        );
      },
    );
  }

  buildOption(image, title, route) {
    return InkWell(
      child: Container(
        color: Colors.white,
        height: 50.0,
        padding: new EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Image.asset(image, width: 24.0, height: 24.0),
            new Padding(
              padding: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: new Text(
                title,
                style: new TextStyle(
                    color: const Color(0xff353535), fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  buildUserRecord() {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(17.0, 16.0, 0.0, 23.0),
                child: Text('我的运动记录'),
              ),
              Container(
                padding: EdgeInsets.only(right: 22.0),
                child: Image.network(
                  'https://lanhu.oss-cn-beijing.aliyuncs.com/SketchSlicePng489e0346717505fbb500e123746fe63e',
                  height: 14.0,
                  width: 8.0,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(17.0, 0.0, 7.0, 11.0),
                child: Text(
                  '0',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF524d55)),
                ),
              ),
              Container(
                child: Text(
                  '总运动分钟',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF999999)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  buildWarningSettings() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.fromLTRB(18.0, 15.0, 22.0, 14.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/warning.png',
                  width: 18.0,
                  height: 20.0,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '预警设置',
                      style: TextStyle(color: Color(0xFF524D55)),
                    )),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Image.network(
                          'https://lanhu.oss-cn-beijing.aliyuncs.com/SketchSlicePng489e0346717505fbb500e123746fe63e',
                          height: 14.0,
                          width: 8.0,
                        )))
              ],
            )),
      ),
      onTap: () {
        /*Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return WarningSet();
        }));*/
      },
    );
  }

  buildUsergSettings() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.fromLTRB(18.0, 15.0, 22.0, 14.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/settings.png',
                  width: 18.0,
                  height: 20.0,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '设置',
                      style: TextStyle(color: Color(0xFF524D55)),
                    )),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Image.network(
                          'https://lanhu.oss-cn-beijing.aliyuncs.com/SketchSlicePng489e0346717505fbb500e123746fe63e',
                          height: 14.0,
                          width: 8.0,
                        )))
              ],
            )),
      ),
      onTap: () {
        /*Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MoreSetting();
        }));*/
      },
    );
  }
}
