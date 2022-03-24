part of 'shop_app_cubit.dart';

@immutable
abstract class ShopAppState {}

class ShopAppInitial extends ShopAppState {}

class LoadingShopAppDataState extends ShopAppState {}

class GetShopAppDataSuccessState extends ShopAppState {}

class GetShopAppDataErrorState extends ShopAppState {
  final onError;

  GetShopAppDataErrorState(this.onError);
}
