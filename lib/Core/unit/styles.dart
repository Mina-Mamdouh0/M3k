
import 'package:flutter/material.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/font_weiget_data.dart';

abstract class Styles {
  static const fontFamily='Somar';


  static TextStyle textStyle12 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.medium,
    fontSize: 12,
    fontFamily: fontFamily,
    height: 1.6,
  );

  static TextStyle textStyle22 = TextStyle(
    color: ColorData.greyBoldColor,
    fontWeight: FontWeightStyles.regular,
    fontSize: 22,
    fontFamily: fontFamily,
    height: 1.6,
  );

  static TextStyle textStyle24 = TextStyle(
    color: ColorData.whiteColor,
    fontWeight: FontWeightStyles.bold,
    fontSize: 24,
    fontFamily: fontFamily,
    height: 1.6,
  );




}