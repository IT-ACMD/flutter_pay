import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page/NewsPage.dart';

///
/// 这是一个自定义的选择性别的弹窗
///
class AppTitleBar extends StatefulWidget {
  String title = '';

  AppTitleBar({Key key, @required this.title}) : super(key: key);

  _AppTitleBarState createState() => _AppTitleBarState();
}

class _AppTitleBarState extends State<AppTitleBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        'images/navigate.png',
                        height: 35.0,
                        width: 35.0,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  child: Image.asset(
                    'images/message.png',
                    height: 35.0,
                    width: 35.0,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return NewsPage();
                    }));
                  },
                ),
              ],
            )
          ],
        ));
  }
}
