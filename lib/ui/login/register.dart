
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';

class RegisterPageView extends StatelessWidget {

  const RegisterPageView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyRegisterPageView(),
    );
  }
}

class MyRegisterPageView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Content.baseColor,);
  }

}