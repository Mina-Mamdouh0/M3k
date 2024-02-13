
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:m3k/Core/handlingData/error_app_custom.dart';
import 'package:m3k/Core/handlingData/error_msg_custom.dart';
import 'package:m3k/Core/handlingData/loading_app_custom.dart';
import 'package:m3k/Core/handlingData/sussess_app_custom.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
import 'package:m3k/Core/unit/app_router.dart';
import 'package:m3k/Core/unit/assets_data.dart';
import 'package:m3k/Core/unit/color_data.dart';
import 'package:m3k/Core/unit/size_data.dart';
import 'package:m3k/Core/unit/styles.dart';
import 'package:m3k/Core/unit/unit.dart';
import 'package:m3k/Core/widget/input_text_custom.dart';
import 'package:m3k/Core/widget/main_button_custom.dart';
import 'package:m3k/Core/widget/out_line_button_custom.dart';
import 'package:m3k/Feather/User/presentation/manager/user_cubit.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';
import 'package:m3k/Feather/User/presentation/view/widget/choose_image_custom.dart';
import 'package:m3k/Feather/User/presentation/view/widget/sex_register_custom.dart';
import 'package:m3k/Feather/User/presentation/view/widget/terms_use_custom.dart';

class RegisterBeneficiaryView extends StatelessWidget {
  RegisterBeneficiaryView({Key? key}) : super(key: key);

  TextEditingController nameController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController confirmPasswordController =TextEditingController();
  TextEditingController typeOfDisabilityOrInjuryController =TextEditingController();
  TextEditingController ageController =TextEditingController();


  FocusNode nameNode =FocusNode();
  FocusNode phoneNode =FocusNode();
  FocusNode emailNode =FocusNode();
  FocusNode passwordNode =FocusNode();
  FocusNode confirmPasswordNode =FocusNode();
  FocusNode typeOfDisabilityOrInjuryNode =FocusNode();
  FocusNode ageNode =FocusNode();

  GlobalKey<FormState> kForm=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit,UserState>(
        builder: (context,state){
          var cubit=UserCubit.get(context);
          return SingleChildScrollView(
            padding: EdgeInsets.all(SizeData.s20),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: kForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: SizeData.s30,),
                  AspectRatio(
                    aspectRatio: 1.5/0.5,
                    child: Image.asset(AssetsData.logoImage),
                  ),
                  SizedBox(height: SizeData.s30,),

                  Text(LocaleKeys.kNewAccount.tr(),
                    style: Styles.textStyle24.copyWith(
                        fontSize: Unit(context).getWidthSize*0.064,
                        color: ColorData.blackColor
                    ),),
                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: nameController,
                    inputType: TextInputType.text,
                    focusNode: nameNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(phoneNode),
                    labelText: LocaleKeys.kName.tr(),
                  ),
                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: phoneController,
                    inputType: TextInputType.number,
                    focusNode: phoneNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(emailNode),
                    labelText: LocaleKeys.kPhoneNumber.tr(),
                  ),

                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    focusNode: emailNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(passwordNode),
                    labelText: LocaleKeys.kEmail.tr(),
                  ),

                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: passwordController,
                    inputType: TextInputType.text,
                    focusNode: passwordNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(confirmPasswordNode),
                    labelText: LocaleKeys.kPassword.tr(),
                  ),

                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: confirmPasswordController,
                    inputType: TextInputType.text,
                    focusNode: confirmPasswordNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(typeOfDisabilityOrInjuryNode),
                    labelText: LocaleKeys.kConfirmPassword.tr(),
                  ),

                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: typeOfDisabilityOrInjuryController,
                    inputType: TextInputType.text,
                    focusNode: typeOfDisabilityOrInjuryNode,
                    onEditingComplete: ()=>FocusScope.of(context).requestFocus(ageNode),
                    labelText: LocaleKeys.kTypeOfDisabilityOrInjury.tr(),
                  ),

                  SizedBox(height: SizeData.s15,),
                  InputTextCustom(
                    controller: ageController,
                    inputType: TextInputType.number,
                    focusNode: ageNode,
                    labelText: LocaleKeys.kAge.tr(),
                  ),
                  SizedBox(height: SizeData.s15,),

                  SexRegisterCustom(),

                  SizedBox(height: SizeData.s15,),
                  const ChooseImageCustom(),

                  (state is FiledRegisterClientState)?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20,),

                      if(state.err?.name!=null)
                        ErrorMsgCustom(msg: state.err?.name??'',),

                      if(state.err?.sex!=null)
                        ErrorMsgCustom(msg: state.err?.sex??'',),

                      if(state.err?.disability!=null)
                        ErrorMsgCustom(msg: state.err?.disability??'',),

                      if(state.err?.age!=null)
                        ErrorMsgCustom(msg: state.err?.age??'',),

                      if(state.err?.phone!=null)
                        ErrorMsgCustom(msg: state.err?.phone??'',),

                      if(state.err?.password!=null)
                        ErrorMsgCustom(msg: state.err?.password??'',),

                      if(state.err?.email!=null)
                        ErrorMsgCustom(msg: state.err?.email??'',),
                    ],
                  ):Container(),

                  SizedBox(height: SizeData.s25,),

                  const TermUseCustom(),

                  SizedBox(height: SizeData.s20,),

                  (state is LoadingRegisterClientState)?
                  const LoadingAppCustom():
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MainButtonCustom(
                        text: LocaleKeys.kRegistration.tr(),
                        fct: (){
                          if(kForm.currentState!.validate()){
                            if(passwordController.text==confirmPasswordController.text){
                              if(cubit.kTermsUse){
                                cubit.registerClient(email: emailController.text, phone: phoneController.text, name: nameController.text, password: passwordController.text, age: ageController.text , disability: typeOfDisabilityOrInjuryController.text);
                              }else{
                                showErrorToast(context: context,msg: LocaleKeys.kYouMustAgreeToTheTermsAndConditions.tr());
                              }
                            }else{
                              showErrorToast(context: context,msg: LocaleKeys.kTheTwoPasswordsDoNotMatch.tr());
                            }
                          }
                        },
                      ),
                      SizedBox(height: SizeData.s25,),
                      OutLineButtonCustom(
                        text: LocaleKeys.kEntrance.tr(),
                        fct: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: SizeData.s25,),
                ],
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessRegisterClientState){
            showSuccessToast(context: context,msg: state.msg??'');
            GoRouter.of(context).pushReplacement(AppRouter.kOtpCodeView,
                extra: phoneController.text);
          }else if (state is ErrorRegisterClientState){
            showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
          }
        },
      )
    );
  }
}
