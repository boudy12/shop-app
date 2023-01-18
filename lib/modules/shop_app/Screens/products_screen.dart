import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/models/shop_models/categories_model.dart';
import 'package:shopapp/models/shop_models/home_model.dart';
import 'package:shopapp/modules/shop_app/Screens/show_product.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/styles/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {
        if(state is ShopAppSuccessChangeFavState)
          {
            if(!state.changeFavModel.status){
              showToast(msg: state.changeFavModel.message, state: ToastStates.ERROR);
            }
          }
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          builder: (context) => productsBuilder(cubit.homeModel!,cubit.categoriesModel!,context),
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          [
            CarouselSlider(
              items: model.data!.banners!.map((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage('${e.image}'),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              )).toList(),
              options: CarouselOptions(
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(
                  seconds: 3
                ),
                autoPlayAnimationDuration: Duration(
                  seconds: 1
                ),
                initialPage: 0,
                height:250,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
                enableInfiniteScroll: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  Container(
                    height: 120,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItem(categoriesModel.data!.data![index]),
                        separatorBuilder:(context, index) =>  SizedBox(
                          width: 10,
                        ),
                        itemCount: categoriesModel.data!.data!.length
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Products',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: AppCubit.get(context).isDark? Colors.blueGrey[900] : Colors.grey[100],
                child: GridView.count(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1/1.7,
                  children: List.generate(model.data!.products!.length,
                          (index) =>buildGridProduct(model.data!.products![index],context),
                  ),
                ),
              ),
            ),
          ],
    ),
  );

  Widget buildGridProduct(ProductModel model,context) => InkWell(
    onTap: () {
        navigateTo(
          context,
          ShowProductScreen(model: model),
        );
    },
    child: Container(
      color: AppCubit.get(context).isDark? Colors.blueGrey[900] : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
                fit:  AppCubit.get(context).isDark? BoxFit.cover: null,
              ),
              if(model.oldPrice != 0)
                Container(
                color: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                    'DISCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  model.name,
                  style: TextStyle(
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        height: 1.4,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if(model.oldPrice != 0)
                      Text(
                      '${model.oldPrice.round()}',
                      style: TextStyle(
                        height: 1.3,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 17,
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
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildCategoriesItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: NetworkImage(model.image),
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.6),
        width: 120,
        child: Text(
          model.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
