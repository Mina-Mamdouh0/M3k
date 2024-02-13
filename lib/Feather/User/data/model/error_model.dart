
class ErrorModel{
  bool ? success;
  int ? code;
  String ? message;
  ErrorsDataModel ? errorsDataModel;

  ErrorModel({this.errorsDataModel, this.code, this.message, this.success});

  factory ErrorModel.jsonData(data){
    return ErrorModel(
      message: data['message'],
      success: data['success'],
      code: data['code'],
      errorsDataModel: data['errors'] !=null  ? ErrorsDataModel.jsonData(data['errors']) : null,
    );
  }
}

class ErrorsDataModel{
  String ? name;
  String ? phone;
  String ? email;
  String ? password;
  String ? disability;
  String ? age;
  String ? sex;
  String ? city;
  String ? nationality;
  String ? idNumber;
  String ? services;

  ErrorsDataModel(
      {this.name,
      this.phone,
      this.email,
      this.age,
      this.sex,
      this.disability,
      this.password,
      this.nationality,
      this.city,
      this.idNumber,
      this.services,
      });

  factory ErrorsDataModel.jsonData(data){
    return ErrorsDataModel(
      email: data['email']!=null ?data['email'][0]: null,
      name: data['name']!=null ?data['name'][0]: null,
      phone: data['phone']!=null ?data['phone'][0]: null,
      age: data['age']!=null ?data['age'][0]: null,
      sex: data['sex']!=null ?data['sex'][0]: null,
      disability: data['disability']!=null ?data['disability'][0]: null,
      password: data['password']!=null ?data['password'][0]: null,
      services: data['services']!=null ?data['services'][0]: null,
      idNumber: data['ID_number']!=null ?data['ID_number'][0]: null,
      city: data['city']!=null ?data['city'][0]: null,
      nationality: data['nationality']!=null ?data['nationality'][0]: null,
    );
  }
}