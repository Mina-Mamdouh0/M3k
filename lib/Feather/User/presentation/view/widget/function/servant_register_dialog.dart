
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/assets_data.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';

Widget buildServantRegisterDialog({required BuildContext context}){
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeData.s8),
    ),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(SizeData.s5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorData.primaryColor,
                    width: 1.5
                  )
                ),
                child: Icon(Icons.clear,color: ColorData.primaryColor,
                size: Unit(context).getWidthSize*0.030),
              ),
            )

          ],
        ),
        SizedBox(height: SizeData.s10,),
        AspectRatio(
          aspectRatio: 1.1/0.1,
          child: Image.asset(AssetsData.logoImage),
        ),
        SizedBox(height: SizeData.s10,),
        Text(LocaleKeys.kTheRegistrationRequestHasBeenSentToTheAdministration.tr(),
        style: Styles.textStyle24.copyWith(
          color: ColorData.blackColor,
          fontSize: Unit(context).getWidthSize*0.069
        ),),
        Text(LocaleKeys.kWeWillContactYouAsSoonAsPossible.tr(),
          style: Styles.textStyle22.copyWith(
              color: ColorData.blackColor,
              fontSize: Unit(context).getWidthSize*0.069
          ),textAlign: TextAlign.center),

      ],
    ),
  );
}