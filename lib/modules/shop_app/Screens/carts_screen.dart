import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_models/Favorites_model.dart';

import '../../../layout/shop_layout/cubit/cubit.dart';
import '../../../layout/shop_layout/cubit/states.dart';
import '../../../shared/components/components.dart';

class CartsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! ShopAppLoadingFavoritesState,
            builder:(context) => cubit.cartsModel!.data!.cartItems.length == 0 ? Padding(
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
                itemBuilder: (context, index) => buildListItem(cubit.cartsModel!.data!.cartItems[index].product,context,isCart: true),
                separatorBuilder: (context, index) => buildSpacerLine(),
                itemCount: cubit.cartsModel!.data!.cartItems.length
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[600],
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Total Price',
                        style: TextStyle(
                          color: Colors.white
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${cubit.cartsModel!.data!.total}',
                      style: TextStyle(
                        color: Colors.blueGrey[600]
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

}
