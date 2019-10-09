import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//引入自定义的其他页面文件
import 'SplashScreen.dart';
import 'pages/exchange_rate/ExchangeRemittance.dart';
import 'pages/home_page/AccountBalance.dart';
import 'pages/home_page/AccountPage.dart';
import 'pages/home_page/CashWithDrawal.dart';
import 'pages/home_page/CashWithDrawalBank.dart';
import 'pages/home_page/ContactUs.dart';
import 'pages/home_page/Index.dart';
import 'pages/home_page/RechargeDtod.dart';
import 'pages/home_page/RechargePage.dart';
import 'pages/home_page/SetUpMessage.dart';
import 'pages/home_page/TransferAccounts.dart';
import 'pages/home_page/VirtualCard.dart';
import 'pages/login_register/loginView.dart';
import 'pages/my_self/MinedPage.dart';
import 'pages/my_self/MyBankCard.dart';
import 'pages/my_self/MyCardBag.dart';
import 'pages/my_self/MySetUp.dart';

main() async {
  runApp(MyApp(true));
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  //是否近期成功登录过
  /*String url = await Filehelper.getAppdataUrl();
  File token = new File('$url/$accessTokenName');
  bool isNeedLogin = true;
  bool isExists = await token.exists();
  if (isExists) {
    token.readAsString().then((content) {
      eUserInfo.accessToken = content;
      toLoginByToken().then((res) {
        if (res) {
          isNeedLogin = false;
        } else {
          eUserInfo.accessToken = null;
        }
        ;
        runApp(MyApp(isNeedLogin));
      });
    });
  } else {
    
  }*/
}

class MyApp extends StatelessWidget {
  bool _login = true;
  MyApp(bool isNeedLogin) {
    _login = isNeedLogin;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '项目标题',
      theme: ThemeData(
          primaryColor: Color(0xffc74f3a), accentColor: Colors.white), //设置为黑色主题
      home: SplashScreen(), //,//BottomMenu(),//这个类在，bottom_menu.dart  中定义。LoginView()
      routes: <String, WidgetBuilder>{
        'loginPage': (_) => LoginView(),
        'home': (_) => Index(),
        '转账': (_) => TransferAccounts(),
        '我的': (_) => MinedPage(),
        '充值': (_) => RechargePage(),
        '预约充值': (_) => RechargeDtod(),
        '兑汇': (_) => ExchangeRemittance(),
        '虚拟卡': (_) => VirtualCard(),
        '账户': (_) => AccountPage(),
        '联系我们': (_) => ContactUs(),
        '提现': (_) => CashWithDrawal(),
        '提现银行卡': (_) => CashWithDrawalBank(),
        '账户余额': (_) => AccountBalance(),
        '我的卡包': (_) => MyCardBag(),
        '我的设置': (_) => MySetUp(),
        '我的银行卡': (_) => MyBankCard(),
        '消息接收': (_) => SetUpMessage(),
      },
    );
  }
}
