
import 'package:m3k/Feather/User/data/model/error_model.dart';

abstract class UserState{}

class AppInitialState extends UserState{}

class AnyState extends UserState{}
class GetDeviceTokenState extends UserState{}
class UpdateLungState extends UserState{}

class LoadingLoginState extends UserState{}
class SuccessLoginState extends UserState{
  String ? msg;
  SuccessLoginState({this.msg});
}
class FiledLoginState extends UserState{
  String ? msg;
  FiledLoginState({this.msg});
}
class ErrorLoginState extends UserState{}

class LoadingVerifyOtpState extends UserState{}
class SuccessVerifyOtpState extends UserState{
  String ? msg;
  SuccessVerifyOtpState({this.msg});
}
class FiledVerifyOtpState extends UserState{
  String ? msg;
  FiledVerifyOtpState({this.msg});
}
class ErrorVerifyOtpState extends UserState{}

class LoadingGetProfileState extends UserState{}
class SuccessGetProfileState extends UserState{}
class ErrorGetProfileState extends UserState{}

class LoadingRegisterClientState extends UserState{}
class SuccessRegisterClientState extends UserState{
  String ? msg;
  SuccessRegisterClientState({this.msg});
}
class FiledRegisterClientState extends UserState{
  ErrorsDataModel ? err;
  FiledRegisterClientState({this.err});
}
class ErrorRegisterClientState extends UserState{}


class LoadingRegisterServantState extends UserState{}
class SuccessRegisterServantState extends UserState{
  String ? msg;
  SuccessRegisterServantState({this.msg});
}
class FiledRegisterServantState extends UserState{
  ErrorsDataModel ? err;
  FiledRegisterServantState({this.err});
}
class ErrorRegisterServantState extends UserState{}

class LoadingGetServiceState extends UserState{}
class SuccessGetServiceState extends UserState{}
class ErrorGetServiceState extends UserState{}

class LoadingLogoutState extends UserState{}
class SuccessLogoutState extends UserState{}
class ErrorLogoutState extends UserState{}

class LoadingPageModelState extends UserState{}
class SuccessPageModelState extends UserState{}
class ErrorPageModelState extends UserState{}
