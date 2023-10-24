import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/home_page.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/on_boarding.dart';
import 'CashHelper/cash_helper.dart';
import 'Login_bloc/bloc_observ.dart';
import 'appCubit/cubit.dart';
import 'appCubit/status.dart';
import 'constat.dart';
import 'dio/dio_helper.dart';


void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  // bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
String? token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null)
  {
    if(token != null) {
      widget = HomePage();
    } else {
      widget = ShopLoginScreen();
    }
  } else
  {
    widget = const OnBoarding();
  }

  runApp(MyApp(
    // isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build
  // final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoryData()..getFavouritesData()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: lightTheme,
            // darkTheme: darkTheme,
            // themeMode:
            // ShopCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
