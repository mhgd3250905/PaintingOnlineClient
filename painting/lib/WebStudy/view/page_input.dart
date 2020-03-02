import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painting/res.dart';
import 'package:web_socket_channel/io.dart';

class InputPage extends StatefulWidget {
  final IOWebSocketChannel channel;

  InputPage({Key key, this.channel}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController _textEditingController = new TextEditingController();

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
                margin: const EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  '你的答案',
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
    print('test:input ${_textEditingController.text.length}');
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Material(
        color: Colors.transparent,
        child: Theme(
          data: new ThemeData(
            primaryColor: Colors.blueAccent,
            hintColor: Colors.blueAccent,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.black87, width: 1.0)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.0, right: 5.0),
                        border: InputBorder.none,
//                    prefixIcon: Icon(Icons.mood),
//                    suffixIcon: Icon(Icons.remove_red_eye),
                        hintText: '输入后点按回车结束',
                        hintStyle: TextStyle(color: Colors.grey)),
                    onSubmitted: (text) {
//                      print('onSubmitted:${text}');
                      widget.channel.sink.add("${Res.USER_MSG_FLAG}${text}");
                      _textEditingController.clear();
                      Navigator.of(context).pop();
                    },
//            onEditingComplete: () {
//              print('onSubmitted:${widget._textEditingController.value}');
//            },
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
                Offstage(
                  offstage: _textEditingController.text.isEmpty ? true : false,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _textEditingController.clear();
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 45,
                      child: Icon(
                        Icons.cancel,
                        color: Colors.grey,
                        size: 17,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.channel.sink.add(
                        "${Res.USER_MSG_FLAG}${_textEditingController.text}");
                    _textEditingController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    child: Icon(
                      Icons.subdirectory_arrow_left,
                      color: Colors.grey,
                      size: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
