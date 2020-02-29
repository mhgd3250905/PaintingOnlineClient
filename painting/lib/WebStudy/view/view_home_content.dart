import 'package:flutter/material.dart';
import 'package:painting/WebStudy/model/model_net_data.dart';
import 'package:painting/WebStudy/model/model_paint.dart';
import 'package:painting/WebStudy/view/view_draw.dart';
import 'package:web_socket_channel/io.dart';

import 'page_home.dart';
import 'page_input.dart';

class ViewHomeContent extends StatefulWidget {
  final IOWebSocketChannel channel;
  ViewHomeContent({Key key, this.channel}) : super(key: key);

  @override
  _ViewHomeContentState createState() => _ViewHomeContentState();
}

class _ViewHomeContentState extends State<ViewHomeContent>
    with WidgetsBindingObserver {
  PPosBox _pPosBox; //绘画数据管理器
  Offset _pos = Offset(0, 0);
  Color paintColor = Colors.black; //画笔颜色
  double paintWidth = 2.0; //画笔宽度
  String lastData = ''; //上次的数据，用于对比接收数据的flag
  bool isPainting = true; //时候处于绘画
  StringBuffer inputContents = new StringBuffer(); //保存数据
  List<String> inputArr = [];
  String lastInfo = ''; //用来对比接收数据避免重复的flag
  TextEditingController textController; //文本编辑监听

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    super.didChangeMetrics();
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    print('didChangeMetrics bottom: ${bottom}');
  }

  @override
  void initState() {
    super.initState();
    _pPosBox = new PPosBox();
    textController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '你画我猜',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
            color: Colors.black87,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                buildMainMenu(),
                Expanded(
                  child: buildPaintContainer(),
                ),
                buildWidthMenu(),
                buildColorMenu(),
//                buildInputContainer(),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.question_answer,
          color: Colors.red,
        ),
        onPressed: () {
//          Navigator.pushNamed(context, '/input');
//          NavigatorRouterUtils.pushToPage(context, InputPage());
          showDialog(
              context: context, child: InputPage(channel: widget.channel));
        },
      ),
    );
  }

  //创建宽度按钮
  Widget buildWidthButton(
      Color color, double radius, bool checked, VoidCallback onPressed) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 20.0,
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: checked
                      ? Icon(
                          Icons.keyboard_arrow_down,
                          color: paintColor,
                        )
                      : Container(),
                ),
                CircleAvatar(
                  backgroundColor: color,
                  radius: radius,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //创建主菜单按钮
  Widget buildMainButton(String title, bool checked, VoidCallback onPressed) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(
            top: 10.0, left: 5.0, right: 5.0, bottom: 5.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey[300],
              offset: Offset(1.0, 1.0), //阴影xy轴偏移量
              blurRadius: 1.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
              )
        ]),
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: !checked ? Colors.white : Colors.black87,
              borderRadius: BorderRadius.circular(2.5),
              border: Border.all(
                  color: checked ? Colors.white : Colors.black87,
                  width: checked ? 0 : 1.0),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: checked ? Colors.white : Colors.black87,
              ),
            ),
          ),
          onTap: onPressed,
        ),
      ),
    );
  }

  //创建颜色按钮
  Widget buildColorButton(Color color, bool checked, VoidCallback onPressed) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 30.0,
        margin: const EdgeInsets.all(3.0),
        child: MaterialButton(
          color: color,
          child: checked
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : Container(),
          onPressed: onPressed,
        ),
      ),
    );
  }

  //创建主菜单
  Widget buildMainMenu() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildMainButton('绘图', isPainting, () {
            setState(() {
              isPainting = true;
            });
          }),
          buildMainButton('观看', !isPainting, () {
            setState(() {
              isPainting = false;
            });
          }),
          buildMainButton('清空', true, () {
            setState(() {
              if (isPainting) {
//                inputContents.clear();
                _pPosBox.clear();
                widget.channel.sink.add(pposData2Json());
              }
            });
          }),
        ],
      ),
    );
  }

  //创建颜色菜单
  Widget buildColorMenu() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildColorButton(Colors.black, paintColor == Colors.black, () {
            paintColor = Colors.black;
            setState(() {});
          }),
          buildColorButton(Colors.blue, paintColor == Colors.blue, () {
            paintColor = Colors.blue;
            setState(() {});
          }),
          buildColorButton(
              Colors.deepOrangeAccent, paintColor == Colors.deepOrangeAccent,
              () {
            paintColor = Colors.deepOrangeAccent;
            setState(() {});
          }),
          buildColorButton(Colors.green, paintColor == Colors.green, () {
            paintColor = Colors.green;
            setState(() {});
          }),
          buildColorButton(
              Colors.purpleAccent, paintColor == Colors.purpleAccent, () {
            paintColor = Colors.purpleAccent;
            setState(() {});
          }),
          buildColorButton(Colors.yellow, paintColor == Colors.yellow, () {
            paintColor = Colors.yellow;
            setState(() {});
          }),
        ],
      ),
    );
  }

  //创建宽度菜单
  Widget buildWidthMenu() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildWidthButton(paintColor, 1.0, paintWidth == 2.0, () {
            paintWidth = 2.0;
            setState(() {});
          }),
          buildWidthButton(paintColor, 2.5, paintWidth == 5.0, () {
            paintWidth = 5.0;
            setState(() {});
          }),
          buildWidthButton(paintColor, 5.0, paintWidth == 10.0, () {
            paintWidth = 10.0;
            setState(() {});
          }),
          buildWidthButton(paintColor, 7.5, paintWidth == 15.0, () {
            paintWidth = 15.0;
            setState(() {});
          }),
          buildWidthButton(paintColor, 10.0, paintWidth == 20.0, () {
            paintWidth = 20.0;
            setState(() {});
          }),
          buildWidthButton(paintColor, 15.0, paintWidth == 30.0, () {
            paintWidth = 30.0;
            setState(() {});
          }),
        ],
      ),
    );
  }

  //创建输入框
  Widget buildTextField() {
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.blueAccent,
        hintColor: Colors.blueAccent,
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10.0, right: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
      ),
    );
  }

  //创建输入区域
  Widget buildInputContainer() {
    return Container(
      height: 50.0,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: buildTextField(),
            ),
          ),
          Material(
            color: Colors.white,
            child: Ink(
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                  ),
                ),
                onTap: () {
                  widget.channel.sink
                      .add("${USER_MSG_FLAG}${textController.text}");
                  textController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //将绘制数据转化为Json数据
  String pposData2Json() {
    DataJson dataJson = DataJson('{"data":[]}');
    _pPosBox.box.forEach((line) {
      List<PPosJson> pposJson = [];
      line.forEach((ppos) {
        pposJson.add(
          PPosJson.fromParams(
            color: ppos.color.value,
            width: ppos.width,
            pos: PosJson.fromParams(x: ppos.pos.dx, y: ppos.pos.dy),
          ),
        );
      });
      dataJson.data.add(pposJson);
    });
    var jsonStr = dataJson.toString();
    return jsonStr;
  }

  //解析接收数据并执行对应操作
  void analysisReceiveData(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      if (snapshot.data is String) {
        String data = snapshot.data;
        TotalData totalData = TotalData(data);
        if (totalData.type == MsgType.TYPE_CONN.index) {
          //连接类型的消息
          if (lastInfo != totalData.conn_msg.msg) {
            if (inputArr.length >= 8) {
              inputArr.removeAt(0);
              inputArr.add(totalData.conn_msg.msg);
            } else {
              inputArr.add(totalData.conn_msg.msg);
            }
            inputContents.clear();
            inputArr.forEach((element) {
              inputContents.writeln(element);
            });
            lastInfo = totalData.conn_msg.msg;
          }
        } else if (totalData.type == MsgType.TYPE_USER.index) {
          //用户类型的消息
          if (lastInfo != totalData.user_msg.msg) {
            if (inputArr.length >= 8) {
              inputArr.removeAt(0);
              inputArr.add(
                  '${totalData.user_msg.users.name}:${totalData.user_msg.msg}');
            } else {
              inputArr.add(
                  '${totalData.user_msg.users.name}:${totalData.user_msg.msg}');
            }
            inputContents.clear();
            inputArr.forEach((element) {
              inputContents.writeln(element);
            });
            lastInfo = totalData.user_msg.msg;
          }
        } else if (totalData.type == MsgType.TYPE_DATA.index && !isPainting) {
          //数据类型的消息
          DataJson dataJson = DataJson(totalData.data_msg);
          _pPosBox.clear();
          dataJson.data.forEach((list) {
            List<PPos> line = [];
            list.forEach((ppos) {
              line.add(PPos(Offset(ppos.pos.x, ppos.pos.y), Color(ppos.color),
                  ppos.width));
            });
            _pPosBox.box.add(line);
          });
        }
      } else if (snapshot.data is PPosBox) {
        _pPosBox = snapshot.data;
      }
    }
  }

  //构建用户头像列表
  Widget buildUserIconColumn() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person_pin),
                  Text(
                    '用户',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person_pin),
                  Text(
                    '用户',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person_pin),
                  Text(
                    '用户',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //构建绘画区域
  Widget buildPaintContainer() {
    return GestureDetector(
      onPanStart: (detail) {
        setState(() {
          _pos = detail.globalPosition;
          PPos pPos = new PPos(_pos, paintColor, paintWidth);
          _pPosBox.appendStartPos(pPos);
        });
      },
      onPanUpdate: (detail) {
        setState(() {
          _pos = detail.globalPosition;
          PPos pPos = new PPos(_pos, paintColor, paintWidth);
          _pPosBox.appendPos(pPos);
        });
      },
      onPanEnd: (detail) {
        if (isPainting) {
          widget.channel.sink.add(pposData2Json());
        }
      },
      onPanCancel: () {
        if (isPainting) {
          widget.channel.sink.add(pposData2Json());
        }
      },
      child: new StreamBuilder(
        stream: widget.channel.stream,
        builder: (context, snapshot) {
          analysisReceiveData(snapshot);
          return Column(
            children: <Widget>[
              Expanded(
                child: buildCustomPaintContainer(),
              ),
              buildUsersContainer(),
            ],
          );
        },
      ),
    );
  }

  Container buildCustomPaintContainer() {
    return Container(
      height: 200,
      child: CustomPaint(
        painter: Draw(_pPosBox),
        child: Container(),
      ),
    );
  }

  //构建用户显示区域
  Container buildUsersContainer() {
    return Container(
      width: double.infinity,
      height: 150.0,
      child: Row(
        children: <Widget>[
          buildUserIconColumn(),
          Expanded(
            child: Container(
              width: 200.0,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 1.0),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Text(
                //这里是截取掉最后一个换行符
                inputContents.toString().length > 0
                    ? inputContents
                        .toString()
                        .substring(0, inputContents.toString().length - 1)
                    : "",
                maxLines: 8,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          buildUserIconColumn(),
        ],
      ),
    );
  }
}
