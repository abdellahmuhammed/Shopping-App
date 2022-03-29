import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/Categories/CategoriesModel.dart';
import 'package:shopapp/models/GetFavorites/GetFavorites.dart';
import 'package:shopapp/models/changeFavorites/changeFavoritesModel.dart';
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

  // get Home layout
  HomeModel homeModel;
  Map<int, bool> favorites = {};

  void getHomeLayoutData() {
    emit(LoadingHomeLayoutState());
    DioHelper.getData(
      url: 'home',
      token:
          'VPgBjeuBI3X7Z6r25vIaQ1aemUXarCSePlQUfUhcbOnnTF1WUDEXiftFTuxo33XhEL3cUh',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      emit(HomeLayoutSuccessState());
    }).catchError((onError) {
      printFullText(
          'error happened when get data to home layout ${onError.toString()}');
      emit(HomeLayoutErrorState(onError));
    });
  }

// get Categories
  CategoriesModel categoriesModel;

  void getCategoriesModelData() {
    emit(LoadingHomeLayoutState());
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // printFullTextFullText(homeModel.data.banners[0].id.toString());
      emit(CategoriesSuccessState());
    }).catchError((onError) {
      printFullText(
          'error happened when get data to home layout ${onError.toString()}');
      emit(CategoriesErrorState(onError));
    });
  }

  // change GetFavorites
  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    emit(LoadingChangeFavoritesState());

    favorites[productId] = !favorites[productId];
    emit(FavoritesSuccessState());

    DioHelper.postData(
            url: 'favorites',
            data: {'product_id': productId},
            token:
                'VPgBjeuBI3X7Z6r25vIaQ1aemUXarCSePlQUfUhcbOnnTF1WUDEXiftFTuxo33XhEL3cUh')
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // printFullTextFullText(homeModel.data.banners[0].id.toString());

      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ChangeFavoritesSuccessState(changeFavoritesModel));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId];

      printFullText(
          'error happened when Change GetFavorites  ${onError.toString()}');

      emit(ChangeFavoritesErrorState(onError));
    });
  }

  GetFavoritesModel getFavoritesModel;

  void getFavorites() {
    emit(LoadingGetFavoritesState());
    DioHelper.getData(
            url: 'favorites',
            token:
                'VPgBjeuBI3X7Z6r25vIaQ1aemUXarCSePlQUfUhcbOnnTF1WUDEXiftFTuxo33XhEL3cUh')
        .then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      // printFullTextFullText(value.data.toString());
      emit(GetFavoritesSuccessState());
    }).catchError((onError) {
      printFullText('error happened when get Favorites ${onError.toString()}');
      emit(GetFavoritesErrorState(onError));
    });
  }

  UserModel getUserProfileModel ;

  void getProfile(){
    emit(LoadingProfileState());
    DioHelper.getData(
        url: 'profile',
      token: 'VPgBjeuBI3X7Z6r25vIaQ1aemUXarCSePlQUfUhcbOnnTF1WUDEXiftFTuxo33XhEL3cUh'
    ).then((value) {
      getUserProfileModel= UserModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ProfileSuccessState());
    }).catchError((onError){
      printFullText('error happened when get user profile ${onError.toString()}');
      emit(ProfileErrorState(onError));
    });
  }




// // to get profile
//
//   LoginModel userProfileModel;
//
//   void getUserProfile()
//   {
//     emit(LoadingProfileState());
//     DioHelper.getData(
//         url: 'profile',
//         token: token
//     ).then((value)
//     {
//       userProfileModel = LoginModel.fromJson(value.data);
//       printFullText('message is ${userProfileModel.data.id}');
//       emit(ProfileSuccessState());
//
//     }).catchError((onError){
//       printFullText('Error Happened when get User Profile ${onError.toString()}');
//       emit(ProfileErrorState(onError));
//     });
//
//   }

/*
//
//   to update profile
//   void updateProfile() {
//     emit(LoadingUpdateProfileState());
//     DioHelper.getData(
//       url: 'update-profile',
//     ).then((value)
//     {
//       loginModel = LoginModel.fromJson(value.data);
//       printFullTextFullText(loginModel.data.name);
//       emit(UpdateProfileSuccessState());
//     }).catchError((onError)
//     {
//       printFullText(
//           'error happened when Update Profile${onError.toString()}');
//       emit(UpdateProfileErrorState(onError));
//     });
//   }
*/
}
