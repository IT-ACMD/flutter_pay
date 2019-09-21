import 'package:flutter/material.dart';
import 'package:flutter_app/data/dataCenter.dart';

class MyDrawer extends StatelessWidget {
  // 菜单文本前面的图标大小
  static const double IMAGE_ICON_WIDTH = 30.0;
  // 菜单后面的箭头的图标大小
  static const double ARROW_ICON_WIDTH = 16.0;
  // 菜单后面的箭头图片
  var rightArrowIcon = Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );
  // 菜单的文本
  List menuTitles = [
    'Transfer accounts',
    'Recharge',
    'Cash withdrawal',
    'Exchange remittance',
    'Virtual Card',
    'Account',
    'Living expenses',
    'Contact us',
    'My ThinThin'
  ];

  // 菜单文本前面的图标
  List menuIcons = [
    'images/transfer_accounts_s.png',
    'images/recharge_s.png',
    'images/cash_withdrawal_s.png',
    'images/exchange_remittance_s.png',
    'images/virtual_card_s.png',
    'images/account_s.png',
    'images/living_expenses_s.png',
    'images/contact_us_s.png',
    'images/my_thinthin_s.png'
  ];
  // 菜单文本的样式
  TextStyle menuStyle = TextStyle(
    fontSize: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 259.0),
      child: Material(
        color: Color(0xffDB6B52),
        elevation: 16.0,
        child: ListView.builder(
          itemCount: menuTitles.length + 3,
          itemBuilder: renderRow,
          padding: const EdgeInsets.all(0.0), // 加上这一行可以让Drawer展开时，状态栏中不显示白色
        ),
      ),
    );
  }

  Widget getIconImage(path) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 6.0, 0.0),
      child: Image.asset(path, width: 28.0, height: 28.0),
    );
  }

  Widget renderRow(BuildContext context, int index) {
    if (index == 0) {
      // render cover image
      var img = Image.asset(
        'images/default_avatar.png',
        width: 68.0,
        height: 68.0,
        fit: BoxFit.cover,
      );
      return Container(
        height: 211.0,
        alignment: Alignment.bottomCenter,
        //padding: EdgeInsets.symmetric(vertical: 30.0),
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(80.0))),
                child: ClipOval(
                  child: img,
                )),
            Container(
                padding: EdgeInsets.only(left: 26.0),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Welcome',
                      style: TextStyle(
                          color: Color(0xffFF9A6C),
                          fontWeight: FontWeight.w500,
                          height: 1.3),
                      children: <TextSpan>[
                        TextSpan(
                            text: '\n${eUserInfo.name}',
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                            text: '\nYour ID ：${eUserInfo.cardId}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10.0))
                      ]),
                ))
          ],
        ),
      );
    }

    if (index == 1) {
      return Container(
        margin: EdgeInsets.only(bottom: 12.0),
        color: Color(0xffC74F3A),
        height: 2.0,
      );
    }

    if(index == menuIcons.length + 2){
      return SizedBox(height: 150,);
    }

    index -= 2;

    var listItemContent = Padding(
      // 设置item的外边距
      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
      // Row组件构成item的一行
      child: Row(
        children: <Widget>[
          // 菜单item的图标
          getIconImage(menuIcons[index]),
          // 菜单item的文本，需要
          Expanded(
              child: Text(
            menuTitles[index],
            style: menuStyle,
          )),
          //rightArrowIcon
        ],
      ),
    );

    return InkWell(
      child: listItemContent,
      onTap: () {},
    );
  }
}
