class ChangeCartsModel{

  late bool status;
  late String message;

  ChangeCartsModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }

}