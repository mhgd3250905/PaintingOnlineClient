import 'package:flutter/material.dart';

//创建主菜单按钮
Widget buildMainButton(String title, bool checked, Color enableColor,
    Color disableColor, VoidCallback onPressed) {
  return Expanded(
    flex: 2,
    child: Container(
      height: 50.0,
      margin:
          const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0, bottom: 5.0),
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: !checked ? disableColor : enableColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                color: checked ? disableColor : enableColor,
                width: checked ? 0 : 1.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(1.0, 1.0), //阴影xy轴偏移量
                  blurRadius: 1.0, //阴影模糊程度
                  spreadRadius: 1.0 //阴影扩散程度
                  ),
            ],
          ),
          child: Text(
            title,
            style: TextStyle(
              color: checked ? disableColor : enableColor,
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
                        color: color,
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
                Icon(
                  Icons.face,
                  color: Colors.black87,
                ),
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
                Icon(
                  Icons.face,
                  color: Colors.black87,
                ),
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
                Icon(
                  Icons.face,
                  color: Colors.black87,
                ),
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
