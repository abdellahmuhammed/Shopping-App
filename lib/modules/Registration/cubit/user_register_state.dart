part of 'user_register_cubit.dart';

@immutable
abstract class UserRegisterState {}

class UserRegisterInitial extends UserRegisterState {}
class ChangeIconState extends UserRegisterState {}

class LoadingUserRegisterState extends UserRegisterState {}
class UserRegisterSuccessState extends UserRegisterState {
  final LoginModel userRegisterModel;
  UserRegisterSuccessState(this.userRegisterModel);
}
class UserRegisterErrorState extends UserRegisterState {
  final onError;

  UserRegisterErrorState(this.onError);
}
