//这是选择国家页面
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/AppTitleBar.dart';
import 'package:flutter_app/widget/title_barA.dart';

import 'country_codes.dart';

class CountryCodeSelect extends StatefulWidget {
  _CountryCodeSelectState createState() => _CountryCodeSelectState();
}

class _CountryCodeSelectState extends State<CountryCodeSelect> {
  List<CountryCode> filteredElements;
  List<CountryCode> elements;

  @override
  void initState() {
    List<Map> jsonList = codes;
    elements = jsonList
        .map((s) => CountryCode(
              name: s['name'],
              code: s['code'],
              dialCode: s['dial_code'],
              flagUri: 'flags/${s['code'].toLowerCase()}.png',
            ))
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
                      key: Key(e.toLongString()),
                      child: _buildOption(e),
                      onPressed: () {
                        _selectItem(e);
                      },
                    )))));
  }

  Widget _buildOption(CountryCode e) {
    return Container(
      width: 400,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                e.flagUri,
                package: 'country_code_picker',
                width: 32.0,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              e.toLongString(),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    /*if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder(context);
    }*/
    return Center(child: Text('No Country Found'));
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = elements
          .where((e) =>
              e.code.contains(s) ||
              e.dialCode.contains(s) ||
              e.name.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CountryCode e) {
    Navigator.pop(context, e);
  }
}
