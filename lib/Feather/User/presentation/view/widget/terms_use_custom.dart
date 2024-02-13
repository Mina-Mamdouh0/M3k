
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/app_router.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';

class TermUseCustom extends StatelessWidget {
  const TermUseCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
      builder: (context,state){
        var cubit=UserCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: cubit.kTermsUse,
                activeColor: ColorData.primaryColor,
                onChanged: (val)=>cubit.changeTermsUse(val!)),
            SizedBox(width: SizeData.s2,),
            InkWell(
              onTap: (){
                GoRouter.of(context).push(AppRouter.kTermsConditionsView);
              },
              child: Text(LocaleKeys.kIAgreeToTheTermsAndConditions.tr(),
                style: Styles.textStyle22.copyWith(
                    color: ColorData.greyBoldColor,
                    fontSize: Unit(context).getWidthSize*0.058
                ),),
            )
          ],
        );
      },
    );
  }
}
