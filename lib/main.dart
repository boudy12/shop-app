import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/shop_home_screen.dart';


import 'package:shopapp/modules/shop_app/login/login_screen.dart';
import 'package:shopapp/shared/Bloc_Observer.dart';
import 'package:bloc/bloc.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/styles/Themes.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async

{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  late bool isDark = CacheHelper.getData(key: 'isDark');

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key: 'token');
  print(token);

  runApp(MyApp(
    isDark: isDark,
  ));
}


class MyApp extends StatelessWidget {

  final bool? isDark;

  MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeMode(fromShared: isDark),),
        BlocProvider(create: (context) => ShopAppCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()..getCarts(),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:  ThemeMode.light, //  AppCubit.get(context).isDark? ThemeMode.dark :
            debugShowCheckedModeBanner: false,
            home: ShopLayoutScreen(),
          );
        },

      ),
    );
  }
// This widget is the root of your application.

}

