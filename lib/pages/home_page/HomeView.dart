//这是HomeView类的控制页
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'MyDrawer.dart';
import 'QRCode.dart';

class HomeView extends StatefulWidget {
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  static List<InfoService> topInfos = const <InfoService>[
    const InfoService(title: 'Scan QR', imageUrl: 'images/scan.png'),
    const InfoService(
        title: 'Payment code', imageUrl: 'images/receipt_code.png'),
    const InfoService(
        title: 'Receivables Code', imageUrl: 'images/payment_code.png'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            AppTitleBar(title: 'TinhTinh Pay'),
            buildTitleCode(),
            buildInfomationServices(),
            buildHotEvents(),
            Container(
              color: Color(0xffFDEFEC),
              height: 30.0,
            )
          ],
        )),
        drawer: Drawer(
          child: MyDrawer(),
        ));
  }

  buildSearchBar() {
    return Container(
        padding: EdgeInsets.fromLTRB(16.0, 50.0, 17.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(),
            Container(
              width: 250.0,
              child: RaisedButton.icon(
                color: Color(0xFFF4F4F4),
                icon: Image.asset(
                  'images/search.png',
                  height: 18.0,
                  width: 18.0,
                ),
                label: Text(
                  '请输入你要搜索的内容',
                  style: TextStyle(fontSize: 14.0, color: Color(0xFF999999)),
                ),
                onPressed: () {
                  /*showSearch(
                    context: context,
                    delegate: SearchBarDelegate(),
                  );*/
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0))),
              ),
            ),
            Image.asset(
              'images/message.png',
              height: 20.0,
              width: 20.0,
              color: Colors.white,
            ),
          ],
        ));
  }

  buildTitleCode() {
    return Container(
      color: Color(0xffdd644f),
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(topInfos.length, (i) {
          return Expanded(
              child: InkWell(
            child: Column(
              children: <Widget>[
                Image.asset(
                  topInfos[i].imageUrl,
                  width: 48.0,
                  height: 48.0,
                  //color: Colors.blue,
                  fit: BoxFit.cover,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 9.0),
                    child: Text(
                      topInfos[i].title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
            onTap: () {
              if (i == 0) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return QRCodePage();
                }));
              } else if (i == 1) {}
            },
          ));
        }),
      ),
    );
  }

  List<InfoService> infoServicesData = [
    InfoService(
        title: 'Transfer accounts',
        imageUrl: 'images/transfer_accounts.png',
        linkUrl: '转账'),
    InfoService(
        title: 'Recharge', imageUrl: 'images/recharge.png', linkUrl: ''),
    InfoService(
        title: 'Cash withdrawal',
        imageUrl: 'images/cash_withdrawal.png',
        linkUrl: ''),
    InfoService(
        title: 'Exchange remittance',
        imageUrl: 'images/exchange_remittance.png',
        linkUrl: ''),
    InfoService(
        title: 'Virtual Card',
        imageUrl: 'images/virtual_card.png',
        linkUrl: ''),
    InfoService(title: 'Account', imageUrl: 'images/account.png', linkUrl: ''),
    InfoService(
        title: 'Living expenses',
        imageUrl: 'images/living_expenses.png',
        linkUrl: ''),
    InfoService(
        title: 'Contact us', imageUrl: 'images/contact_us.png', linkUrl: ''),
    InfoService(
        title: 'My ThinThin', imageUrl: 'images/my_thinthin.png', linkUrl: '')
  ];

  buildInfomationServices() {
    return Container(
        color: Color(0xffFDEFEC),
        child: Container(
            margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 15.0),
            decoration: BoxDecoration(
                color: Color(0xffff0000),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.55,
                  colors: [
                    const Color(0xffc74f3a), //0xffdd644f  0xffc74f3a
                    const Color(0xffFDEFEC)
                  ], // whitish to gray
                  tileMode:
                      TileMode.clamp, // repeats the gradient over the canvas
                )),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 0.83,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              physics: new NeverScrollableScrollPhysics(),
              children: List.generate(
                infoServicesData.length,
                (index) {
                  InfoService infos = infoServicesData[index];
                  return InkWell(
                    child: Container(
                        color: Color(0xffFDEFEC),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              infos.imageUrl,
                              width: 42.0,
                              height: 42.0,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  infos.title,
                                  style: TextStyle(
                                      color: Color(0xffc74f3a), fontSize: 10.0),
                                ))
                          ],
                        )),
                    onTap: () {
                      Navigator.of(context).pushNamed(infos.linkUrl);
                    },
                  );
                },
              ),
            )));
  }

  buildHotEvents() {
    return Image.asset(
      'images/activity.png',
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class InfoService {
  const InfoService({this.title, this.imageUrl, this.linkUrl});
  final String title;
  final String imageUrl;
  final String linkUrl;
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}