/*

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_car/Core/unit/size_data.dart';
import 'package:part_car/Core/unit/styles.dart';
import 'package:part_car/Core/unit/unit.dart';
import '../unit/color_data.dart';

class DropDownCustom extends StatelessWidget {
  final String hintText;
  final Function(Object?) onChanged;
  final List<DropdownMenuItem<Object>> items;
  final Object? value;
  final bool? isDense;
  final String prefixIcon;
  final String? Function(Object?)? validator;
  const DropDownCustom({Key? key, required this.hintText, required this.onChanged, required this.items, this.value, this.isDense, this.validator, required this.prefixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items:items,
      onChanged: onChanged,
      value: value,
      isExpanded: true,
      isDense: isDense??true,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Styles.textStyle16.copyWith(
          color: ColorData.grey34Color,
          fontSize: Unit(context).getWidthSize*0.04,
          height: 3.0,
        ),
        contentPadding:EdgeInsets.all(SizeData.s10),
        prefixIcon:Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: SizeData.s10,),
            Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.all(SizeData.s8),
                margin: EdgeInsets.symmetric(vertical: SizeData.s8,),
                decoration: BoxDecoration(
                    color: ColorData.blueColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(SizeData.s10)
                ),
                child: SvgPicture.asset(prefixIcon,)),
            SizedBox(width: SizeData.s10,),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:BorderSide(color:ColorData.white2Color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:BorderSide(color:ColorData.white2Color),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:BorderSide(color:ColorData.white2Color),
        ),
      ),
      validator: validator,
    );
  }
}
*/
