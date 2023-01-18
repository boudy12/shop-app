import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_models/login_model.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/shared/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopAppLoginCubit extends Cubit<ShopAppLoginStates>{

  ShopAppLoginCubit() : super(ShopAppLoginInitialState());

  static ShopAppLoginCubit get(context)=> BlocProvider.of(context);

  late ShopAppUseLoginModel shopLoginModel;

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changIconPasswordState(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
    emit(ShopAppLoginShowPasswordState());
  }


  void userLogin({
  required String email,
  required String password,
})
  {
    emit(ShopAppLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
      lang: 'en'
    ).then((value) {
      shopLoginModel = ShopAppUseLoginModel.fromJson(value.data);
      emit(ShopAppLoginSuccessState(shopLoginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopAppLoginErrorState(error.toString()));
    });
  }


}