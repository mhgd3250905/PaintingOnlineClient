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
