
import 'package:m3k/Feather/User/data/model/login_model.dart';

class ProfileServantModel{
  bool ? success;
  String ? message;
  String ? direct;
  int ? code;
  ServantModel ? servantModel;

  ProfileServantModel(
      {this.servantModel,
        this.direct,
        this.code,
        this.message,
        this.success});

  factory ProfileServantModel.jsonData(data){
    return ProfileServantModel(
      code: data['code'],
      success: data['success'],
      direct: data['direct'],
      message: data['message'],
      servantModel: data['data'] !=null ? ServantModel.jsonData(data['data']) : null,
    );
  }
}