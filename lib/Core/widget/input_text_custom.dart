
import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';


class InputTextCustom extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String labelText;
  Widget ? suffixIcon;
  Function()? onTapSuffix;
  Function()? onEditingComplete;
  bool? obscureText;
  FocusNode? focusNode;
  int? mixLine;
  FormFieldValidator<String>? validator;
  Function(String)? onChanged;
  TextInputAction? textInputAction;
  bool? enabled;
  InputTextCustom({Key? key, required this.controller, required this.inputType,this.enabled,this.focusNode,required this.labelText,
  this.mixLine,this.obscureText,this.onChanged,this.onEditingComplete,this.onTapSuffix,
  this.suffixIcon,this.textInputAction,this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: onEditingComplete,
      onTap: (){
        if(controller.selection == TextSelection.fromPosition(TextPosition(offset: controller.text.length -1))){
          controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
        }
      },
      focusNode: focusNode,
      textInputAction: textInputAction??TextInputAction.next,
      keyboardType:inputType ,
      controller: controller,
      enabled: enabled,
      textAlign: TextAlign.start,
      maxLines: mixLine??1,
      obscureText: obscureText??false,
      style: Styles.textStyle22.copyWith(
        color: ColorData.blackColor,
        fontSize: Unit(context).getWidthSize*0.058,
      ),
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: Styles.textStyle22.copyWith(
          color: ColorData.greyRegularColor,
          fontSize: Unit(context).getWidthSize*0.058,
        ),

        suffixIcon: suffixIcon!=null?
        IconButton(
            onPressed: onTapSuffix,
            icon: suffixIcon!):null,

        contentPadding:EdgeInsets.all(SizeData.s10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:BorderSide(color:ColorData.greyRegularColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:BorderSide(color:ColorData.greyRegularColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:const BorderSide(color:Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color:ColorData.greyRegularColor),
        ),
      ),
      validator: validator??(String? val){
        if(val!.isEmpty){
          return LocaleKeys.kFieldRequired.tr();
        }
      },
      onChanged: onChanged,
    );
  }
}
