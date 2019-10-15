//账户服务中心
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/data/dataCenter.dart';

class AccountService {
  // 弹出底部菜单列表模态对话框 账户选择
  static Future<int> showAcoutBottomSelect(context) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: eAccountList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                  '${eAccountList[index].currency_code} (${eAccountList[index].amount})'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
  }


}
