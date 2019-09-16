import 'package:flutter/material.dart';
import '../user_self/minedpage.dart';

import 'homeView.dart';

class Index extends StatefulWidget {
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<Widget> pageViewList2 = [HomeView(), MinePage()];
  int _nowindex = 0;

  Color itemOne = Colors.blue;
  Color itemTwo = Colors.grey;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: pageViewList2[_nowindex], //注意这行，千万不要少了。这是页面主体
        /*bottomNavigationBar: BottomNavigationBar(
          //设置内部的元素
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              //具体的菜单按钮元素
              icon: Image.asset('images/home.png',color: itemOne,), //设置图标,和颜色
              title: Text("主页",style: TextStyle(fontSize: 14.0)), //设置文字和颜色
            ),
            BottomNavigationBarItem(
              //具体的菜单按钮元素
              icon:  Image.asset('images/user.png',color: itemTwo), //设置图标,和颜色
              title: Text("我的",style: TextStyle(fontSize: 14.0),), //设置文字和颜色
            ),
          ],
          //关键点
          currentIndex: _nowindex, //设置当前显示的页面索引，使用已设定的属性。

          type: BottomNavigationBarType.fixed, //设置类型

          //设置点击响应
          onTap: (int index) {
            //参数设置为默认的index，这个index就是点击的按钮的index
            //setState  这个也是内置方法，只需要将index参数赋值给已设定的属性 _now_index;
            if(_nowindex != index){
              setState(() {
                _nowindex = index;
                Color color = itemOne;
                itemOne = itemTwo;
                itemTwo = color;
              });
            }
          },
        ),*/
      ),
    );
  }
}

/**
 * 底部导航继承的是动态StatefulWidget，注意。
 *
 *
 * Scaffold()组件的
    body ：主体显示组件
    bottomNavigationBar：BottomNavigationBar() 底部菜单导航属性，
 * BottomNavigationBar() 底部导航组件
 * items：设置按钮图标，文字
 * type: BottomNavigationBarType.fixed,//设置按钮类型，固定的
 * currentIndex: _nowindex,//设置当前显示的页面索引
 * onTap:(int index){}   点击响应，一般使用以下语法
    onTap: (int index){//参数设置为默认的index，这个index就是点击的按钮的index
    //setState  这个也是内置方法，只需要将index参数赋值给已设定的属性 _now_index;
    setState(() {
    _nowindex =index;
    });
    },
 *
 * 新建文件，命名方式 是讲类名全部小写，用_连接。例如home_view.dart,其中的主要类就是HomeView
 *
 */
