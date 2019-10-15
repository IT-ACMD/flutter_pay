//这是选择银行页面
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

class BankSelect extends StatefulWidget {
  final List<BankCode> favoriteElements;

  const BankSelect({Key key, this.favoriteElements}) : super(key: key);
  _BankSelectState createState() => _BankSelectState();
}

class _BankSelectState extends State<BankSelect> {
  List<BankCode> filteredElements;
  List<BankCode> elements;

  @override
  void initState() {
    List<Map> jsonList = eBanks;
    elements = jsonList
        .map((s) => BankCode(
            name: s['name'], numb: s['numb'], logo: s['logo'], summ: s['sumn']))
        .toList();
    filteredElements = elements;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarA(
        child: AppTitleBar(title: 'TinhTinh Pay'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              child: TextField(
                decoration:
                    InputDecoration().copyWith(prefixIcon: Icon(Icons.search)),
                onChanged: _filterElements,
              )),
          buildOptions(),
        ],
      )),
    );
  }

  buildOptions() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
            children: [
          const DecoratedBox(decoration: BoxDecoration()),
        ]..addAll(filteredElements.isEmpty
                ? [_buildEmptySearchWidget(context)]
                : filteredElements.map((e) => SimpleDialogOption(
                      key: Key(e.name),
                      child: _buildOption(e),
                      onPressed: () {
                        _selectItem(e);
                      },
                    )))));
  }

  Widget _buildOption(BankCode e) {
    return Container(
      width: 400,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          /*Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.network(
              e.logo,
              width: 32.0,
            ),
          ),*/
          Expanded(
            child: Text(
              e.name,
              overflow: TextOverflow.fade,
            ),
          ),
          Image.asset(
            'images/arrow_right.png',
            width: 16.0,
            height: 16.0,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    /*if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder(context);
    }*/
    return Center(child: Text('No Bank Found'));
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements =
          elements.where((e) => e.name.toUpperCase().contains(s)).toList();
    });
  }

  void _selectItem(BankCode e) {
    Navigator.pop(context, e);
  }
}

class BankCode {
  /// the name of the bank
  String name;

  /// the bank of the big num (102100099996) 大额行号
  String numb;

  /// the logo  (http://oo6o93zxg.bkt.clouddn.com//BankInfo/SPDB.png)
  String logo;

  /// the summ (单笔5万，日累计20万)
  String summ;

  BankCode({
    this.name,
    this.numb,
    this.logo,
    this.summ,
  });

  //@override
  //String toString() => "$dialCode";

  //String toLongString() => "$name $currency ";

  //String toCountryStringOnly() => '$name';
}

List<Map> eBanks = [
  //"status": 1000,
  //"desc": "Normal Returned",
  //"data": [
  {
    "summ": "单笔5万，日累计20万",
    "name": "中国农业银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo//ABC.png",
    "numb": "103100000026"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "中国银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/BOC.png",
    "numb": "104100000004"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "中国建设银行",
    "logo": 'images/ccb.png',//"http://oo6o93zxg.bkt.clouddn.com//BankInfo/CCB.png",
    "numb": "105100000017"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "中国邮政储蓄银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/PSBC.png",
    "numb": "403100000004"
  },
]; /*
  {
    "summ": "单笔5万，日累计20万",
    "name": "浦发银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/SPDB.png",
    "numb": "310290000013"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "中国工商银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/ICBC.png",
    "numb": "102100099996"
  },

  {
    "summ": "单笔5万，日累计20万",
    "name": "交通银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/BCM.png",
    "numb": "301290000007"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "中信银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/CITIC.png",
    "numb": "302100011000"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "招商银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/CMB.png",
    "numb": "308584000013"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "中国光大银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/CEB.png",
    "numb": "303100000006"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "华夏银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/HXBANK.png",
    "numb": "304100040000"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "民生银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/CMBC.png",
    "numb": "305100000013"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "广发银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/BCM.png",
    "numb": "306581000003"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "兴业银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/CIB.png",
    "numb": "309391000011"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "平安银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/PAB.png",
    "numb": "307584007998"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "恒丰银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/HF.png",
    "numb": "315456000105"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "浙商银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/ZHESHANG.png",
    "numb": "316331000018"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "渤海银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/BH.png",
    "numb": "318110000014"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "北京银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/BOB.png",
    "numb": "313100000013"
  },
  {
    "summ": "单笔5万，日累计20万",
    "name": "上海银行",
    "logo": "http://oo6o93zxg.bkt.clouddn.com//BankInfo/BCM.png",
    "numb": "325290000012"
  }
];*/
