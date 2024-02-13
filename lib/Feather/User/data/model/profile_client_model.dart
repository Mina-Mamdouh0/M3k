
import 'package:m3k/Feather/User/data/model/login_model.dart';

class ProfileClientModel{
  bool ? success;
  String ? message;
  String ? direct;
  int ? code;
  ClientModel ? clientModel;

  ProfileClientModel(
      {this.clientModel,
        this.direct,
        this.code,
        this.message,
        this.success});

  factory ProfileClientModel.jsonData(data){
    return ProfileClientModel(
      code: data['code'],
      success: data['success'],
      direct: data['direct'],
      message: data['message'],
      clientModel: data['data'] !=null ? ClientModel.jsonData(data['data']) : null,
    );
  }
}