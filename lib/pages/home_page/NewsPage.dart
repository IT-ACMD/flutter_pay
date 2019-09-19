//这是消息页面
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';

class NewsPage extends StatefulWidget {
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List news = [];
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<int>(
            stream: _streamController.stream,
            initialData: news.length,
            builder: (c, snapshot) {
              final length = snapshot.data;
              if (length >= 0) {
                //return FindDevicesScreen();
              }
              return NoMessagesScreen();
            }),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }
}

class NoMessagesScreen extends StatelessWidget {
  const NoMessagesScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarA(
          child: AppTitleBar(title: 'TinhTinh News'),
        ),
        backgroundColor: Color(0xfff8f8f8),
        body: Stack(
          children: <Widget>[
            Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'images/no_message.png',
                  fit: BoxFit.cover,
                ),
                Text(
                  'No new news yet',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subhead
                      .copyWith(color: Color(0xffA2A2A2)),
                ),
              ],
            )),
          ],
        ));
  }
}
