import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/Categories/CategoriesModel.dart';
import 'package:shopapp/models/home/HomeModel.dart';
import 'package:shopapp/models/login/LoginModel.dart';
import 'package:shopapp/modules/categories/categoties.dart';
import 'package:shopapp/modules/favorite/favorite.dart';
import 'package:shopapp/modules/produts/produts.dart';
import 'package:shopapp/shared/components/constant.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';

part 'shop_app_state.dart';

class ShopAppCubit extends Cubit<ShopAppState>
{
  ShopAppCubit() : super(ShopAppInitial());

  static ShopAppCubit get(context) => BlocProvider.of(context);

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

  HomeModel homeModel;

  void getHomeLayoutData() {
    emit(LoadingHomeLayoutState());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
     // printFullText(homeModel.data.banners[0].id.toString());
      emit(HomeLayoutSuccessState());
    }).catchError((onError)
    {
      print(
          'error happened when get data to home layout ${onError.toString()}');
      emit(HomeLayoutErrorState(onError));
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesModelData() {
    emit(LoadingHomeLayoutState());
    DioHelper.getData(
      url: 'categories',
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
     // printFullText(homeModel.data.banners[0].id.toString());
      emit(CategoriesSuccessState());
    }).catchError((onError)
    {
      print(
          'error happened when get data to home layout ${onError.toString()}');
      emit(CategoriesErrorState(onError));
    });
  }

// to get profile

  LoginModel userModel;

  void getUserData()
  {
    emit(LoadingProfileState());
    DioHelper.getData(
        url: 'profile',
        token: token
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel.status);
      print(userModel.message);
      print(userModel.data);

      emit(ProfileSuccessState());
    }).catchError((onError){
      print('Error Happened when get Profile ${onError.toString()}');
      emit(ProfileErrorState(onError));
    });

  }


  //to update profile
  // void updateProfile() {
  //   emit(LoadingUpdateProfileState());
  //   DioHelper.getData(
  //     url: 'update-profile',
  //   ).then((value)
  //   {
  //     loginModel = LoginModel.fromJson(value.data);
  //     printFullText(loginModel.data.name);
  //     emit(UpdateProfileSuccessState());
  //   }).catchError((onError)
  //   {
  //     print(
  //         'error happened when Update Profile${onError.toString()}');
  //     emit(UpdateProfileErrorState(onError));
  //   });
  // }





}
