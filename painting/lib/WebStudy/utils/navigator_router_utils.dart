import 'package:flutter/material.dart';

import 'file:///D:/Android/Proj/PaintingOnlineClient/painting/lib/WebStudy/utils/router_anim_utils.dart';

///跳转管理
class NavigatorRouterUtils {
  //跳转到指定page
  static void pushToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
        (BuildContext c, Animation<double> animation,
            Animation<double> secondartAnimation) {
      return page;
    }, transitionsBuilder: (BuildContext c, Animation<double> animation,
        Animation<double> secondartAnimation, Widget child) {
      return RouterAnim.createTransition(animation, child);
    }));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
        context,
        new PageRouteBuilder(pageBuilder: (BuildContext c,
            Animation<double> animation, Animation<double> secondartAnimation) {
          return page;
        }, transitionsBuilder: (BuildContext c, Animation<double> animation,
            Animation<double> secondartAnimation, Widget child) {
          return RouterAnim.createTransition(animation, child);
        }),
        (route) => route == null);
  }
}
