import 'package:shopapp/models/shop_models/change_carts_model.dart';
import 'package:shopapp/models/shop_models/login_model.dart';

import '../../../models/shop_models/change_favorites_model.dart';

abstract class ShopAppStates{}

class ShopAppInitialState extends ShopAppStates{}

class ShopAppChangeBottomNavBarState extends ShopAppStates{}


class ShopAppLoadingHomeDataState extends ShopAppStates{}

class ShopAppSuccessHomeDataState extends ShopAppStates{}

class ShopAppErrorHomeDataState extends ShopAppStates{
  final String error;

  ShopAppErrorHomeDataState(this.error);
}



class ShopAppLoadingCategoriesState extends ShopAppStates{}

class ShopAppSuccessCategoriesState extends ShopAppStates{}

class ShopAppErrorCategoriesState extends ShopAppStates{
  final String error;

  ShopAppErrorCategoriesState(this.error);
}



class ShopAppLoadingChangeFavState extends ShopAppStates{}

class ShopAppSuccessChangeFavState extends ShopAppStates{
  final ChangeFavoritesModel changeFavModel;

  ShopAppSuccessChangeFavState(this.changeFavModel);
}

class ShopAppErrorChangeFavState extends ShopAppStates{
  final String error;

  ShopAppErrorChangeFavState(this.error);
}



class ShopAppLoadingFavoritesState extends ShopAppStates{}

class ShopAppSuccessFavoritesState extends ShopAppStates{}

class ShopAppErrorFavoritesState extends ShopAppStates{
  final String error;

  ShopAppErrorFavoritesState(this.error);
}



class ShopAppLoadingUserDataState extends ShopAppStates{}

class ShopAppSuccessUserDataState extends ShopAppStates{
  final ShopAppUseLoginModel shopAppUseLoginModel;

  ShopAppSuccessUserDataState(this.shopAppUseLoginModel);
}

class ShopAppErrorUserDataState extends ShopAppStates{
  final String error;

  ShopAppErrorUserDataState(this.error);
}




class ShopAppLoadingUpdateUserDataState extends ShopAppStates{}

class ShopAppSuccessUpdateUserDataState extends ShopAppStates{
  final ShopAppUseLoginModel shopLoginModel;

  ShopAppSuccessUpdateUserDataState(this.shopLoginModel);
}

class ShopAppErrorUpdateUserDataState extends ShopAppStates{
  final String error;

  ShopAppErrorUpdateUserDataState(this.error);

}



class ShopAppLoadingChangeCartsState extends ShopAppStates{}

class ShopAppSuccessChangeCartsState extends ShopAppStates{
  final ChangeCartsModel changeCartsModel;

  ShopAppSuccessChangeCartsState(this.changeCartsModel);
}

class ShopAppErrorChangeCartsState extends ShopAppStates{
  final String error;

  ShopAppErrorChangeCartsState(this.error);
}



class ShopAppLoadingCartsState extends ShopAppStates{}

class ShopAppSuccessCartsState extends ShopAppStates{}

class ShopAppErrorCartsState extends ShopAppStates{
  final String error;

  ShopAppErrorCartsState(this.error);
}


class ShopAppCounterPlusStates extends ShopAppStates{}

class ShopAppCounterMinusStates extends ShopAppStates{}




class ShopAppUpdateCartLoadingStates extends ShopAppStates{}

class ShopAppUpdateCartSuccessStates extends ShopAppStates{}

class ShopAppUpdateCartErrorStates extends ShopAppStates{}