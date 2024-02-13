
import 'package:flutter/material.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';

class ErrorMsgCustom extends StatelessWidget {
  final String msg;
  const ErrorMsgCustom({Key? key,required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.clear,color: ColorData.red2Color,size: Unit(context).getWidthSize*0.053,),
          const SizedBox(width: 10,),
          Expanded(
            child: Text(msg,style: Styles.textStyle12.copyWith(
                fontSize: Unit(context).getWidthSize*0.032,
              color: ColorData.red2Color
            ),),
          ),
        ],
      ),
    );
  }
}