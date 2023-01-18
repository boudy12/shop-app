import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_models/search_model.dart';
import 'package:shopapp/modules/shop_app/Screens/search/cubit/states.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopAppSearchCubit extends Cubit<ShopAppSearchStates> {
  ShopAppSearchCubit() : super(ShopAppSearchInitialStates());

  static ShopAppSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;


  void search({
    required String text ,
  }) {
    emit(ShopAppSearchLoadingStates());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text':text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopAppSearchSuccessStates());
      print(searchModel!.data!.data!.length);
    }).catchError((error){
      print(error.toString());
      emit(ShopAppSearchErrorStates(error.toString()));
    });
  }
}