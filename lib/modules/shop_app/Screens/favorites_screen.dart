import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_models/Favorites_model.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_layout/cubit/states.dart';
import '../../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return  ConditionalBuilder(
          condition: state is! ShopAppLoadingFavoritesState,
          builder:(context) => cubit.favoritesModel!.data!.data.length == 0 ? Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Images/nodata.png',
                  ),
                  Text('Favorites are empty!'),
                ],
              ),
            ),
          ) : ListView.separated(
              physics: BouncingScrollPhysics(),
               itemBuilder: (context, index) => buildListItem(cubit.favoritesModel!.data!.data[index]!.product,context),
              separatorBuilder: (context, index) => buildSpacerLine(),
              itemCount: cubit.favoritesModel!.data!.data.length
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
