
import 'package:flutter/material.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';

import '../unit/color_data.dart';


class MainButtonCustom extends StatelessWidget {
  final String text;
  Function()? fct;
  MainButtonCustom({Key? key, required this.text, this.fct ,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fct,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: SizeData.s12,),
          decoration: BoxDecoration(
            color: ColorData.primaryColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  color: ColorData.primaryColor.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 4)
              )
            ]
          ),
          child: Center(
            child: Text(text,
              style: Styles.textStyle24.copyWith(
                fontSize: Unit(context).getWidthSize*0.064,
                height: 0.0
              ),),
          )
      ),
    );
  }
}

class MainButtonSecondCustom extends StatelessWidget {
  final String text;
  Function()? fct;
  MainButtonSecondCustom({Key? key, required this.text, this.fct ,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: fct,
        padding: EdgeInsets.symmetric(vertical: SizeData.s10,),
        color: ColorData.primaryColor,
        minWidth: double.infinity,
        height: 50,
        elevation: 0.0,
        disabledColor:ColorData.primaryColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(text,
          style: Styles.textStyle24.copyWith(
            fontSize: Unit(context).getWidthSize*0.064,
            height: 0.0,
          ), textAlign: TextAlign.center,)
    );
  }
}
