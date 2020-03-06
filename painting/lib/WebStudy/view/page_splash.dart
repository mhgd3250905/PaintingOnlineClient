import 'package:flutter/material.dart';
import 'package:painting/WebStudy/instance/instance_websocket.dart';
import 'package:painting/WebStudy/utils/device_utils.dart';
import 'package:painting/WebStudy/utils/navigator_router_utils.dart';
import 'package:painting/WebStudy/utils/share_preference_utils.dart';
import 'package:painting/WebStudy/view/home/page_home.dart';
import 'package:painting/WebStudy/view/room_list/page_room_list.dart';
import 'package:painting/res.dart';

import 'file:///D:/Android/Proj/PaintingOnlineClient/painting/lib/WebStudy/view/login/page_login.dart';

///闪屏界面
///3s后跳转
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceUtils.setBarStatus(true);
    return MaterialApp(
      home: Material(
        child: MainContent(),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  int start;
  int end;
  bool needJump = false;
  String account = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start = DateTime.now().millisecondsSinceEpoch;
    getAccount();

    WebsocketInstance.init();
  }

  //获取账号
  void getAccount() async {
    account = await SharedPreferenceUtil.get(
        SharedPreferenceUtil.KEY_REMOTE_USER_ID, '');
    end = DateTime.now().millisecondsSinceEpoch;

    int delay = 3000 - (end - start);

    Future.delayed(Duration(milliseconds: delay > 0 ? delay : 0), () {
      Widget jumpToPage;
      if (account.isEmpty) {
        jumpToPage = LoginPage();
      } else {
        jumpToPage = HomePage();
      }
      NavigatorRouterUtils.pushAndRemoveUntil(context, jumpToPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (needJump) {}
    return Material(
      child: Container(
        color: Colors.blue,
        child: Center(
          child: GestureDetector(
            onTap: () {
              NavigatorRouterUtils.pushToPage(context, RoomListPage());
            },
            child: Hero(
              tag: Res.HERO_TAG_SPLASH_TITLE,
              child: Text(
                '你画我猜',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
