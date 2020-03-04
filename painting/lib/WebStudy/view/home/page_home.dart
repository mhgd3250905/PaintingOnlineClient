import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painting/WebStudy/instance/instance_websocket.dart';
import 'package:painting/WebStudy/utils/device_utils.dart';

import 'view_home_content.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainContent();
  }
}

class MainContent extends StatefulWidget {
  MainContent();

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeviceUtils.setBarStatus(true);
    return MaterialApp(
//      routes: {'/input': (BuildContext context) => InputPage()},
      home: ViewHomeContent(channel: WebsocketInstance().channel),
    );
  }
}
