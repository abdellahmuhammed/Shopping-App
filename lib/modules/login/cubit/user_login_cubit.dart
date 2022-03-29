import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/models/login/LoginModel.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState>
{
  UserLoginCubit() : super(UserLoginInitial());
  static UserLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  void changeIcon()
  {
    isPassword = !isPassword;
    emit(ChangeIconState());
  }

  UserModel userLoginModel;

  void userLogin({
    @required String email,
    @required String password,
  }){
    emit(LoadingUserLoginState());
    DioHelper.postData(
      url: 'login',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      userLoginModel = UserModel.fromJson(value.data);
      print(userLoginModel.status);
      print(userLoginModel.message);

      print(userLoginModel.data.token);

      emit(UserLoginSuccessState(userLoginModel));
    }).catchError((onError) {
      print('Error happened when user Login ${onError.toString()}');
      emit(UserLoginErrorState(onError));
    });
  }
}
