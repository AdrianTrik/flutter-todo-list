import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class UtilService {
  static getFlushBar(BuildContext context, String text) {
    return Flushbar(
      message: text,
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: kBlueCarrefour,
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
    ).show(context);
  }
}
