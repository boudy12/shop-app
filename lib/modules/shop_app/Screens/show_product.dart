import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/models/shop_models/Favorites_model.dart';
import 'package:shopapp/models/shop_models/home_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/styles/colors.dart';

class ShowProductScreen extends StatelessWidget {
  final ProductModel model;

  const ShowProductScreen({

    required this.model
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopAppSuccessChangeFavState) {
          if (!state.changeFavModel.status) {
            showToast(
                msg: state.changeFavModel.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(250),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              flexibleSpace: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CarouselSlider(
                      items: model.images!
                          .map((e) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage('${e}'),

                                    )),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        initialPage: 0,
                        height: 250,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppCubit.get(context).isDark
                              ? Colors.blueGrey[900]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(30)),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          '${model.image}',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color:  AppCubit.get(context).isDark
                              ? Colors.white
                              : Colors.blueGrey[900],
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: defaultColor,
                            ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: (ShopAppCubit.get(context).favorites![model.id])! ? defaultColor:Colors.grey,
                        child: IconButton(
                            onPressed: () {
                              ShopAppCubit.get(context).changeFavItem(model.id);
                              print(model.id);
                            },
                            icon: Icon(
                              Icons.favorite_outline_outlined,
                              size: 18,
                              color: Colors.white,
                            )
                        ),
                      ),
                    ],
                  ),
                Padding(

                  padding: EdgeInsets.symmetric(horizontal: 5),

                  child: Container(

                    height: 2,

                    width: double.infinity,

                    color: defaultColor,



                  ),

                ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('${model.description}'),
                  ),
                ],
              ),
            ),
          ),
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(color: defaultColor),
                      ),
                      Text(
                        'Price',
                        style: TextStyle(height: 1.4),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    color: (ShopAppCubit.get(context).carts![model.id])! ? Colors.blueGrey[600] :defaultColor,
                    width: 300,
                    height: 45,
                    child: TextButton(
                      onPressed: () {
                        ShopAppCubit.get(context).changeCartsItem(model.id);
                        print(model.id);
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 25.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                (ShopAppCubit.get(context).carts![model.id])! ? 'added ':'add to card',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
