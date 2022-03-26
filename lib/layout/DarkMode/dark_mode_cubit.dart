import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/shared/network/local/sharedpreferences/sharedpreferences.dart';

part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeStates> {
  DarkModeCubit() : super(DarkModeInitial());

  static DarkModeCubit get(context) => BlocProvider.of(context);

  bool isDarkShow = true;

  void changeAppMode({bool fromShared})
  {
    if (fromShared != null)
    {
      isDarkShow = fromShared;
      emit(ChangeAppModeState());
    } else
    {
      isDarkShow = !isDarkShow;
      CacheHelper.putBoolean(key: 'isDark', value: isDarkShow).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }
}
