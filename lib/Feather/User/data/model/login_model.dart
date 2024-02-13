
class LoginModel{
  bool ? success;
  String ? message;
  String ? direct;
  int ? code;
  DataLoginModel ? dataLoginModel;

  LoginModel(
      {this.dataLoginModel,
      this.direct,
      this.code,
      this.message,
      this.success});

  factory LoginModel.jsonData(data){
    return LoginModel(
      code: data['code'],
      success: data['success'],
      direct: data['direct'],
      message: data['message'],
      dataLoginModel: data['data'] !=null ? DataLoginModel.jsonData(data['data']) : null,
    );
  }
}

class DataLoginModel{
  String  ? accessToken;
  ClientModel ? clientModel;
  ServantModel ? servantModel;

  DataLoginModel({this.accessToken , this.clientModel ,this.servantModel});

  factory DataLoginModel.jsonData(data){
    return DataLoginModel(
      accessToken : data['access_token'],
      clientModel : data['client'] != null ? ClientModel.jsonData(data['client']) : null,
      servantModel : data['servant'] != null ? ServantModel.jsonData(data['servant']) : null,
    );
  }
}

class ClientModel{
String ? name;
String ? phone;
String ? email;
String ? disability;
int ? age;
String ? sex;
double ? wallet;
String ? profileImage;

ClientModel(
    {this.name,
      this.phone,
      this.email,
      this.age,
      this.disability,
      this.profileImage,
      this.sex,
      this.wallet});

factory ClientModel.jsonData(data){
  return ClientModel(
    email: data['email'],
    name: data['name'],
    phone: data['phone'],
    age: data['age'],
    disability: data['disability'],
    profileImage: data['profile_image'],
    sex: data['sex'],
    wallet: double.tryParse(data['wallet'].toString()),
  );
}


}

class ServantModel{
  String ? name;
  String ? phone;
  String ? email;
  String ? nationality;
  int ? age;
  String ? sex;
  double ? wallet;
  String ? iDNumber;
  String ? city;
  double ? rate;
  String ? profileImage;
  List<ServicesModel>? serviceList;

  ServantModel(
      {this.sex, this.age, this.email, this.phone, this.name, this.city, this.iDNumber, this.nationality, this.wallet,this.profileImage,this.rate , this.serviceList});

  factory ServantModel.jsonData(data){

    var serviceList = data['services']!=null? data['services'] as List:[];
    List<ServicesModel> services = serviceList.map((tagJson) => ServicesModel.jsonData(tagJson)).toList();

    return ServantModel(
      wallet: double.tryParse(data['wallet'].toString()),
      sex: data['sex'],
      age: data['age'],
      phone: data['phone'],
      name: data['name'],
      email: data['email'],
      city: data['city'],
      iDNumber: data['ID_number'],
      serviceList: data['services'] !=null? services: null,
      nationality: data['nationality'],
      rate: double.tryParse(data['rate'].toString()),
      profileImage: data['profile_image'],
    );
  }
}

class ServicesModel{
  int ? id;
  String ? title;
  String ? description;
  String ? image;
  int ? pricePerHour;
  String ? discountPercent;
  String ? hoursToStartDiscount;

  ServicesModel(
      {this.title,
      this.image,
      this.id,
      this.description,
      this.discountPercent,
      this.hoursToStartDiscount,
      this.pricePerHour});

  factory ServicesModel.jsonData(data){
    return ServicesModel(
      description: data['description'],
      id: data['id'],
      title: data['title'],
      image: data['image'],
      discountPercent: data['discount_percent'],
      hoursToStartDiscount: data['hours_to_start_discount'],
      pricePerHour: data['price_per_hour'],
    );
  }
}


