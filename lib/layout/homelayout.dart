import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/shop_app_cubit.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var cubit = ShopAppCubit.get(context);
    return BlocConsumer<ShopAppCubit, ShopAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.itemBottom,
            currentIndex: cubit.currentIndex,
            onTap: (int index){
              cubit.changeBottomNavBar(index);
            },
          ),
          body: Column(
            children: const[

            ],
          ),
        );
      },
    );
  }
}
