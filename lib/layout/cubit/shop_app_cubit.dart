import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'shop_app_state.dart';

class ShopAppCubit extends Cubit<ShopAppState> {
  ShopAppCubit() : super(ShopAppInitial());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changeIcon() {
    isPassword = !isPassword;
    emit(changeIconState());
  }


  bool confirmPassword = true;

  void confirmepassword()
  {
    confirmPassword = !confirmPassword;
    emit(confirmepasswordState());
  }

  List <BottomNavigationBarItem> itemBottom =
      [
         const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'),
         const BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Categories'
        ),
        const BottomNavigationBarItem(
            icon:  Icon(Icons.favorite),label: 'favorites'),
      ];


  var currentIndex= 0;

  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(changeBottomNavBarState());
  }


}
