// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, missing_return

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:shopapp/MyBlocObserver.dart';
import 'package:shopapp/layout/DarkMode/dark_mode_cubit.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/layout/homelayout.dart';
import 'package:shopapp/modules/login/LoginScreen.dart';
import 'package:shopapp/modules/onboarding/onboarding.dart';
import 'package:shopapp/shared/components/constant.dart';
import 'package:shopapp/shared/network/local/sharedpreferences/sharedpreferences.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';
import 'package:shopapp/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool isDarkShow = CacheHelper.getData(key: 'isDarkShow');
  bool Onboarding = CacheHelper.getData(key: 'boarding');
  String token = CacheHelper.getData(key: 'token');
  printFullText('token is $token');
  // print('Onboarding is $Onboarding');
  // print('isDarkShow is $isDarkShow');
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
          create: (context) => ShopAppCubit()
            ..getHomeLayoutData()
            ..getCategoriesModelData()
              ..getFavorites()
              ..getProfile()
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
            home: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return StartWidget;
                } else {
                  return NoInternetBuilder(context);
                }
              },
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // children: const <Widget>[
                //   Text(
                //     'There are no bottom to push :)',
                //   ),
                //   Text(
                //     'Just turn off your internet.',
                //   ),
                // ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget NoInternetBuilder(context) => Center(
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/internetconnection.gif' ,
              height: MediaQuery.of(context).size.height*.5,
                width: MediaQuery.of(context).size.width*.8
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'No Internet Connection..check Internet',
              style: TextStyle(color: Colors.black, fontSize: 14.5 ,decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    ),
  );
}
