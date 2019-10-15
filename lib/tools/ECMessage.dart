//弹出加载框
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_app/data/dataCenter.dart';

/**
 *  example : showLoadingDialog(context, '正在加载，请稍后...')
 */
showLoadingDialog(BuildContext context, value) {
  showDialog(
    context: context,
    barrierDismissible: false, //点击遮罩不关闭对话框
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: Text(value),
            )
          ],
        ),
      );
    },
  );
}

Future<bool> showAlertDialog(BuildContext context, String value) {
  NavigatorState navigator =
      context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>());
  debugPrint("navigator is null?" + (navigator == null).toString());
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
              title: new Text("Hint Message"),
              content: new Text(value),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                new FlatButton(
                  child: new Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ]));
}

Future<bool> showMessageOne(BuildContext context, String value) {
  NavigatorState navigator =
      context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>());
  debugPrint("navigator is null?" + (navigator == null).toString());
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text("Message"),
            content: new Text(value),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
          ));
}

Future<bool> showMessageTwo(BuildContext context, String content,
    [String title = 'Message', left = 'CANCEL', String right = 'ok']) {
  NavigatorState navigator =
      context.rootAncestorStateOfType(const TypeMatcher<NavigatorState>());
  debugPrint("navigator is null?" + (navigator == null).toString());
  return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  left,
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              new FlatButton(
                child: new Text(
                  right,
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
          ));
}

Future<String> changeRegion(context) async {
  return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CountryCodePicker(
          onChanged: print,
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'IT',
          //favorite: ['+39', 'FR'],
          // optional. Shows only country name and flag
          showCountryOnly: false,
          // optional. Shows only country name and flag when popup is closed.
          showOnlyCountryWhenClosed: false,
          //showOnlyCountryCodeWhenClosed: false,
          // optional. aligns the flag and the Text left
          alignLeft: true,
          //showFlag: false,
        );
      });
}

Future<String> changeRegion2(context) async {
  return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Please select region'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // 返回2
                Navigator.pop(context, '+855');
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: <Widget>[
                      Text('+855'),
                      Expanded(
                        child: Container(),
                      ),
                      Text('Cambodia'),
                    ],
                  )),
            ),
            SimpleDialogOption(
              onPressed: () {
                // 返回1
                Navigator.pop(context, '+86');
              },
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: <Widget>[
                      Text('+86'),
                      Expanded(
                        child: Container(),
                      ),
                      Text('China'),
                    ],
                  )),
            ),
          ],
        );
      });
}
