import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/modules/shop_app/Screens/carts_screen.dart';
import 'package:shopapp/modules/shop_app/Screens/profile_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/styles/colors.dart';

class SideBarScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context).userData;
        return Drawer(
          backgroundColor: AppCubit.get(context).isDark? Colors.blueGrey[900] : Colors.white ,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(cubit!.data!.name),
                accountEmail: Text(cubit.data!.email),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                      child: Image.network(
                        cubit.data!.image,
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: defaultColor,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://venngage-wordpress.s3.amazonaws.com/uploads/2018/09/Colorful-Circle-Simple-Background-Image-1.jpg'
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: ()=> navigateTo(context, ShopAppProfileScreen()),
              ),
              ListTile(
                leading: Icon(
                    AppCubit.get(context).isDark ?
                    Icons.brightness_4_outlined : Icons.brightness_3_outlined
                ),
                title: Text(
                    AppCubit.get(context).isDark ?
                    'light' :'dark'
                ),
                onTap: ()=> AppCubit.get(context).changeMode(),

              ),
              ListTile(
                leading: Icon(Icons.shopping_cart_outlined),
                title: Text('Carts'),
                onTap: ()=> navigateTo(context, CartsScreen()),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: ()=> signOut(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
