// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

part of 'shop_app_cubit.dart';

@immutable
abstract class ShopAppState {}

class ShopAppInitial extends ShopAppState {}
class changeBottomNavBarState extends ShopAppState {}


// HomeLayout states
class LoadingHomeLayoutState extends ShopAppState {}
class HomeLayoutSuccessState extends ShopAppState {}
class HomeLayoutErrorState extends ShopAppState {
  final onError;
  HomeLayoutErrorState(this.onError);
}


// Categories state

class CategoriesSuccessState extends ShopAppState {}
class CategoriesErrorState extends ShopAppState {
  final onError;

  CategoriesErrorState(this.onError);
}


// Profile states
class LoadingProfileState extends ShopAppState {}
class ProfileSuccessState extends ShopAppState {}
class ProfileErrorState extends ShopAppState {
  final onError;
  ProfileErrorState(this.onError);
}



// UpdateProfile states
class LoadingUpdateProfileState extends ShopAppState {}
class UpdateProfileSuccessState extends ShopAppState {}
class UpdateProfileErrorState extends ShopAppState {
  final onError;
  UpdateProfileErrorState(this.onError);
}