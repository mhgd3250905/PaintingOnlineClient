import 'dart:convert' show json;

enum MsgType {
  TYPE_DATA, //0
  TYPE_CONN, //1
  TYPE_USER, //2
}

class TotalData {
  int type;
  String data_msg;
  ConnMsg conn_msg;
  UserMsg user_msg;

  TotalData.fromParams(
      {this.type, this.data_msg, this.conn_msg, this.user_msg});

  factory TotalData(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TotalData.fromJson(json.decode(jsonStr))
          : new TotalData.fromJson(jsonStr);

  TotalData.fromJson(jsonRes) {
    type = jsonRes['type'];
    data_msg = jsonRes['data_msg'];
    conn_msg = jsonRes['conn_msg'] == null
        ? null
        : new ConnMsg.fromJson(jsonRes['conn_msg']);
    user_msg = jsonRes['user_msg'] == null
        ? null
        : new UserMsg.fromJson(jsonRes['user_msg']);
  }

  @override
  String toString() {
    return '{"type": $type,"data_msg": ${data_msg != null ? '${json.encode(data_msg)}' : 'null'},"conn_msg": $conn_msg,"user_msg": $user_msg}';
  }
}

class UserMsg {
  String msg;
  User users;

  UserMsg.fromParams({this.msg, this.users});

  UserMsg.fromJson(jsonRes) {
    msg = jsonRes['msg'];
    users =
        jsonRes['users'] == null ? null : new User.fromJson(jsonRes['users']);
  }

  @override
  String toString() {
    return '{"msg": ${msg != null ? '${json.encode(msg)}' : 'null'},"users": $users}';
  }
}

class User {
  String ip;
  String name;

  User.fromParams({this.ip, this.name});

  User.fromJson(jsonRes) {
    ip = jsonRes['ip'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"ip": ${ip != null ? '${json.encode(ip)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}

class ConnMsg {
  String msg;
  List<User> users;

  ConnMsg.fromParams({this.msg, this.users});

  ConnMsg.fromJson(jsonRes) {
    msg = jsonRes['msg'];
    users = jsonRes['users'] == null ? null : [];

    for (var usersItem in users == null ? [] : jsonRes['users']) {
      users.add(usersItem == null ? null : new User.fromJson(usersItem));
    }
  }

  @override
  String toString() {
    return '{"msg": ${msg != null ? '${json.encode(msg)}' : 'null'},"users": $users}';
  }
}

class DataJson {
  List<List<PPosJson>> data = [];

  DataJson.fromParams({this.data});

  factory DataJson(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new DataJson.fromJson(json.decode(jsonStr))
          : new DataJson.fromJson(jsonStr);

  DataJson.fromJson(jsonRes) {
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']) {
      List<PPosJson> dataChild = dataItem == null ? null : [];
      for (var dataItemItem in dataChild == null ? [] : dataItem) {
        dataChild.add(
            dataItemItem == null ? null : new PPosJson.fromJson(dataItemItem));
      }
      data.add(dataChild);
    }
  }

  @override
  String toString() {
    return '{"data": $data}';
  }
}

class PPosJson {
  int color;
  double width;
  PosJson pos;

  PPosJson.fromParams({this.color, this.width, this.pos});

  PPosJson.fromJson(jsonRes) {
    color = jsonRes['color'];
    width = jsonRes['width'];
    pos = jsonRes['pos'] == null ? null : new PosJson.fromJson(jsonRes['pos']);
  }

  @override
  String toString() {
    return '{"color": $color,"width": $width,"pos": $pos}';
  }
}

class PosJson {
  double x;
  double y;

  PosJson.fromParams({this.x, this.y});

  PosJson.fromJson(jsonRes) {
    x = jsonRes['x'];
    y = jsonRes['y'];
  }

  @override
  String toString() {
    return '{"x": $x,"y": $y}';
  }
}
