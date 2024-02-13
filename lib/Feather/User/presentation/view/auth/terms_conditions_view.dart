
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m3k/Core/handlingData/loading_app_custom.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Core/widget/main_button_custom.dart';
import 'package:m3k/Core/widget/out_line_button_custom.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';

class TermsConditionsView extends StatefulWidget {
  const TermsConditionsView({Key? key}) : super(key: key);

  @override
  State<TermsConditionsView> createState() => _TermsConditionsViewState();
}

class _TermsConditionsViewState extends State<TermsConditionsView> {

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getPage(id: '2');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit=UserCubit.get(context);
          return Padding(
            padding: EdgeInsets.all(SizeData.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SafeArea(child: SizedBox(height: SizeData.s20,)),
                Text(cubit.pageModel?.dataPageModel?.title??'',style: Styles.textStyle24.copyWith(
                    fontSize: Unit(context).getWidthSize*0.064,
                    color: ColorData.blackColor
                ),),

                SizedBox(height: SizeData.s10,),

                (state is LoadingPageModelState)?
                const LoadingAppCustom():
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(cubit.pageModel?.dataPageModel?.description??'',style: Styles.textStyle22.copyWith(
                        color: ColorData.greyBoldColor,
                        fontSize: Unit(context).getWidthSize*0.058
                    ),),
                  ),
                ),

                SizedBox(height: SizeData.s20,),

                MainButtonCustom(
                  text: LocaleKeys.kOK.tr(),
                  fct: (){
                    cubit.changeTermsUse(true);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: SizeData.s25,),
                OutLineButtonCustom(
                  text: LocaleKeys.kToReject.tr(),
                  fct: (){
                    cubit.changeTermsUse(false);
                    Navigator.of(context).pop();
                  },
                ),

              ],
            ),
          );
        },
      )
    );
  }
}
