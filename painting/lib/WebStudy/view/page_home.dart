import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painting/WebStudy/utils/share_preference_utils.dart';
import 'package:web_socket_channel/io.dart';

import 'view_home_content.dart';

class HomePage extends StatefulWidget {
  final channel =
      new IOWebSocketChannel.connect('ws://49.234.76.105:80/chatroom/1/listen');

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccount();
  }

  void getAccount() async {
    String account =
        await SharedPreferenceUtil.get(SharedPreferenceUtil.KEY_REMOTE_USER_ID);
    print('userId : ${account}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      routes: {'/input': (BuildContext context) => InputPage()},
      home: ViewHomeContent(channel: widget.channel),
    );
  }
}
