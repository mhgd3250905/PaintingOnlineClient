import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'page_home.dart';

class InputPage extends StatefulWidget {
  TextEditingController _textEditingController = new TextEditingController();
  final IOWebSocketChannel channel;

  InputPage({Key key, this.channel}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          height: 120.0,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  '请输入你的答案：',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              buildInputContainer(),
            ],
          ),
        ),
      ),
    );
  }

  //构建输入框
  Widget buildInputContainer() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Material(
        color: Colors.transparent,
        child: Theme(
          data: new ThemeData(
            primaryColor: Colors.blueAccent,
            hintColor: Colors.blueAccent,
          ),
          child: TextField(
            controller: widget._textEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10.0, right: 5.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.5),
              ),
              prefixIcon: Icon(Icons.color_lens),
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
            onSubmitted: (text) {
              print('onSubmitted:${text}');
              widget.channel.sink.add("${USER_MSG_FLAG}${text}");
              widget._textEditingController.clear();
              Navigator.of(context).pop();
            },
//            onEditingComplete: () {
//              print('onSubmitted:${widget._textEditingController.value}');
//            },
          ),
        ),
      ),
    );
  }
}
