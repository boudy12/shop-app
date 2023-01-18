class CategoriesModel{

  late bool status;
  late String message;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel{

  late int currentPage;
  List<DataModel>? data = [];
  CategoriesDataModel.fromJson(Map<String,dynamic>json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((e){
      data!.add(DataModel.fromJson(e));
      return null;
    });
  }
}

class DataModel{

  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}