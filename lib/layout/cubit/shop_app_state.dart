// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

part of 'shop_app_cubit.dart';

@immutable
abstract class ShopAppState {}

class ShopAppInitial extends ShopAppState {}

class changeIconState extends ShopAppState {}
class confirmepasswordState extends ShopAppState {}
class changeBottomNavBarState extends ShopAppState {}

// login states
class LoadingUserLoginState extends ShopAppState {}
class UserLoginSuccessState extends ShopAppState {
  final LoginModel loginModel;
  UserLoginSuccessState(this.loginModel);
}
class UserLoginErrorState extends ShopAppState {
  final onError;

  UserLoginErrorState(this.onError);
}


// HomeLayout states
class LoadingHomeLayoutState extends ShopAppState {}
class HomeLayoutSuccessState extends ShopAppState {}
class HomeLayoutErrorState extends ShopAppState {
  final onError;
  HomeLayoutErrorState(this.onError);
}

