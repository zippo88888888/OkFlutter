import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';

class MainList extends StatefulWidget {
  final String _title;
  final int _position;

  MainList(this._title, this._position);

  @override
  State<StatefulWidget> createState() => _MainListView(_title, _position);
}

class _MainListView extends State<MainList> {

  final String _title;
  final int _position;

  _MainListView(this._title, this._position);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Content.defaultPadding, right: Content.defaultPadding),
      child: RefreshIndicator(

      ),
    );
  }
}
