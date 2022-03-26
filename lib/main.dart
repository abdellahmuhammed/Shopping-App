// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/MyBlocObserver.dart';
import 'package:shopapp/layout/DarkMode/dark_mode_cubit.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/layout/homelayout.dart';
import 'package:shopapp/modules/login/LoginScreen.dart';
import 'package:shopapp/modules/onboarding/onboarding.dart';
import 'package:shopapp/shared/network/local/sharedpreferences/sharedpreferences.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';
import 'package:shopapp/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  // bool isDarkShow = CacheHelper.getData(key: 'isDarkShow');
 bool isDarkShow =false;
  bool Onboarding = CacheHelper.getData(key: 'boarding');
  String token = CacheHelper.getData(key: 'token');

  Widget widget;

  if (Onboarding != null) {
    if (token != null) {
      widget = const HomeLayoutScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  print(Onboarding);

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        isDarkShow: isDarkShow,
        StartWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDarkShow;
  final Widget StartWidget;

  const MyApp({this.isDarkShow, this.StartWidget, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopAppCubit()..getHomeLayoutData(),
        ),
        BlocProvider(
          create: (context) =>
              DarkModeCubit()..changeAppMode(fromShared: isDarkShow),
        ),
      ],
      child: BlocConsumer<DarkModeCubit, DarkModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: DarkModeCubit.get(context).isDarkShow
                ? ThemeMode.dark
                : ThemeMode.light,
            home: StartWidget,
          );
        },
      ),
    );
  }
}
