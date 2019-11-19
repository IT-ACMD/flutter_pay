import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';
import 'package:flutter_app/tools/ECMessage.dart';
import 'package:flutter_app/widget/title_barA.dart';

class EditUserInfoPage extends StatefulWidget {
  String name = '';

  EditUserInfoPage(String nikeName) {
    this.name = nikeName;
  }

  @override
  State<StatefulWidget> createState() {
    return new _EditUserInfoPageState();
  }
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  var inputText;
  TextEditingController _name = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBarA(
        child: buildtitlebar(),
      ),
      body: new Container(
        child: new TextField(
          controller: _name,
          decoration: new InputDecoration(
            hintText: '请输入内容',
          ),
          onChanged: _onInputTextChange,
        ),
      ),
    );
  }

  buildtitlebar() {
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
                      'Modify personal information',
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
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: _saveUserInfo,
                ),
              ],
            )
          ],
        ));
  }

  ///
  /// 保存按钮点击的回调
  ///
  _saveUserInfo() {
    Map map = {
      'username': inputText,
      'headurl': '1234',
    };
    bool isflag = setAccoutRateAlert(map);
    if (isflag) {
      Navigator.pop(context, '$inputText');
    } else {
      //修改失败
      showMessageOne(context, 'Register error, please try again later!');
    }
  }

  ///
  /// 输入内容改变之后
  ///
  _onInputTextChange(String value) {
    setState(() {
      inputText = value;
    });
  }
}
