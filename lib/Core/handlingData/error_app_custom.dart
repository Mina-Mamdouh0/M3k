
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/unit.dart';

showErrorToast({String ? msg,required BuildContext context}) {
  return Fluttertoast.showToast(
    msg: msg ?? '',
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: ColorData.redColor,
    gravity: ToastGravity.TOP,
    fontSize: Unit(context).getWidthSize * 0.045,
    textColor: ColorData.whiteColor,
  );
}