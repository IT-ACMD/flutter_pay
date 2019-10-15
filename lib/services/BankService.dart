//账户服务中心
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/data/dataCenter.dart';

class BankService {
  // 弹出底部菜单列表模态对话框 账户选择
  static Future<int> showBankBottomSelect(context) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                    child: Text(
                      'Please select bank card',
                      style: TextStyle(fontSize: 18.0),
                    )),
                Expanded(
                    child: ListView.builder(
                  itemCount: eBankdatas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        child: Image.asset(
                          eBankdatas[index].logo,
                          //fit: BoxFit.cover,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                      title: RichText(
                        text: TextSpan(
                            text: '${eBankdatas[index].bankName}',
                            style: TextStyle(
                                color: Color(0xff222222),
                                fontSize: 16.0,
                                height: 1.5),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\n${eBankdatas[index].bankName}',
                                style: TextStyle(
                                    color: Color(0xffB2B2B2), fontSize: 14.0),
                              ),
                            ]),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  },
                ))
              ],
            ));
      },
    );
  }
}
