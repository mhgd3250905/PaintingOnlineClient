import 'package:flutter/material.dart';

class DialogRoomInfo extends StatefulWidget {
  @override
  _DialogRoomInfoState createState() => _DialogRoomInfoState();
}

class _DialogRoomInfoState extends State<DialogRoomInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          width: double.infinity,
          height: 400.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blue,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  '创建房间',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  '房间名：',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.yellowAccent,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
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
