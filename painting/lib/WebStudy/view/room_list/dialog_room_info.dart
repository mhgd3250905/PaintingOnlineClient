import 'package:flutter/material.dart';

class DialogRoomInfo extends StatefulWidget {
  @override
  _DialogRoomInfoState createState() => _DialogRoomInfoState();
}

class _DialogRoomInfoState extends State<DialogRoomInfo> {
  List<DropdownMenuItem<int>> sortItems = [];
  int _userCount = 6;
  bool _passwordChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildDropItemList(_userCount);
    return Container(
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: double.infinity,
          height: 500.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blue,
          ),
          child: Column(
            children: <Widget>[
//              buildItemTitle('房间名'),
              buildItemTextField(new TextEditingController(), '房间名'),
              buildItemTextField(new TextEditingController(), '房间说明'),
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
                child: buildItemTextField(new TextEditingController(), '房间说明'),
              ),
              Container(
                alignment: Alignment.center,
                child: Text('AAA'),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}

Widget buildPasswordEnable(bool checked, ValueChanged<bool> onChanged) {
  return Container(
    margin: const EdgeInsets.only(top: 20.0,left: 20.0),
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

Widget buildItemTextField(TextEditingController controller, String labelTitle) {
  return Container(
//      padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
    child: Material(
      color: Colors.blue,
      child: TextField(
        controller: controller,
        cursorColor: Colors.yellowAccent,
        decoration: InputDecoration(
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
      ),
    ),
  );
}

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
