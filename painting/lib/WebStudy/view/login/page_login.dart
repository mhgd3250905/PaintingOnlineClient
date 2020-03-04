import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:painting/WebStudy/utils/device_utils.dart';
import 'package:painting/WebStudy/utils/navigator_router_utils.dart';
import 'package:painting/WebStudy/utils/share_preference_utils.dart';

import 'file:///D:/Android/Proj/PaintingOnlineClient/painting/lib/WebStudy/view/home/page_home.dart';

///登录界面
///没有用户名的时候需要设置用户名
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceUtils.setBarStatus(true);
    return MaterialApp(
      home: MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildTitle(),
            buildInputContainer(),
            buildCommitButtom(),
          ],
        ),
      ),
    );
  }

  //创建标题
  Widget buildTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        '用户名',
        style: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: Colors.yellowAccent,
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  //创建输入框
  Widget buildInputContainer() {
    return Container(
      padding: const EdgeInsets.only(
        left: 5.0,
        right: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        border: Border.all(
          width: 3.0,
          color: Colors.yellowAccent,
        ),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(6),
        ],
        maxLines: 1,
        cursorWidth: 4.0,
        cursorColor: Colors.yellowAccent,
        controller: _controller,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.yellowAccent,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15.0),
          border: InputBorder.none,
        ),
      ),
    );
  }

  //创建提交按钮
  Widget buildCommitButtom() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20.0,
      ),
      height: 55.0,
      child: FlatButton(
        color: Colors.yellowAccent,
        onPressed: () {
          SharedPreferenceUtil.save(
            SharedPreferenceUtil.KEY_REMOTE_USER_ID,
            _controller.text,
          ).whenComplete(() {
            NavigatorRouterUtils.pushAndRemoveUntil(context, HomePage());
          }).catchError((e) {});
        },
        child: Icon(
          IconData(0xe601, fontFamily: 'Myicons'),
          color: Colors.blue,
          size: 25.0,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
