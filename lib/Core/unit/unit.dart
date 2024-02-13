
import 'package:flutter/cupertino.dart';

class Unit{
  BuildContext context;
  Unit(this.context);
  double get getWidthSize => MediaQuery.of(context).size.width;
  double get getHeightSize => MediaQuery.of(context).size.height;
}