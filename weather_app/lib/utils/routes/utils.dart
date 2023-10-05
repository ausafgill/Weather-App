import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {
  void showErrorFlushBar(
      String msg, BuildContext context, Icon addIcon, Color color) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: msg,
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          duration: Duration(seconds: 5),
          icon: addIcon,
          backgroundColor: color,
        )..show(context));
  }
}
