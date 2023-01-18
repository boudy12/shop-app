import 'package:shopapp/models/shop_models/login_model.dart';

abstract class ShopAppRegisterStates{}

class ShopAppRegisterInitialState extends ShopAppRegisterStates{}

class ShopAppRegisterLoadingState extends ShopAppRegisterStates{}

class ShopAppRegisterSuccessState extends ShopAppRegisterStates{

  final ShopAppUseLoginModel shopAppUseRegisterModel;

  ShopAppRegisterSuccessState(this.shopAppUseRegisterModel);
}

class ShopAppRegisterErrorState extends ShopAppRegisterStates{
  final String error;
  ShopAppRegisterErrorState(this.error);
}

class ShopAppRegisterShowPasswordState extends ShopAppRegisterStates{}
