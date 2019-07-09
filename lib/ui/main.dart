import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/widget/main_drawer.dart';
import 'package:ok_flutter/widget/main_list.dart';
import 'package:ok_flutter/widget/recyclerview.dart';

class MainPageView extends StatefulWidget {
  const MainPageView();

  @override
  State<StatefulWidget> createState() => _MainPageView();
}

class _MainPageView extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List _tabs = ["全宇宙", "自己"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "OkFlutter",
            style: Content.titleStyle,
          ),
          backgroundColor: Content.baseColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              color: Content.white,
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
              color: Content.white,
            )
          ],
          bottom: TabBar(
              controller: _tabController,
              tabs: _tabs
                  .map((item) => Tab(
                        text: item,
                      ))
                  .toList()),
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: _createTabBarView(),
        ),
      ),
    );
  }

  List<Widget> _createTabBarView() {
    List<Widget> child = [];
    for (int i = 0; i < _tabs.length; i++) {
//      child.add(MainList(_tabs[i], i));
      child.add(RecyclerView());
    }
    return child;
  }
}
