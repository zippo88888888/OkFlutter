import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'content.dart';

/// 简单封装通用类似 Android ToolBar
class ToolBar extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final bool centerTitle;
  final Color backgroundColor;
  final List<Widget> actions;
  final Widget body;

  const ToolBar({
    @required this.title,
    this.titleStyle = Content.titleStyle,
    this.centerTitle = true,
    this.backgroundColor = Content.baseColor,
    this.actions,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: titleStyle,
          ),
          centerTitle: centerTitle,
          backgroundColor: backgroundColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          actions: actions,
        ),
        body: body,
      ),
    );
  }
}
