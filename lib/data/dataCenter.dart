import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/data/userInfo.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/Filehelper.dart';

import 'accountData.dart';

//是否测试
final eIsTest = true;
//用户信息
final eUserInfo = UserInfo();
//用户默认账户信心
AccountData eDefaulAccount = AccountData(amount: '500.0', currency_code: 'USD');
//该用户所有的账户信息
final List<AccountData> eAccountList = [];

String getToken() {
  if (eUserInfo != null && eUserInfo.accessToken != null) {
    return 'bearer ${eUserInfo.accessToken}';
  } else {
    return 'Basic ${base64Encode(utf8.encode('fuhk:fuhksecret'))}';
    //return 'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1Njg4MDU0MTEsInVzZXJfbmFtZSI6IjQ1OTA0ZTg2Njk5ZDQzNDg4MDgyNjZmODhkM2QwNWQxIiwiYXV0aG9yaXRpZXMiOlsiYWRtaW4iLCJST0xFX1VTRVIiXSwianRpIjoiMzE2ZDQ3MDMtMTA3NS00MGEzLWIwZmQtMzIwNTAyN2ExNTY3IiwiY2xpZW50X2lkIjoiZnVoayIsInNjb3BlIjpbImFsbCJdfQ.X3IariIlr6r08oSpwsswlpbPAyOcfkAEWliTdWlmUxY';
  }
}

//根据token去登陆
toLoginByToken() async {
  List hears = [
    {'name': 'authorization', 'value': 'bearer ${eUserInfo.accessToken}'}
  ];
  String isNewPeople = await ECHttp.getData('user/user/get', hears);
  if (isNewPeople != null && isNewPeople.length > 0) {
    var object1 = json.decode(isNewPeople);
    if (object1['success'] && object1['data'] != null) {
      afterLogin();
      return true;
    }
  }
  return false;
}

afterLogin() {
  //获取用户信息
  getUserData();

  //获取用户账户信息
  getAccountList();

  //token值保存本地文件
  //writeToFile();

  //获取所有币种
  //getCurrentList();
}

//获取用户的所有有账户信息
getAccountList() async {
  List hears = [
    {'name': 'authorization', 'value': 'bearer ${eUserInfo.accessToken}'}
  ];
  String data = await ECHttp.getData('account/Account', hears);
  if (data != null && data.length > 0) {
    var jsonData = json.decode(data);
    if (jsonData['success']) {
      List list = jsonData['data'];
      for (int i = 0; i < list.length; ++i) {
        AccountData accountData = new AccountData();
        accountData.amount = list[i]['amount'].toString();
        accountData.currency_uuid = list[i]['currency_uuid'];
        accountData.currency_code = list[i]['currency_code'];
        accountData.currency_name = list[i]['currency_name'];
        accountData.country = list[i]['country'];
        eAccountList.add(accountData);
        if (accountData.currency_code == 'USD') {
          eDefaulAccount = accountData;
        }
      }
    }
  }
}

//获取所有币种
getCurrentList() async {
  List hears = [
    {'name': 'authorization', 'value': 'bearer ${eUserInfo.accessToken}'}
  ];
  String data = await ECHttp.getData('currency/tpay-currency/list', hears);
  if (data != null && data.length > 0) {
    var jsonData = json.decode(data);
    if (jsonData['success']) {}
  }
}

//
//创建文件写入token
writeToFile() async {
  String url = await Filehelper.getAppdataUrl();
  File token = new File('$url/$eUserInfo.accessToken');
  token.writeAsString(eUserInfo.accessToken);
}

//修改账号信息
setAccoutRateAlert(Map map) async {
  /*Map map = {
    'heartRateAlert': value,
  };*/
  String data = await ECHttp.postDataJson('user/user/save', map);
  if (data != null && data.length > 0) {
    var jsonData = json.decode(data);
    if (jsonData['success']) {
      return true;
    }
  }
  return false;
}

getUserData() async {
  //获取详细信息
  List hears = [
    {'name': 'authorization', 'value': 'bearer ${eUserInfo.accessToken}'}
  ];
  String userData = await ECHttp.getData('user/user/getUser', hears);
  if (userData != null && userData.length > 0) {
    var jsonData = json.decode(userData);
    if (jsonData['success']) {
      eUserInfo.sex = jsonData['data']['userInfo']['sex'] == 1 ? '女' : '男';
      eUserInfo.phone = jsonData['data']['userInfo']['phone'];
      eUserInfo.pwdPhone = eUserInfo.phone
          .replaceRange(2, eUserInfo.phone.length - 2, '*******');
      eUserInfo.email = jsonData['data']['userInfo']['email'];
      eUserInfo.identityCard = jsonData['data']['userInfo']['identity_Card'];
      eUserInfo.cardId = jsonData['data']['userInfo']['cardId'];
      eUserInfo.name = jsonData['data']['userName'];
      //eUserInfo.age
    }
  }
}
