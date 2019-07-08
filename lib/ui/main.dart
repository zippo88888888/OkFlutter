import 'package:flutter/material.dart';
import 'package:ok_flutter/base/content.dart';
import 'package:ok_flutter/bean/local_bean.dart';
import 'package:ok_flutter/util/jump_util.dart';
import 'package:ok_flutter/util/system_util.dart';
import 'package:ok_flutter/util/user_util.dart';

class MainPageView extends StatelessWidget {
  const MainPageView();

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
  String _userIcon = "";
  String _userName = "";
  String _sex = Content.gg;
  String _createTime = "";

  final List<MainNVItemBean> _items = List<MainNVItemBean>();

  final double _itemPicWH = 28.0;

  // TODO 初始化数据  这里还有很大的问题
  _init() {
    UserUtil.getIcon((icon) {
      var newIcon = icon.toString();
      if (newIcon != null && newIcon.length > 0 && "null" != newIcon) {
        _userIcon = newIcon;
      } else {
        _userIcon = Content.userIcon1;
      }
    });
    UserUtil.getName((name) => _userName = name.toString() ?? "OKFlutter");
    UserUtil.getSex(
        (sex) => _sex = (sex == null || sex) ? Content.gg : Content.mm);
    UserUtil.getTime((time) {
      var newTime = time.toString();
      if (newTime != null && newTime.length > 0 && "null" != newTime) {
        var dateTime = DateTime.parse(newTime);
        _createTime = "${dateTime.year}年${dateTime.month}月加入";
      } else {
        _createTime = "2019年7月加入";
      }
      setState(() {});
    });
    _items.add(MainNVItemBean(Content.mm, "个人信息"));
    _items.add(MainNVItemBean(Content.mm, "主题更换"));
    _items.add(MainNVItemBean(Content.mm, "关于"));
    _items.add(MainNVItemBean(Content.mm, "开源库"));
    _items.add(MainNVItemBean(Content.mm, "退出登录"));
  }

  _onItemClick(int position) {
    switch (position) {
      case 0:
        SystemUtil.showToast(msg: "个人信息");
        break;
      case 1:
        SystemUtil.showToast(msg: "主题更换");
        break;
      case 2:
        SystemUtil.showToast(msg: "关于");
        break;
      case 3:
        SystemUtil.showToast(msg: "开源库");
        break;
      case 4:
        showDialog(
            context: context,
            builder: (_context) => AlertDialog(
              title: Text('温馨提示'),
              content: Text(('你确定要推出登录吗？')),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("取消"),
                  onPressed: () {
                    Navigator.of(_context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: () {
                    Navigator.of(_context).pop();
                    UserUtil.loginOut((_) {
                      SystemUtil.showToast(msg: "退出登录成功");
                      JumpUtil.jumpToLoginPage2(context);
                    });
                  },
                ),
              ],
            ));

        break;
    }
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
                    onTap: () => _onItemClick(position),
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
