
import 'package:m3k/Feather/User/data/model/login_model.dart';

class ServiceModel{
  bool ? success;
  String ? message;
  int ? code;
  String ? direct;
  List<ServicesModel>? services;

  ServiceModel(
      {this.direct, this.code, this.message,this.services, this.success});

  factory ServiceModel.jsonData(data){

    var serviceList = data['data']!=null? data['data'] as List:[];
    List<ServicesModel> services = serviceList.map((tagJson) => ServicesModel.jsonData(tagJson)).toList();

    return ServiceModel(
      direct: data['direct'],
      message: data['message'],
      success: data['success'],
      code: data['code'],
      services: data['data']!=null ? services : null,
    );
  }
}