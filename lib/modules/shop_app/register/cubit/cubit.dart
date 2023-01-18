import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_models/login_model.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/modules/shop_app/register/cubit/states.dart';
import 'package:shopapp/shared/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopAppRegisterCubit extends Cubit<ShopAppRegisterStates>{

  ShopAppRegisterCubit() : super(ShopAppRegisterInitialState());

  static ShopAppRegisterCubit get(context)=> BlocProvider.of(context);

  ShopAppUseLoginModel? shopRegisterModel;

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;

  void changIconRegisterPasswordState(){
    isPassword = !isPassword;
    suffix = isPassword? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
    emit(ShopAppRegisterShowPasswordState());
  }


  void userRegister({
  required String email,
  required String password,
  required String phone,
  required String name,
})
  {
    emit(ShopAppRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        },
      lang: 'en'
    ).then((value) {
      shopRegisterModel = ShopAppUseLoginModel.fromJson(value.data);
      emit(ShopAppRegisterSuccessState(shopRegisterModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopAppRegisterErrorState(error.toString()));
    });
  }


}