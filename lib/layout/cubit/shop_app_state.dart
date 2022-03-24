// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

part of 'shop_app_cubit.dart';

@immutable
abstract class ShopAppState {}

class ShopAppInitial extends ShopAppState {}

class changeIconState extends ShopAppState {}

class confirmepasswordState extends ShopAppState {}

class changeBottomNavBarState extends ShopAppState {}


class LoadingDataState extends ShopAppState {}

class GetDataSuccessState extends ShopAppState {}

class GetDataErrorState extends ShopAppState {
  final onError;

  GetDataErrorState(this.onError);
}
