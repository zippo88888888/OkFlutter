import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/local_bean.dart';
import 'package:ok_flutter/util/system_util.dart';

class MyApp extends StatelessWidget {
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
        ),
        drawer: MyHomeDrawer(),
      ),
    );
  }
}

class MyHomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomeDrawerState();
}

class _MyHomeDrawerState extends State<StatefulWidget> {
  final String _userIcon = Content.userIcon1;
  final String _userName = "我使用户名";
  final String _sex = Content.gg;
  final String _createTime = "2019年7月加入";

  final List<MainNVItemBean> _items = List<MainNVItemBean>();

  final double _itemPicWH = 28.0;

  // 初始化数据
  _init() {
    _items.add(MainNVItemBean(Content.mm, "个人信息"));
    _items.add(MainNVItemBean(Content.mm, "主题更换"));
    _items.add(MainNVItemBean(Content.mm, "关于"));
    _items.add(MainNVItemBean(Content.mm, "开源库"));
    _items.add(MainNVItemBean(Content.mm, "退出登录"));
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 100.0,
      child: MediaQuery.removePadding(
        context: context,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment(-1.0, 0.2),
              children: <Widget>[
                Container(
                  height: 200,
                  child: Image.asset(
                    Content.bg1,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: Content.defaultPadding * 2,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(_userIcon),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            _userName,
                            style: Content.titleStyle,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Image.asset(_sex),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Text(
                                _createTime,
                                style: TextStyle(
                                    fontSize: 11, color: Content.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: () {
                      SystemUtil.showToast(msg: _items[position].title);
                    },
                    child: ListTile(
                      leading: SizedBox(
                        width: _itemPicWH,
                        height: _itemPicWH,
                        child: Image.asset(_items[position].picPath),
                      ),
                      title: Text("${_items[position].title}"),
                    ),
                  );
                },
                itemCount: _items.length,
              ),
            )
          ],
        ),
        removeTop: true,
      ),
    );
  }
}

