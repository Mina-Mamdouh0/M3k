
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:m3k/Core/api/constant_api.dart';
import 'package:m3k/Core/helper/shared_pref_services.dart';
import 'package:m3k/Core/unit/constant_data.dart';
import 'package:m3k/Feather/User/data/model/error_model.dart';
import 'package:m3k/Feather/User/data/model/login_model.dart';
import 'package:m3k/Feather/User/data/model/page_model.dart';
import 'package:m3k/Feather/User/data/model/profile_client_model.dart';
import 'package:m3k/Feather/User/data/model/profile_servant_model.dart';
import 'package:m3k/Feather/User/data/repository/user_repository.dart';
import 'package:m3k/Feather/User/presentation/manager/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserCubit extends Cubit<UserState> {

  UserCubit() : super(AppInitialState());

  static UserCubit get(context) => BlocProvider.of(context);


  String ? selectLogin;
  String endPointPath='';
  bool isBeneficiary=true;

  void selectTypeLogin(String selectLoginEnum){
    selectLogin = selectLoginEnum;
    SharedPreferencesServices.setDate(key: ConstantData.kTypeAccount, value: selectLogin);
    endPointPath= (selectLogin==SelectLoginEnum.beneficiary.name)?'client':'servant';
    isBeneficiary=(selectLogin==SelectLoginEnum.beneficiary.name);
    emit(AnyState());
  }

  void updateLung({required String lung,required BuildContext context}){
    context.setLocale( Locale(lung));
    SharedPreferencesServices.setDate(key: ConstantData.kLung, value: lung);
    emit(UpdateLungState());
  }

  String? myDeviceToken;
  void getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((value){
      myDeviceToken=value;
      emit(GetDeviceTokenState());
    });
  }

  int indexLayout=0;

  void changeIndexLayout({required int index}){
    indexLayout=index;
    emit(AnyState());
  }


  void login({required String phoneNumber , required String password}){
    emit(LoadingLoginState());
    Map<String ,String > body={
      'phone':'966$phoneNumber',
      'password':password,
    };
    UserRepository.login(body: body,endPoint: endPointPath).then((value){
      if(value['success']??false){
        emit(SuccessLoginState(msg: value['message']));
        debugPrint('Success Login');
      }else{
        emit(FiledLoginState(msg: value['message']));
        debugPrint('Filed Login');
      }
    }).onError((error, stackTrace){
      debugPrint('Error Login ${error.toString()}');
      emit(ErrorLoginState());
    });
  }

  void verifyOtp({required String phoneNumber,required String otpCode}){
    emit(LoadingVerifyOtpState());
    Map<String,String> body={
      "phone": "966$phoneNumber",
      "otp_code": otpCode,
      "app_version": "1.0.0",
      "device_token": myDeviceToken??'Device Token From Firebase',
      "device_type": Platform.isAndroid?'android':'ios',
    };
    UserRepository.verifyOtp(
      body: body,
      endPoint: endPointPath
    ).then((value){
      if(value['success']??false){
        LoginModel loginModel =LoginModel.jsonData(value);
        SharedPreferencesServices.setDate(key: ConstantData.kToken, value: loginModel.dataLoginModel?.accessToken);
        SharedPreferencesServices.setDate(key: ConstantData.kLogin,value:  true);
        emit(SuccessVerifyOtpState(msg: loginModel.message??''));
        debugPrint('Success Verify Otp ');
        getProfile();
      }else{
        emit(FiledVerifyOtpState(msg: value['message']));
        debugPrint('Filed Verify Otp ');
      }
    }).onError((error, stackTrace){
      debugPrint('Error Verify Otp : ${error.toString()}');
      emit(ErrorVerifyOtpState());
    });
  }

  ProfileClientModel ? profileClientModel;
  ProfileServantModel ? profileServantModel;
  void getProfile(){
    emit(LoadingGetProfileState());
    String token=SharedPreferencesServices.getDate(key: ConstantData.kToken)??'';
    UserRepository.getProfile(endPoint: endPointPath, token: token).then((value){
      if(endPointPath=='client'){
        profileClientModel = ProfileClientModel.jsonData(value);
      }else{
        profileServantModel = ProfileServantModel.jsonData(value);
      }
      emit(SuccessGetProfileState());
      debugPrint('Success Get Profile');
    }).onError((error, stackTrace){
      debugPrint('Error Get Profile : ${error.toString()}');
      emit(ErrorGetProfileState());
    });
  }

  bool kTermsUse=false;
  void changeTermsUse(bool val){
    kTermsUse=val;
    emit(AnyState());
  }

  File? fileImage;
  void detectFileToFile(File ? file){
    fileImage=file;
    emit(AnyState());
  }

  String sexRegister = SexRegisterEnum.male.name;

  void changeSexRegister({required String sex}){
    sexRegister=sex;
    emit(AnyState());
  }

  void registerClient({required String email , required String phone , required String name , required String password , required String age , required String disability})async{
    emit(LoadingRegisterClientState());
    String token=SharedPreferencesServices.getDate(key: ConstantData.kToken)??'';
    var request = http.MultipartRequest('POST', Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}client/auth/register',),);
    request.headers.addAll({
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Accept-Language':SharedPreferencesServices.getDate(key: ConstantData.kLung)??ConstantData.kDefaultLung,
      'Authorization':'Bearer $token',
    });

    if(fileImage!=null){
      request.files.add(http.MultipartFile('profile_image',
          File(fileImage!.path).readAsBytes().asStream(), File(fileImage!.path).lengthSync(),
          filename: fileImage!.path.split("/").last));
    }

    request.fields['name'] = name;
    request.fields['phone'] = '966$phone';
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = password;
    request.fields['age'] = age;
    request.fields['disability'] = disability;
    request.fields['sex'] = sexRegister;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    var resData = json.decode(response.body);

    debugPrint(request.fields.toString());
    debugPrint(response.body);

    debugPrint(resData.toString());
    if(resData['success']){
      sexRegister=SexRegisterEnum.male.name;
      fileImage=null;
      kTermsUse=false;
      emit(SuccessRegisterClientState(msg: resData['message']??''));
      debugPrint('Success Register Client');
    }else{
      try{
        ErrorModel errorModel= ErrorModel.jsonData(resData);
        emit(FiledRegisterClientState(err: errorModel.errorsDataModel));
        debugPrint('Filed Register Client');
      }catch(e){
        debugPrint('Error Register Client');
        emit(ErrorRegisterClientState());
      }
    }
  }

  List<ServicesModel> serviceRegisterServant=[];

  void addServiceRegisterServant(ServicesModel servicesModel){
    if(serviceRegisterServant.any((element) => element.id==servicesModel.id)){
      serviceRegisterServant.removeWhere((element) => element.id==servicesModel.id);
    }else{
      serviceRegisterServant.add(servicesModel);
    }
    print(serviceRegisterServant.length);
    emit(AnyState());
  }


  void registerServant({required String email , required String phone , required String name , required String password , required String age , required String nationality , required String idNumber , required String city})async{
    emit(LoadingRegisterServantState());
    String token=SharedPreferencesServices.getDate(key: ConstantData.kToken)??'';
    var request = http.MultipartRequest('POST', Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}servant/auth/register',),);
    request.headers.addAll({
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Accept-Language':SharedPreferencesServices.getDate(key: ConstantData.kLung)??ConstantData.kDefaultLung,
      'Authorization':'Bearer $token',
    });

    if(fileImage!=null){
      request.files.add(http.MultipartFile('profile_image',
          File(fileImage!.path).readAsBytes().asStream(), File(fileImage!.path).lengthSync(),
          filename: fileImage!.path.split("/").last));
    }

    request.fields['name'] = name;
    request.fields['phone'] = '966$phone';
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = password;
    request.fields['age'] = age;
    request.fields['nationality'] = nationality;
    request.fields['ID_number'] = idNumber;
    request.fields['city'] = city;
    request.fields['sex'] = sexRegister;


    for(int i=0;i<serviceRegisterServant.length;i++){
      request.fields.addAll({'services[$i]': serviceRegisterServant[i].id.toString()});
    }

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    var resData = json.decode(response.body);

    debugPrint(request.fields.toString());
    debugPrint(response.body);

    debugPrint(resData.toString());
    if(resData['success']){
      sexRegister=SexRegisterEnum.male.name;
      fileImage=null;
      kTermsUse=false;
      serviceRegisterServant=[];
      emit(SuccessRegisterServantState(msg: resData['message']??''));
      debugPrint('Success Register Servant');
    }else{
      try{
        ErrorModel errorModel= ErrorModel.jsonData(resData);
        emit(FiledRegisterServantState(err: errorModel.errorsDataModel));
        debugPrint('Filed Register Servant');
      }catch(e){
        debugPrint('Error Register Servant');
        emit(ErrorRegisterServantState());
      }
    }
  }

  List<ServicesModel> serviceList=[];
  void getServices(){
    emit(LoadingGetServiceState());
    UserRepository.getServices().then((value){
      serviceList=value.services??[];
      debugPrint('Success Get Service');
      emit(SuccessGetServiceState());
    }).onError((error, stackTrace){
      debugPrint('Error Get Service ${error.toString()}');
      emit(ErrorGetServiceState());
    });

  }

  PageModel ? pageModel;
  void getPage({required String id}){
    emit(LoadingPageModelState());
    UserRepository.getPage(id: id).then((value){
      pageModel=value;
      debugPrint('Success Get Page');
      emit(SuccessPageModelState());
    }).onError((error, stackTrace){
      debugPrint('Error Get Page ${error.toString()}');
      emit(ErrorPageModelState());
    });

  }

  void logout(){
    emit(LoadingLogoutState());
    String token=SharedPreferencesServices.getDate(key: ConstantData.kToken)??'';
    UserRepository.logout(endPoint: endPointPath, token: token).then((value){
      emit(SuccessLogoutState());
      profileServantModel=null;
      profileClientModel=null;
      indexLayout=0;
      SharedPreferencesServices.removeDate(key: ConstantData.kLogin);
      SharedPreferencesServices.removeDate(key: ConstantData.kToken);
      SharedPreferencesServices.removeDate(key: ConstantData.kTypeAccount);
      debugPrint('Success Logout');
    }).onError((error, stackTrace){
      profileServantModel=null;
      profileClientModel=null;
      indexLayout=0;
      SharedPreferencesServices.removeDate(key: ConstantData.kLogin);
      SharedPreferencesServices.removeDate(key: ConstantData.kToken);
      SharedPreferencesServices.removeDate(key: ConstantData.kTypeAccount);
      debugPrint('Error Logout : ${error.toString()}');
      emit(ErrorLogoutState());
    });
  }





}