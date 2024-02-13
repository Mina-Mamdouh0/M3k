
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';

class ChooseImageCustom extends StatelessWidget {
  const ChooseImageCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit=UserCubit.get(context);
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(LocaleKeys.kAddPhoto.tr(),
            style: Styles.textStyle22.copyWith(
                fontSize: Unit(context).getWidthSize*0.058,
                color: ColorData.greyRegularColor
            ),),
          SizedBox(height: SizeData.s15,),

          InkWell(
            onTap: ()async{
              XFile? file= await ImagePicker().pickImage(source: ImageSource.gallery,maxWidth: 1080,maxHeight: 1080);
              if(file!=null){
                cubit.detectFileToFile(File(file.path));
              }
            },
            child: Container(
                width: Unit(context).getWidthSize*0.26,
                height: Unit(context).getWidthSize*0.26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeData.s8),
                    color: ColorData.grey2Color
                ),
                child: cubit.fileImage!=null?
                ClipRRect(
                    borderRadius: BorderRadius.circular(SizeData.s8),
                    child: Image.file(cubit.fileImage!,fit: BoxFit.fill,)):
                Center(
                  child: Icon(Icons.add_a_photo_outlined,
                    color: ColorData.greyRegularColor,size: Unit(context).getWidthSize*0.13,),
                )
            ),
          ),
        ],
      );
    });
  }
}
