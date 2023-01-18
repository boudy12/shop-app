import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/models/shop_models/categories_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubit.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return  ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCategoriesItem(cubit.categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => buildSpacerLine(),
            itemCount: cubit.categoriesModel!.data!.data!.length
        );
      },
    );
  }

  Widget buildCategoriesItem(DataModel model)=> InkWell(
onTap: () {

},
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(model.image),
                  fit: BoxFit.cover,
                )
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),

          ),
          Spacer(),
          IconButton(
            onPressed: (){},
            icon:Icon(
              Icons.arrow_forward_ios_outlined,
            ),
          ),
        ],
      ),
    ),
  );
}
