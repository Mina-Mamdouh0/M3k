
import 'package:m3k/Core/api/constant_api.dart';
import 'package:m3k/Core/api/http_services.dart';
import 'package:m3k/Feather/User/data/model/login_model.dart';
import 'package:m3k/Feather/User/data/model/page_model.dart';
import 'package:m3k/Feather/User/data/model/service_model.dart';

class UserRepository{

  static Future login({required Map<String,String> body,required String endPoint}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}$endPoint/auth/login',);
    Map<String, dynamic> data = await ApiService.post(uri: uri,body: body);
    return data;
  }

  static Future verifyOtp({required Map<String,String> body,required String endPoint}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}$endPoint/auth/verify-otp',);
    Map<String, dynamic> data = await ApiService.post(uri: uri,body: body);
    return data;
  }

  static Future getProfile({required String endPoint , required String token}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}$endPoint/profile/me',);
    Map<String, dynamic> data = await ApiService.get(uri: uri,headers:{
      'Authorization':'Bearer $token',
    });
    return data;
  }

  static Future logout({required String endPoint , required String token}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}$endPoint/profile/logout',);
    Map<String, dynamic> data = await ApiService.delete(uri: uri,headers:{
      'Authorization':'Bearer $token',
    });
    return data;
  }

  static Future<PageModel> getPage({required String id}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}page/$id',);
    Map<String, dynamic> data = await ApiService.get(uri: uri,);

    PageModel pageModel =PageModel.jsonData(data);
    return pageModel;
  }

  static Future<ServiceModel> getServices() async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}service',);
    Map<String, dynamic> data = await ApiService.get(uri: uri,);

    ServiceModel serviceModel =ServiceModel.jsonData(data);
    return serviceModel;
  }


}
