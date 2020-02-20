import 'dart:convert';

import 'package:flutter/material.dart';

//绘画坐标数据类
class PPos {
  Offset pos; //坐标
  Color color; //画笔颜色
  double width; //画笔宽度

  PPos(this.pos, this.color, this.width);
}

//绘画坐标集合
//这个数据的结构为List<List<PPos>>
//内部的List代表一根起点到终点的线
class PPosBox {
  List<List<PPos>> box = [];

  List<List<PPos>> get() {
    return box;
  }

  //添加起点
  void appendStartPos(PPos pos) {
    List<PPos> line = [];
    line.add(pos);
    box.add(line);
  }

  //添加移动点
  void appendPos(PPos pos) {
    if (box.length == 0) {
      return;
    }
    if (box.last.length == 0) {
      return;
    }
    box.last.add(pos);
  }

  //添加结束点
  void appendEndPos(PPos pos) {
    if (box.length == 0) {
      return;
    }
    if (box.last.length == 0) {
      return;
    }
    box.last.add(pos);
  }

  void clear() {
    box = [];
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
