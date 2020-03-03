import 'package:flutter/material.dart';

class RouterAnim {
  static createTransition(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}
