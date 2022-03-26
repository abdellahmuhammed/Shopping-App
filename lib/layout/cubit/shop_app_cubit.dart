import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/home/HomeModel.dart';
import 'package:shopapp/models/login/LoginModel.dart';
import 'package:shopapp/modules/categories/categoties.dart';
import 'package:shopapp/modules/favorite/favorite.dart';
import 'package:shopapp/modules/produts/produts.dart';
import 'package:shopapp/shared/components/constant.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';

part 'shop_app_state.dart';

class ShopAppCubit extends Cubit<ShopAppState> {
  ShopAppCubit() : super(ShopAppInitial());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  LoginModel loginModel;

  void changeIcon() {
    isPassword = !isPassword;
    emit(changeIconState());
  }

  bool confirmPassword = true;

  void confirmepassword() {
    confirmPassword = !confirmPassword;
    emit(confirmepasswordState());
  }

  List<BottomNavigationBarItem> bottomNavBarItem = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'favorites'),
  ];

  List<Widget> bottomsScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
  ];

  var currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(changeBottomNavBarState());
  }

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoadingUserLoginState());
    DioHelper.postData(
      url: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value.data);

      emit(UserLoginSuccessState(loginModel));
    }).catchError((onError) {
      print('Error happened when user Login ${onError.toString()}');
      emit(UserLoginErrorState(onError));
    });
  }

  HomeModel homeModel;

  void getHomeLayoutData() {
    emit(LoadingHomeLayoutState());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel.data.banners.toString());
      emit(HomeLayoutSuccessState());
    }).catchError((onError)
    {
      print(
          'error happened when get data to home layout ${onError.toString()}');
      emit(HomeLayoutErrorState(onError));
    });
  }
}
