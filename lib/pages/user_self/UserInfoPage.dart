import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/check_sex_dialog.dart';
import 'package:flutter_app/widget/title_barA.dart';
//import 'package:image_picker/image_picker.dart';

import 'EditUserInfoPage.dart';

class UserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _UserInfoPageState();
  }
}

class _UserInfoPageState extends State<UserInfoPage> {
  var defaultAvatar = 'images/default_avatar.png';
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh Personal information'),
        ),
        body: new Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              new Container(
                height: 11.0,
                color: const Color(0xffF8F8F8),
              ),
              new InkWell(
                  onTap: () {
                    getImage().then((image) {
                      if (image != null) {
                        setState(() {});
                      }
                    });
                  },
                  child: new Container(
                    margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                    height: 80.0,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Text(
                            'Head portrait',
                            style: TextStyle(
                                fontSize: 16.0, color: const Color(0xff222222)),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                          child: new Image.asset(defaultAvatar,
                              width: 64.0, height: 64.0),
                        ),
                      ],
                    ),
                  )),
              new Container(
                height: 9.0,
                color: const Color(0xffF8F8F8),
              ),
              new GestureDetector(
                onTap: _startEditUserInfoPage,
                child: new Container(
                  margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  height: 48.0,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 16.0, color: const Color(0xff222222)),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                        child: new Text(
                          eUserInfo.name,
                          style: TextStyle(
                              fontSize: 16.0, color: const Color(0xff9A9A9A)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        'Account',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff222222)),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                      child: new Text(
                        '+86-${eUserInfo.pwdPhone}',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff9a9a9a)),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        'Document type',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff222222)),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                      child: new Text(
                        'ID',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff9A9A9A)),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new GestureDetector(
                //onTap: _showCheckSexDiaolog,
                child: new Container(
                  margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  height: 48.0,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text(
                          'ID number',
                          style: TextStyle(
                              fontSize: 16.0, color: const Color(0xff222222)),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                        child: new Text(
                          eUserInfo.cardId,
                          style: TextStyle(
                              fontSize: 16.0, color: const Color(0xff9A9A9A)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffF8F8F8),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                height: 48.0,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        'Mailbox',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff222222)),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                      child: new Text(
                        'Unbound',
                        style: TextStyle(
                            fontSize: 16.0, color: const Color(0xff9A9A9A)),
                      ),
                    ),
                  ],
                ),
              ),
              new Expanded(
                child: new Container(
                  color: const Color(0xffF8F8F8),
                ),
              )
            ],
          ),
        ));
  }

  Future getImage() async {
    //var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //return image;
  }

  _startEditUserInfoPage() async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new EditUserInfoPage(eUserInfo.name)),
    );
    if (result != null) {
      setState(() {
        eUserInfo.name = result;
      });
    }
  }

  ///
  /// 展示选择性别的弹窗
  ///
  _showCheckSexDiaolog() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new CheckSexDialog(
            groupValue: groupValue,
            onChanged: (int e) => updateGroupValue(e),
          );
        });
  }

  updateGroupValue(int e) {
    Navigator.pop(context);
    setState(() {
      this.groupValue = e;
    });
  }
}
