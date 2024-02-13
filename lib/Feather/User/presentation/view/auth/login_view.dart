
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:m3k/Core/handlingData/error_app_custom.dart';
import 'package:m3k/Core/handlingData/loading_app_custom.dart';
import 'package:m3k/Core/handlingData/sussess_app_custom.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/app_router.dart';
import 'package:m3k/Core/unit/assets_data.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/constant_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Core/widget/input_text_custom.dart';
import 'package:m3k/Core/widget/main_button_custom.dart';
import 'package:m3k/Core/widget/out_line_button_custom.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  TextEditingController phoneController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  FocusNode phoneNode=FocusNode();
  FocusNode passwordNode=FocusNode();

  GlobalKey<FormState> kForm=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeData.s20),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: kForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeData.s30,),
              AspectRatio(
                aspectRatio: 1.5/0.5,
                child: Image.asset(AssetsData.logoImage),
              ),
              SizedBox(height: SizeData.s30,),

              Text(LocaleKeys.kSignIn.tr(),
              style: Styles.textStyle24.copyWith(
                fontSize: Unit(context).getWidthSize*0.064,
                color: ColorData.blackColor
              ),),
              SizedBox(height: SizeData.s15,),
              InputTextCustom(
               controller: phoneController,
               inputType: TextInputType.number,
               focusNode: phoneNode,
               onEditingComplete: ()=>FocusScope.of(context).requestFocus(passwordNode),
               labelText: LocaleKeys.kPhoneNumber.tr(),
              ),
              SizedBox(height: SizeData.s15,),
              InputTextCustom(
                controller: passwordController,
                inputType: TextInputType.text,
                focusNode: passwordNode,
                labelText: LocaleKeys.kPassword.tr(),
              ),
              SizedBox(height: SizeData.s15,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(LocaleKeys.kForgotYourPassword.tr(),
                  style: Styles.textStyle24.copyWith(
                    color: ColorData.greyBoldColor,
                    fontSize: Unit(context).getWidthSize*0.064,
                  ),),
                ],
              ),
              SizedBox(height: SizeData.s15,),
              BlocConsumer<UserCubit,UserState>(
                  builder: (context,state){
                    var cubit=UserCubit.get(context);
                    return (state is LoadingLoginState)?
                    const LoadingAppCustom():
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MainButtonCustom(
                          text: LocaleKeys.kEntrance.tr(),
                          fct: (){
                            if(kForm.currentState!.validate()){
                              cubit.login(phoneNumber: phoneController.text, password: passwordController.text);
                            }
                          },
                        ),
                        SizedBox(height: SizeData.s25,),
                        OutLineButtonCustom(
                          text: LocaleKeys.kRegistration.tr(),
                          fct: (){
                            if(cubit.selectLogin==SelectLoginEnum.beneficiary.name){
                              GoRouter.of(context).push(AppRouter.kRegisterBeneficiaryView);
                            }else{
                              GoRouter.of(context).push(AppRouter.kRegisterAmenitiesView);
                            }

                          },
                        ),
                      ],
                    );
                  },
                  listener: (context,state){
                    if(state is SuccessLoginState){
                      showSuccessToast(context: context,msg: state.msg??'');
                      GoRouter.of(context).push(AppRouter.kOtpCodeView, extra: phoneController.text);
                    }else if (state is FiledLoginState){
                      showErrorToast(context: context,msg: state.msg??'');
                    }else if (state is ErrorLoginState){
                      showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
                    }

                  })

            ],
          ),
        ),
      ),
    );
  }
}
