import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:painting/WebStudy/utils/device_utils.dart';

import 'dialog_room_info.dart';
import 'widgets_page_room_list.dart';

class RoomListPage extends StatelessWidget {
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
  List<String> roomArr = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: Container(
        padding: EdgeInsets.only(top: DeviceUtils.getStatusBarHeight(window)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 0.0),
              child: Text(
                '房间',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '列表',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellowAccent,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    margin: const EdgeInsets.only(
                        top: 10.0, left: 5.0, right: 20.0, bottom: 0.0),
                    child: buildCreateRoomButton(
                        '创建',
                        TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        Colors.yellowAccent,
                        onPress),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: roomArr.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getGridItemContainer(roomArr[index]);
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      //单个子Widget的水平最大宽度
                      maxCrossAxisExtent: 200,
                      //主轴Widget之间间距
                      mainAxisSpacing: 20.0,
                      //次轴Widget之间间距
                      crossAxisSpacing: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //点击创建按钮事件
  //添加一个新的房间
  void onPress() {
    showDialog(context: context, child: DialogRoomInfo());
  }
}
