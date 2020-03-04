import 'package:flutter/material.dart';

///这个文件用来创建在RoomList界面中的Widget

///创建 创建房间按钮
Widget buildCreateRoomButton(
    String title, TextStyle textStyle, Color bgColor, VoidCallback onPress) {
  return InkWell(
    child: Container(
      width: 80.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.yellowAccent, width: 0),
      ),
      child: Text(
        title,
        style: textStyle,
      ),
    ),
    onTap: onPress,
  );
}

///创建房间列表的item样式
Widget getGridItemContainer(String roomId) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.yellowAccent,
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(color: Colors.yellowAccent, width: 0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            '你画我猜',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.blue,
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              '一起开心的来玩你画我猜吧~',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            '在线人数：6',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ),
  );
}
