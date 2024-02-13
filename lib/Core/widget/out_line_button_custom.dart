
import 'package:flutter/material.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';

class OutLineButtonCustom extends StatelessWidget {
  final String text;
  Function()? fct;
  OutLineButtonCustom({Key? key, required this.text, this.fct ,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fct,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: SizeData.s10,),
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: ColorData.primaryColor,
              width: 1.5
            )
          ),
          child: Center(
            child: Text(text,
              style: Styles.textStyle24.copyWith(
                  fontSize: Unit(context).getWidthSize*0.064,
                  color: ColorData.primaryColor,
                  height: 0.0
              ),),
          )
      ),
    );
  }
}