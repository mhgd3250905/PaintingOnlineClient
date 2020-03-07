import 'package:flutter/material.dart';
import 'package:painting/WebStudy/model/model_room.dart';

class DialogRoomInfo extends StatefulWidget {
  final int roomId;

  DialogRoomInfo({this.roomId});

  @override
  _DialogRoomInfoState createState() => _DialogRoomInfoState();
}

class _DialogRoomInfoState extends State<DialogRoomInfo> {
  List<DropdownMenuItem<int>> sortItems = []; //人数下拉条目
  int _userCount = 6; //选择房间人数
  bool _passwordChecked = false; //是否勾选设置密码
  TextEditingController _roomNameController; //房间名称输入管理
  TextEditingController _roomDescController; //房间描述输入管理
  TextEditingController _roomPasswordController; //房间密码输入管理

  bool isRoomNameEmpty = false; //flag 是否提示房间名为空
  bool isRoomPasswordEmpty = false; //flag 是否提示密码为空

  @override
  void initState() {
    super.initState();
    _roomNameController = new TextEditingController();
    _roomDescController = new TextEditingController();
    _roomPasswordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    buildDropItemList(_userCount);
    return Container(
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: double.infinity,
//          height: 400.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blue,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildItemTop(context),
              buildItemTextField(
                  _roomNameController, '房间名', isRoomNameEmpty, '房间名不可为空',
                  (text) {
                setState(() {
                  isRoomNameEmpty = false;
                });
              }),
              buildItemTextField(_roomDescController, '房间说明', false, '', null),
              buildMaxUserItem(_userCount, sortItems, (value) {
                setState(() {
                  _userCount = value;
                });
              }),
              buildPasswordEnable(_passwordChecked, (checked) {
                setState(() {
                  _passwordChecked = checked;
                });
              }),
              Visibility(
                visible: _passwordChecked,
                child: buildItemTextField(_roomPasswordController, '房间说明',
                    isRoomPasswordEmpty, '密码不可为空', (text) {
                  setState(() {
                    isRoomPasswordEmpty = false;
                  });
                }),
              ),
              buildItemCreateButton(onCreateButtonPress),
            ],
          ),
        ),
      ),
    );
  }

  //准备下拉列表数据
  void buildDropItemList(int userCount) {
    sortItems.clear();
    for (int i = 0; i < 6; i++) {
      sortItems.add(DropdownMenuItem(
        value: i + 1,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${i + 1}',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ));
    }
  }

  //创建按钮点击事件
  void onCreateButtonPress() {
    //如果房间名称输入为空，那么弹出提示房间名称为空
    if (_roomNameController.text.isEmpty) {
      setState(() {
        isRoomNameEmpty = true;
        return;
      });
    }
    //如果房间密码勾选，且密码输入为空，那么弹出提示房间密码为空
    if (_passwordChecked && _roomPasswordController.text.isEmpty) {
      isRoomPasswordEmpty = true;
      return;
    }
    //创建当前房间信息
    RoomInfo roomInfo = new RoomInfo.fromParams(
      max_user: _userCount,
      roomId: '${widget.roomId}',
      name: _roomNameController.text,
      desc: _roomDescController.text,
      password_enable: _passwordChecked,
      password: _roomPasswordController.text,
    );
  }
}

//创建'创建'按钮条目
Widget buildItemCreateButton(VoidCallback onPress) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        '创建',
        style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            decoration: TextDecoration.none),
      ),
    ),
  );
}

//创建顶部包含返回键的条目
Widget buildItemTop(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.home,
              color: Colors.yellowAccent,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.clear,
            color: Colors.yellowAccent,
          ),
        ),
      ],
    ),
  );
}

//创建最大人数选择条目
Widget buildMaxUserItem(int userCount, List<DropdownMenuItem<int>> items,
    ValueChanged<int> onChanged) {
  return Container(
    margin: const EdgeInsets.only(left: 20.0, top: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            '玩家人数：',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent,
                decoration: TextDecoration.none),
          ),
        ),
        Material(
          color: Colors.blue,
          child: Container(
            height: 35.0,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.yellowAccent,
                    decoration: TextDecoration.none),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blue,
                ),
                value: userCount,
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

//创建密码可用条目
Widget buildPasswordEnable(bool checked, ValueChanged<bool> onChanged) {
  return Container(
    margin: const EdgeInsets.only(top: 20.0, left: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            '是否设置密码',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent,
                decoration: TextDecoration.none),
          ),
        ),
        Material(
          color: Colors.blue,
          child: Checkbox(
            activeColor: Colors.yellowAccent,
            hoverColor: Colors.yellowAccent,
            checkColor: Colors.yellowAccent,
            value: checked,
            onChanged: onChanged,
          ),
        ),
      ],
    ),
  );
}

//创建文本输入条目
Widget buildItemTextField(TextEditingController controller, String labelTitle,
    bool isError, String errText, ValueChanged<String> onChanged) {
  return Container(
//      padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
    child: Material(
      color: Colors.blue,
      child: TextField(
        controller: controller,
        cursorColor: Colors.yellowAccent,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.yellowAccent,
        ),
        decoration: InputDecoration(
            errorText: isError ? errText : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(width: 1.0, color: Colors.yellowAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(width: 1.0, color: Colors.yellowAccent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(width: 1.0, color: Colors.yellowAccent),
            ),
            labelText: labelTitle,
            labelStyle: TextStyle(
              fontSize: 22.0,
              color: Colors.yellowAccent,
              fontWeight: FontWeight.bold,
            )),
        onChanged: onChanged,
      ),
    ),
  );
}

//创建文字标题
Widget buildItemTitle(String title) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.yellowAccent,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
      ),
    ),
  );
}
