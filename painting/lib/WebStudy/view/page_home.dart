import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painting/WebStudy/view/view_home_content.dart';
import 'package:web_socket_channel/io.dart';

const String USER_MSG_FLAG = "[-MSG-]";

class HomePage extends StatefulWidget {
  final channel =
      new IOWebSocketChannel.connect('ws://49.234.76.105:80/chatroom/1/listen');

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      routes: {'/input': (BuildContext context) => InputPage()},
      home: ViewHomeContent(channel: widget.channel),
    );
  }
}
