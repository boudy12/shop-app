class SearchModel
{
  late bool status;
  late String message;
  SearchData? data;

  SearchModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = SearchData.fromJson(json['data']);
  }
}

class SearchData {
  late int currentPage;
  List<Product>? data =[];

  SearchData.fromJson(Map<String,dynamic> json)
  {
    currentPage = json['current_page'];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}