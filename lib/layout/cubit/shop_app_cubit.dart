import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/models/user/user_model.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';

part 'shop_app_state.dart';

class ShopAppCubit extends Cubit<ShopAppState> {
  ShopAppCubit() : super(ShopAppInitial());

  static ShopAppCubit get(context) => BlocProvider.of(context);
  static UserModel model;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoadingShopAppDataState());
    DioHelper.postData('api/users',
      FormData.fromMap({
        'action':'login',
        'api_section':'users',
        'email':email,
        'password' : password
      })
    ).then((value){
      print(value.data);
      emit(GetShopAppDataSuccessState());
    }).catchError((onError) {
      print('Error Happened ${onError.toString()}');
      emit(GetShopAppDataErrorState(onError));
    });
  }

}
