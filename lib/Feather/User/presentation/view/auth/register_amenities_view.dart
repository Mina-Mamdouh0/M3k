
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:m3k/Core/handlingData/error_app_custom.dart';
import 'package:m3k/Core/handlingData/error_msg_custom.dart';
import 'package:m3k/Core/handlingData/loading_app_custom.dart';
import 'package:m3k/Core/translations/locale_keys.g.dart';
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
import 'package:m3k/Feather/User/presentation/view/widget/function/servant_register_dialog.dart';
import 'package:m3k/Feather/User/presentation/view/widget/sex_register_custom.dart';
import 'package:m3k/Feather/User/presentation/view/widget/terms_use_custom.dart';

class RegisterAmenitiesView extends StatefulWidget {
  const RegisterAmenitiesView({Key? key}) : super(key: key);

  @override
  State<RegisterAmenitiesView> createState() => _RegisterAmenitiesViewState();
}

class _RegisterAmenitiesViewState extends State<RegisterAmenitiesView> {

  TextEditingController nameController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController confirmPasswordController =TextEditingController();
  TextEditingController nationalityController =TextEditingController();
  TextEditingController nationalIdentityController =TextEditingController();
  TextEditingController ageController =TextEditingController();
  TextEditingController cityController =TextEditingController();

  FocusNode nameNode =FocusNode();
  FocusNode phoneNode =FocusNode();
  FocusNode emailNode =FocusNode();
  FocusNode passwordNode =FocusNode();
  FocusNode confirmPasswordNode =FocusNode();
  FocusNode nationalityNode =FocusNode();
  FocusNode nationalIdentityNode =FocusNode();
  FocusNode ageNode =FocusNode();
  FocusNode cityNode =FocusNode();

  GlobalKey<FormState> kForm=GlobalKey<FormState>();
  GroupButtonController serviceController =GroupButtonController();

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).serviceRegisterServant=[];
    BlocProvider.of<UserCubit>(context).getServices();
    super.initState();
  }

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
                      inputType: TextInputType.name,
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
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(nationalityNode),
                      labelText: LocaleKeys.kConfirmPassword.tr(),
                    ),

                    SizedBox(height: SizeData.s15,),
                    InputTextCustom(
                      controller: nationalityController,
                      inputType: TextInputType.text,
                      focusNode: nationalityNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(nationalIdentityNode),
                      labelText: LocaleKeys.kNationality.tr(),
                    ),

                    SizedBox(height: SizeData.s15,),
                    InputTextCustom(
                      controller: nationalIdentityController,
                      inputType: TextInputType.text,
                      focusNode: nationalIdentityNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(ageNode),
                      labelText: LocaleKeys.kNationalIdentity.tr(),
                    ),

                    SizedBox(height: SizeData.s15,),
                    InputTextCustom(
                      controller: ageController,
                      inputType: TextInputType.name,
                      focusNode: ageNode,
                      onEditingComplete: ()=>FocusScope.of(context).requestFocus(cityNode),
                      labelText: LocaleKeys.kAge.tr(),
                    ),

                    SizedBox(height: SizeData.s15,),
                    InputTextCustom(
                      controller: cityController,
                      inputType: TextInputType.name,
                      focusNode: cityNode,
                      labelText: LocaleKeys.kCity.tr(),
                    ),
                    SizedBox(height: SizeData.s15,),


                    (state is LoadingGetServiceState)?
                    const LoadingAppCustom():
                    ExpansionTile(
                      title: Text(LocaleKeys.kChooseTheService.tr(),style:
                      Styles.textStyle22.copyWith(
                        color: ColorData.greyRegularColor,
                        fontSize: Unit(context).getWidthSize*0.058,
                      ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side:BorderSide(color:ColorData.greyRegularColor),
                      ) ,
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side:BorderSide(color:ColorData.greyRegularColor),
                      ) ,
                      childrenPadding: EdgeInsets.symmetric(horizontal: SizeData.s20,),
                      children: [
                        GroupButton(
                          controller: serviceController,
                          isRadio: false,
                          enableDeselect: true,
                          options: const GroupButtonOptions(
                            mainGroupAlignment: MainGroupAlignment.start,
                            groupRunAlignment: GroupRunAlignment.start,
                            crossGroupAlignment: CrossGroupAlignment.start,
                            groupingType: GroupingType.column,
                          ),
                          buttonIndexedBuilder: (select,index,context){
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical:SizeData.s4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(cubit.serviceList[index].title??'',
                                      style: Styles.textStyle24.copyWith(
                                          fontSize: Unit(context).getWidthSize*0.045,
                                          color: ColorData.black2Color
                                      ),),
                                  ),
                                  select?Icon(Icons.check,
                                      color:ColorData.primaryColor,size: Unit(context).getWidthSize*0.053):Container(),
                                ],
                              ),
                            );

                          },
                          onSelected: (_,index,select){
                            cubit.addServiceRegisterServant(cubit.serviceList[index]);
                          },
                          buttons: cubit.serviceList,)
                      ],
                    ),


                    SizedBox(height: SizeData.s15,),

                    SexRegisterCustom(),

                    SizedBox(height: SizeData.s15,),
                    const ChooseImageCustom(),

                    SizedBox(height: SizeData.s25,),

                    const TermUseCustom(),

                    (state is FiledRegisterServantState)?
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

                        if(state.err?.nationality!=null)
                          ErrorMsgCustom(msg: state.err?.nationality??'',),

                        if(state.err?.city!=null)
                          ErrorMsgCustom(msg: state.err?.city??'',),

                        if(state.err?.idNumber!=null)
                          ErrorMsgCustom(msg: state.err?.idNumber??'',),

                        if(state.err?.services!=null)
                          ErrorMsgCustom(msg: state.err?.services??'',),
                      ],
                    ):Container(),

                    SizedBox(height: SizeData.s20,),

                    (state is LoadingRegisterServantState)?
                    const LoadingAppCustom():
                    Column(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       MainButtonCustom(
                         text: LocaleKeys.kRegistration.tr(),
                         fct: (){
                           if(kForm.currentState!.validate()){
                             if(passwordController.text==confirmPasswordController.text){
                               if(cubit.kTermsUse){
                                 cubit.registerServant(email: emailController.text, phone: phoneController.text, name: nameController.text, password: passwordController.text, age: ageController.text , idNumber: nationalIdentityController.text , nationality: nationalityController.text ,city: cityController.text);
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
            if(state is SuccessRegisterServantState){
              //showSuccessToast(context: context,msg: state.msg??'');
              showDialog(context: context,
                  barrierDismissible: false,
                  builder: (context){
                    return buildServantRegisterDialog(context: context);
                  });
            }else if (state is ErrorRegisterServantState){
              showErrorToast(context: context,msg: LocaleKeys.kTheOperationFailedTryAgainLater.tr());
            }
          },
        )
    );
  }
}
