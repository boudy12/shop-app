import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/models/shop_models/Carts_model.dart';
import 'package:shopapp/models/shop_models/Favorites_model.dart';
import 'package:shopapp/models/shop_models/categories_model.dart';
import 'package:shopapp/models/shop_models/change_carts_model.dart';
import 'package:shopapp/models/shop_models/change_favorites_model.dart';
import 'package:shopapp/models/shop_models/home_model.dart';
import 'package:shopapp/models/shop_models/login_model.dart';
import 'package:shopapp/models/shop_models/update_cart.dart';
import 'package:shopapp/modules/shop_app/Screens/carts_screen.dart';
import 'package:shopapp/modules/shop_app/Screens/categories_screen.dart';
import 'package:shopapp/modules/shop_app/Screens/favorites_screen.dart';
import 'package:shopapp/modules/shop_app/Screens/products_screen.dart';
import 'package:shopapp/modules/shop_app/Screens/setting_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';



class ShopAppCubit extends Cubit<ShopAppStates>{
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
  ];

  List<String> title = [
    'Products',
    'Categories',
    'Favorites',
  ];

  List<BottomNavigationBarItem> bottomIcon = [
    BottomNavigationBarItem(
      icon:Icon(
        Icons.home_outlined,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.apps_outlined,
      ),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.favorite,
      ),
      label: 'Favorites',
    ),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(ShopAppChangeBottomNavBarState());
  }


  HomeModel? homeModel;

  Map<int,bool>? favorites = {};


  Map<int,bool>? carts = {};

  void getHomeData(){
    emit(ShopAppLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
      lang: 'en',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element)
      {
        favorites!.addAll({
          element.id : element.inFavorites
        });
      });
      homeModel!.data!.products!.forEach((element)
      {
        carts!.addAll({
          element.id : element.inCart
        });
      });
      emit(ShopAppSuccessHomeDataState());
    }).catchError((error){
      emit(ShopAppErrorHomeDataState(error.toString()));

    });
  }

  CategoriesModel? categoriesModel;

  void getCategories(){

    emit(ShopAppLoadingCategoriesState());

    DioHelper.getData(
      url: Categories,
      token: token,
      lang: 'en',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopAppSuccessCategoriesState());
    }).catchError((error){
      emit(ShopAppErrorCategoriesState(error.toString()));

    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavItem(int productId){
    favorites![productId] = !(favorites![productId])!;
    emit(ShopAppLoadingChangeFavState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status)
        {
          favorites![productId] = !(favorites![productId])!;
        }else{
        getFavorites();
      }
      emit(ShopAppSuccessChangeFavState(changeFavoritesModel!));
    }).catchError((error){
      favorites![productId] = !(favorites![productId])!;
      emit(ShopAppErrorChangeFavState(error.toString()));
    });
  }



  ChangeCartsModel? changeCartsModel;

  void changeCartsItem(int productId){
    carts![productId] = !(carts![productId])!;
    emit(ShopAppLoadingChangeCartsState());

    DioHelper.postData(
      url: CARTS,
      data: {
        'product_id': productId
      },
      token: token,
    ).then((value) {
      changeCartsModel = ChangeCartsModel.fromJson(value.data);
      if(!changeCartsModel!.status)
      {
        carts![productId] = !(carts![productId])!;
      }else{
        getCarts();
      }
      emit(ShopAppSuccessChangeCartsState(changeCartsModel!));
    }).catchError((error){
      carts![productId] = !(carts![productId])!;
      emit(ShopAppErrorChangeCartsState(error.toString()));
    });
  }






  FavoritesModel? favoritesModel;
  List<dynamic> fav = [];


  void getFavorites() async
  {
    emit(ShopAppLoadingFavoritesState());

   await DioHelper.getData(
      url: FAVORITES,
      token: token,
      lang: 'en',
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      fav = value.data;
      emit(ShopAppSuccessFavoritesState());
    }).catchError((error){
      emit(ShopAppErrorFavoritesState(error.toString()));

    });
  }


  CartModel? cartsModel;


  void getCarts() async
  {
    emit(ShopAppLoadingCartsState());

    await DioHelper.getData(
      url: CARTS,
      token: token,
      lang: 'en',
    ).then((value) {
      cartsModel = CartModel.fromJson(value.data);
      emit(ShopAppSuccessCartsState());
    }).catchError((error){
      emit(ShopAppErrorCartsState(error.toString()));

    });
  }


  ShopAppUseLoginModel? userData;

  void getUserData(){

    emit(ShopAppLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
      lang: 'en',
    ).then((value) {
      userData = ShopAppUseLoginModel.fromJson(value.data);
      print(userData!.data!.name);
      printFullText(userData!.data!.email);
      emit(ShopAppSuccessUserDataState(userData!));
    }).catchError((error){
      emit(ShopAppErrorUserDataState(error.toString()));

    });
  }

  void getUpdateUserData({
    required String name,
    required String email,
    required String phone,
    String? password,
  })
  {
    emit(ShopAppLoadingUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name': name,
          'email':email,
          'phone':phone,
        }
    ).then((value)
    {
      userData = ShopAppUseLoginModel.fromJson(value.data);
      emit(ShopAppSuccessUpdateUserDataState(userData!));
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorUpdateUserDataState(error.toString()));
    });
  }


  int counter  = 1;
  void minus({
  required int id,
})
  {

    if(counter > 0)
    {
      counter--;
    }
    emit(ShopAppCounterMinusStates());
  }

  void plus({
    required int id,
  })
  {
    counter++;
    emit(ShopAppCounterPlusStates());
  }

  UpdateCartModel? updateCartModel;
  void updateCartData(int id,) {
    emit(ShopAppUpdateCartLoadingStates());
    DioHelper.putData(
        url: 'carts/$id',
        data: {
          'quantity': counter,
        },
        token: token)
        .then((value) {
      updateCartModel = UpdateCartModel.fromJson(value.data);
      if (updateCartModel!.status!) {
        getCarts();
      } else
        showToast(
          msg: updateCartModel!.message!,
          state: ToastStates.SUCCESS,
        );
      //  print('updateCartModel ' + updateCartModel.status.toString());
      emit(ShopAppUpdateCartSuccessStates());
    }).catchError((error) {
      emit(ShopAppUpdateCartErrorStates());
      print(error.toString());
    });
  }
}