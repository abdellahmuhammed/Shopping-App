// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopapp/layout/DarkMode/dark_mode_cubit.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';
import 'package:shopapp/modules/login/LoginScreen.dart';
import 'package:shopapp/modules/profile/ProfileScreen.dart';
import 'package:shopapp/modules/search/searchScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/sharedpreferences/sharedpreferences.dart';
import 'package:shopapp/shared/styles/colors.dart';

class HomeLayoutScreen extends StatelessWidget {
    HomeLayoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopAppCubit.get(context);
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    NavigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search),
              ),
              IconButton(
                  onPressed: () {
                    DarkModeCubit.get(context).changeAppMode();
                  },
                  icon: DarkModeCubit.get(context).isDarkShow
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode)),
            ],
          ),
          drawer: ConditionalBuilder(
            condition: cubit != null && ShopAppCubit.get(context).getFavoritesModel != null &&
                ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).categoriesModel != null,
            builder: (BuildContext context)=>buildDrawer(context),
            fallback: (context)=> const Center (
              child:  CircularProgressIndicator(),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavBarItem,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNavBar(index);
            },
          ),
          body: cubit.bottomsScreens[cubit.currentIndex],
        );
      },
    );
  }


  Widget buildDrawer(context)=>Container(
    width: MediaQuery.of(context).size.width * .6,
    decoration: const BoxDecoration(boxShadow: [
      BoxShadow(
          color: white,
          spreadRadius: 2,
          blurRadius: 30,
          offset: Offset(8, 5))
    ]),
    child: Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .28,
            width: double.infinity,
            child: Padding(
              padding:
              const EdgeInsetsDirectional.only(top: 40, start: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.height * .28,
                    decoration:  const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/spinner.gif'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text( ShopAppCubit.get(context).getUserProfileModel.data.name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text( ShopAppCubit.get(context).getUserProfileModel.data.phone,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextButton(
            onPressed: () {
              NavigateTo(context, ProfileScreen());
            },
            child: Row(
              children: const [
                Icon(Icons.person),
                SizedBox(
                  width: 20,
                ),
                Text('Profile'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Icon(Icons.language),
                SizedBox(
                  width: 20,
                ),
                Text('Language'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Icon(Icons.phone),
                SizedBox(
                  width: 20,
                ),
                Text('Connect With us'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defaultLaunchRrl(icon: FontAwesomeIcons.github, Url: 'https://github.com/abdellahmuhammed'),
              defaultLaunchRrl(icon: FontAwesomeIcons.linkedin, Url: 'https://www.linkedin.com/in/abdellah-muhammed-9984781a9'),
              defaultLaunchRrl(icon: FontAwesomeIcons.telegram, Url: 'https://t.me/+201126017421'),
              // defaultLaunchRrl(icon: FontAwesomeIcons.whatsapp, Url: 'https://api.whatsapp.com/send/?phone=01126017421&text&app_absent=0')

            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              CacheHelper.removeData(key: 'token').then((value) {
                if (value) {
                  NavigateAndRemove(context, LoginScreen());
                }
              });
            },
            child: Row(
              children: const [
                Icon(Icons.logout),
                SizedBox(
                  width: 20,
                ),
                Text('Logout'),
              ],
            ),
          ),

        ],
      ),
    ),
  );


}
