import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/data/bankData.dart';
import 'package:flutter_app/data/userInfo.dart';
import 'package:flutter_app/tools/ECHttp.dart';
import 'package:flutter_app/tools/Filehelper.dart';

import 'accountData.dart';

//是否测试
final eIsTest = false;
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
  getCurrentList();

  //获取所有银行卡
  getUserBankAll();
}

List<BankInfo> eBankdatas = [];
//
getUserBankAll() async {
  List list = [
    {'name': 'authorization', 'value': 'bearer ${eUserInfo.accessToken}'},
  ];
  String result = await ECHttp.getData('user/user-bank/selectBankId', list);
  if (result != null) {
    var jsonData = json.decode(result);
    if (jsonData['success']) {
      eBankdatas.clear();
      List list = jsonData['data'];
      for (int i = 0; i < list.length; ++i) {
        BankInfo bank = BankInfo();
        bank.id = list[i]['uuid'];
        bank.bankName = list[i]['bankName'];
        bank.branch = list[i]['branch'];
        bank.cardNumber = list[i]['cardNumber'];
        bank.cardUser = list[i]['cardUser'];
        if (bank.bankName == "中国建设银行")
          bank.logo = 'images/ccb.png';
        else if (bank.bankName == "中国邮政储蓄银行")
          bank.logo = 'images/psbc.png';
        else if (bank.bankName == "中国农业银行")
          bank.logo = 'images/abc.png';
        else if (bank.bankName == "中国银行") bank.logo = 'images/boc.png';
        eBankdatas.add(bank);
      }
    }
  }
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
      eAccountList.clear();
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

Map efromCurrency; //默认兑汇账户付钱
Map etoCurrency; //默认兑汇账户收钱

List<Map> eCodes = [
  {
    "name": "China",
    "code": "CN",
    "dial_code": "+93",
    "currency": "CNY",
  },
  {
    "name": "United Kingdom",
    "code": "GB",
    "dial_code": "+358",
    "currency": "GBP",
  },
  {
    "name": "United States",
    "code": "US",
    "dial_code": "+355",
    "currency": "USD",
  },
  {
    "name": "Japan",
    "code": "JP",
    "dial_code": "+213",
    "currency": "JPY",
  },
  {
    "name": "European Union",
    "code": "EU",
    "dial_code": "+1684",
    "currency": "EUR",
  },
  {
    "name": "Hong Kong",
    "code": "HK",
    "dial_code": "+1684",
    "currency": "HKD",
  },
];
//获取所有币种
getCurrentList() async {
  List hears = [
    {'name': 'authorization', 'value': 'bearer ${eUserInfo.accessToken}'}
  ];
  String data = await ECHttp.getData('currency/tpay-currency/list', hears);
  if (data != null && data.length > 0) {
    var jsonData = json.decode(data);
    if (jsonData['success']) {
      List list = jsonData['data']['records'];
      List<Map> codes = List();
      codes.addAll(eCodes);
      eCodes.clear();
      for (int i = 0; i < list.length; ++i) {
        String id = list[i]['uuid'];
        String currencyCode = list[i]['currencyCode'];
        for (int j = 0; j < codes.length; ++j) {
          if (codes[j]['currency'] == currencyCode) {
            codes[j]['id'] = id;
            eCodes.add(codes[j]);
            if (codes[j]['currency'] == 'USD') {
              efromCurrency = codes[j];
            }
            if (codes[j]['currency'] == 'CNY') {
              etoCurrency = codes[j];
            }
            codes.remove(codes[j]);
            j--;
          }
        }
      }
    }
  }
}
/*"uuid":"0dda153bb5de49988aa846be5a39c986",
"currencyName":"港元",
"currencyCode":"HKD",
"country":"香港",
"createAt":{"date":{"year":2019,"month":9,"day":6},
"time":{"hour":20,"minute":3,"second":55,"nano":0}*/

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
