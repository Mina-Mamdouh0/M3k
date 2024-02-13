
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
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Core/widget/main_button_custom.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';
import 'dart:ui' as ui;

import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCodeView extends StatelessWidget {
  final String phoneNumber;
  OtpCodeView({Key? key, required this.phoneNumber}) : super(key: key);

  TextEditingController otpCodeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics : const BouncingScrollPhysics(),
        padding: EdgeInsets.all(SizeData.s20),
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
            Text(LocaleKeys.kLoginConfirmationCode.tr(),
            style:  Styles.textStyle24.copyWith(
              color: ColorData.blackColor,
              fontSize: Unit(context).getWidthSize*0.064,
            ),),
            SizedBox(height: SizeData.s10,),
            Text('${LocaleKeys.kTypeTheConfirmationCodeThatWasSentToTheNumber.tr()} $phoneNumber',
              style:  Styles.textStyle22.copyWith(
                color: ColorData.blackColor,
                fontSize: Unit(context).getWidthSize*0.05,
              ),),

            SizedBox(height: SizeData.s10,),

            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 30),
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle:  const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: false,
                    obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: ColorData.primaryColor,
                      inactiveColor: ColorData.greyRegularColor,
                      inactiveFillColor: ColorData.whiteColor,
                      activeFillColor: ColorData.whiteColor,
                      selectedFillColor: ColorData.whiteColor,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: otpCodeController,
                    keyboardType: TextInputType.number,
                    textStyle: const TextStyle(
                        color: Colors.black
                    ),
                    onCompleted: (v) {},
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                  ),
                )),

            SizedBox(height: SizeData.s20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(LocaleKeys.kDidNotReceiveTheCode.tr(),
                  style:  Styles.textStyle22.copyWith(
                    color: ColorData.blackColor,
                    fontSize: Unit(context).getWidthSize*0.05,
                  ),),
                SizedBox(width: SizeData.s5,),
                InkWell(
                  onTap: (){

                  },
                  child: Text(LocaleKeys.kResend.tr(),
                    style:  Styles.textStyle24.copyWith(
                      color: ColorData.primaryColor,
                      fontSize: Unit(context).getWidthSize*0.05,
                    ),),
                ),


              ],
            ),
            SizedBox(height: SizeData.s30,),
            BlocConsumer<UserCubit,UserState>(
              builder: (context,state){
                var cubit=UserCubit.get(context);
                return (state is LoadingVerifyOtpState)?
                const LoadingAppCustom():
                MainButtonCustom(text: LocaleKeys.kToBeSure.tr(),
                  fct: (){
                    cubit.verifyOtp(phoneNumber: phoneNumber, otpCode: otpCodeController.text);
                  },);
            },
            listener: (context,state){
                if(state is SuccessVerifyOtpState){
                  showSuccessToast(context: context, msg: state.msg??'');
                  context.go(AppRouter.kLayoutView);
                }else if (state is FiledVerifyOtpState){
                  showErrorToast(context: context, msg: state.msg??'');
                }else if (state is ErrorVerifyOtpState){
                  showErrorToast(context: context, msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
                }
            },)
          ],
        ),

      ),
    );
  }
}
