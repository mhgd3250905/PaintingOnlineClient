import 'package:flutter/material.dart';

import 'model_paint.dart';

//自定义画布
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
