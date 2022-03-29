// ignore_for_file: prefer_typing_uninitialized_variables

part of 'user_login_cubit.dart';

@immutable
abstract class UserLoginState {}

class UserLoginInitial extends UserLoginState {}

class ChangeIconState extends UserLoginState {}
class ConfirmepasswordState extends UserLoginState {}

class LoadingUserLoginState extends UserLoginState {}

class UserLoginSuccessState extends UserLoginState {
  final UserModel userLoginModel;
  UserLoginSuccessState(this.userLoginModel);
}

class UserLoginErrorState extends UserLoginState {
  final onError;

  UserLoginErrorState(this.onError);
}
