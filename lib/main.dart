import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/modules/login/Login.dart';
import 'package:shop/modules/register/register.dart';
import 'package:shop/modules/splash/on_boarding.dart';
import 'package:shop/network/dio/dio.dart';
import 'package:shop/shared/cache/cache.dart';
import 'package:shop/shared/constant/constant.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.initcache();
  bool? onboarding = CacheHelper.getdata(key: 'onboarding');
  token = CacheHelper.getdata(key: 'token');
  Widget? widget;
  if (onboarding != null) {
    if (token != null) {
      widget = home_layout();
    } else {
      widget = loginscreen();
    }
  } else {
    widget = const splash();
  }
  runApp(MyApp(
    widget: widget,
  ));
  print(token);
}

class MyApp extends StatelessWidget {
  final widget;

  const MyApp({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => ShopCubit()
                  ..getdatahome()
                  ..GetCategory()
                  ..GetFavourite()
                  ..GetData()),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  fontFamily: 'myfont',
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      selectedItemColor: Colors.deepPurple,
                      unselectedItemColor: Colors.grey),
                  primarySwatch: Colors.deepPurple,
                  appBarTheme: const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white,
                  ))),
              home: RegisterScreen())),
    );
  }
}
