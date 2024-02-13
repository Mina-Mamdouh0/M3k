
class PageModel{
  bool ? success;
  String  ? message;
  int ? code;
  String ? direct;
  DataPageModel ? dataPageModel;

  PageModel(
      {this.dataPageModel, this.message, this.code, this.direct, this.success});

  factory PageModel.jsonData(data){
    return PageModel(
      code: data['code'],
      success: data['success'],
      message: data['message'],
      direct: data['direct'],
      dataPageModel: data['data'] !=null ? DataPageModel.jsonData(data['data']) : null
    );
  }


}

class DataPageModel{
  int ? id;
  String ? title;
  String ? description;
  CreatedAtModel ? createdAt;
  CreatedAtModel ? updatedAt;

  DataPageModel(
      {this.id, this.description, this.title, this.createdAt, this.updatedAt});

  factory DataPageModel.jsonData(data){
    return DataPageModel(
      title: data['title'],
      id: data['id'],
      description: data['description'],
      createdAt: data['created_at'] !=null ? CreatedAtModel.jsonData(data['created_at']) : null,
      updatedAt: data['updated_at'] !=null ? CreatedAtModel.jsonData(data['updated_at']) : null,
    );
  }


}

class CreatedAtModel{
  int ? timestamps;
  String ? forHumans;
  String ? formattedDate;

  CreatedAtModel({this.formattedDate, this.forHumans, this.timestamps});

  factory CreatedAtModel.jsonData(data){
    return CreatedAtModel(
      formattedDate: data['formatted_date'],
      forHumans: data['for_humans'],
      timestamps: data['timestamps'],
    );
  }


}