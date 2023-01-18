import 'package:shopapp/models/shop_models/login_model.dart';

abstract class ShopAppLoginStates{}

class ShopAppLoginInitialState extends ShopAppLoginStates{}

class ShopAppLoginLoadingState extends ShopAppLoginStates{}

class ShopAppLoginSuccessState extends ShopAppLoginStates{

  final ShopAppUseLoginModel shopAppUseLoginModel;

  ShopAppLoginSuccessState(this.shopAppUseLoginModel);
}

class ShopAppLoginErrorState extends ShopAppLoginStates{
  final String error;
  ShopAppLoginErrorState(this.error);
}

class ShopAppLoginShowPasswordState extends ShopAppLoginStates{}
