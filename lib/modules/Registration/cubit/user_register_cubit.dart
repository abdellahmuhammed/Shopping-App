import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/models/login/LoginModel.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';

part 'user_register_state.dart';

class UserRegisterCubit extends Cubit<UserRegisterState> {
  UserRegisterCubit() : super(UserRegisterInitial());
 static UserRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  void changeIcon()
  {
    isPassword = !isPassword;
    emit(ChangeIconState());
  }


  // confirm password
  // bool confirmPassword = true;
  // void confirmepassword() {
  //   confirmPassword = !confirmPassword;
  //   emit(ConfirmepasswordState());
  // }


  LoginModel userRegisterModel;

  void userRegister({
    @required String name ,
    @required String email ,
    @required String password ,
    @required dynamic phone ,
  }){
    emit(LoadingUserRegisterState());
    DioHelper.postData(
        url: 'register',
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }
    ).then((value) {
      userRegisterModel = LoginModel.fromJson(value.data);
      print('Register successfully ${value.data.toString()}');
      emit(UserRegisterSuccessState(userRegisterModel));
    }).catchError((onError){
      print('Error happened in Register ${onError.toString()}');
      emit(UserRegisterErrorState(onError));

    });
  }


}
