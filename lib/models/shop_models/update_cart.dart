// ignore_for_file: unnecessary_new

class UpdateCartModel {
  bool? status;
  String? message;
  Data? data;

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  UpdateCart? cart;
  dynamic subTotal;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? UpdateCart.fromJson(json['cart']) : null;
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class UpdateCart {
  int? id;
  dynamic quantity;
  Product? product;

  UpdateCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}