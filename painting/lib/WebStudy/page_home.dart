import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'model_paint.dart';

class HomePage extends StatefulWidget {
  final channel = new IOWebSocketChannel.connect('ws://49.234.76.105:80/ping');

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputStr;
  PPosBox _pPosBox;
  Offset _pos = Offset(0, 0);
  Color paintColor = Colors.black;
  double paintWidth = 2.0;
  String lastData = '';
  bool isPainting = true;
  StringBuffer connectInfo = new StringBuffer();
  String lastInfo = '';

  @override
  void initState() {
    super.initState();
    _pPosBox = new PPosBox();
  }

  Widget buildButton(String title, Color color, VoidCallback onPressed) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: MaterialButton(
          color: color,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget buildMainMenu() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton('绘图', isPainting ? Colors.black87 : Colors.black54, () {
            setState(() {
              isPainting = true;
            });
          }),
          buildButton('观看', !isPainting ? Colors.black87 : Colors.black54, () {
            setState(() {
              isPainting = false;
            });
          }),
          buildButton('清空', Colors.black87, () {
            setState(() {
              connectInfo.clear();
              _pPosBox.clear();
            });
          }),
        ],
      ),
    );
  }

  Widget buildColorMenu() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton('', Colors.black, () {
            paintColor = Colors.black;
          }),
          buildButton('', Colors.blue, () {
            paintColor = Colors.blue;
          }),
          buildButton('', Colors.deepOrangeAccent, () {
            paintColor = Colors.deepOrangeAccent;
          }),
          buildButton('', Colors.green, () {
            paintColor = Colors.green;
          }),
          buildButton('', Colors.purpleAccent, () {
            paintColor = Colors.purpleAccent;
          }),
          buildButton('', Colors.yellow, () {
            paintColor = Colors.yellow;
          }),
        ],
      ),
    );
  }

  Widget buildWidthMenu() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildButton('2px', Colors.black54, () {
            paintWidth = 2.0;
          }),
          buildButton('5px', Colors.black54, () {
            paintWidth = 5.0;
          }),
          buildButton('10px', Colors.black54, () {
            paintWidth = 10.0;
          }),
          buildButton('15px', Colors.black54, () {
            paintWidth = 15.0;
          }),
          buildButton('20px', Colors.black54, () {
            paintWidth = 20.0;
            setState(() {
              _pPosBox.clear();
              if (isPainting) {
                widget.channel.sink.add(pposData2Json());
              }
            });
          }),
          buildButton('30px', Colors.black54, () {
            paintWidth = 30.0;
//            String jsonStr = pposData2Json();
//            widget.channel.sink.add(jsonStr);
            widget.channel.sink.add(
                '{"data": [[{"color": 4278190080,"width": 2.0,"pos": {"x": 187.734375,"y": 320.810546875}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 187.998046875,"y": 320.625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 188.349609375,"y": 320.810546875}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 188.525390625,"y": 320.99609375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 188.525390625,"y": 321.181640625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 188.4375,"y": 321.73828125}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 188.349609375,"y": 321.923828125}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 188.0859375,"y": 322.294921875}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 187.734375,"y": 322.8515625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 185.888671875,"y": 325.078125}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 184.5703125,"y": 326.93359375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 182.63671875,"y": 328.7890625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 181.0546875,"y": 330.087890625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 179.736328125,"y": 331.943359375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 178.330078125,"y": 333.427734375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 176.8359375,"y": 335.09765625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 175.869140625,"y": 336.58203125}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 174.55078125,"y": 338.06640625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 173.408203125,"y": 339.55078125}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 172.353515625,"y": 341.03515625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 171.5625,"y": 342.333984375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 171.2109375,"y": 343.818359375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 170.5078125,"y": 345.302734375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 170.15625,"y": 346.6015625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 169.892578125,"y": 347.529296875}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 169.62890625,"y": 348.45703125}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 169.365234375,"y": 349.19921875}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 169.013671875,"y": 350.126953125}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 168.92578125,"y": 350.68359375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 168.75,"y": 351.42578125}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 168.3984375,"y": 351.982421875}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 168.134765625,"y": 352.5390625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 168.046875,"y": 352.91015625}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 167.607421875,"y": 353.466796875}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 167.51953125,"y": 353.65234375}}, {"color": 4278190080,"width": 2.0,"pos": {"x": 167.255859375,"y": 353.65234375}}]]}');
          }),
        ],
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '你画我猜测试版(${_pos.dx},${_pos.dy})',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.black87,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              buildMainMenu(),
              buildColorMenu(),
              buildWidthMenu(),
              Expanded(
                child: GestureDetector(
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
                  child: Container(
                    child: new StreamBuilder(
                      stream: widget.channel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data is String) {
                            String data = snapshot.data;
                            if (data.startsWith("Notice:")) {
                              //提醒类型的消息
                              if (lastInfo != data.substring(7, data.length)) {
                                connectInfo
                                    .writeln(data.substring(7, data.length));
                                lastInfo = data.substring(7, data.length);
                              }
                            } else if (!isPainting) {
                              //数据类型的消息
                              DataJson dataJson = DataJson(data);
                              _pPosBox.clear();
                              dataJson.data.forEach((list) {
                                List<PPos> line = [];
                                list.forEach((ppos) {
                                  line.add(PPos(Offset(ppos.pos.x, ppos.pos.y),
                                      Color(ppos.color), ppos.width));
                                });
                                _pPosBox.box.add(line);
                              });
                            }
                          } else if (snapshot.data is PPosBox) {
                            _pPosBox = snapshot.data;
                          }
                        }
                        return Stack(
                          children: <Widget>[
                            CustomPaint(
                              painter: Draw(_pPosBox),
                              child: Container(),
                            ),
                            Positioned(
                              top: 10.0,
                              left: 10.0,
                              child: Text(connectInfo.toString()),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Draw extends CustomPainter {
  final PPosBox pPosBox;

  Draw(this.pPosBox);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();
    paint.color = Colors.blue;
    paint.strokeCap = StrokeCap.round;
    PPos lastPPos;
    pPosBox.box.forEach((line) {
      lastPPos = null;
      line.forEach((pPos) {
        paint.color = pPos.color;
        paint.strokeWidth = pPos.width;
        if (lastPPos != null) {
          canvas.restore();
          canvas.drawLine(lastPPos.pos, pPos.pos, paint);
          canvas.save();
        }
        lastPPos = pPos;
      });
    });
  }

  @override
  bool shouldRepaint(Draw oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
