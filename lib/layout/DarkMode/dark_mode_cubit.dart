import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'dark_mode_state.dart';

class DarkModeCubit extends Cubit<DarkModeStates> {
  DarkModeCubit() : super(DarkModeInitial());
  static DarkModeCubit get(context) => BlocProvider.of(context);

var isDarkShow = false;
void changeAppMode(){
  isDarkShow =!isDarkShow;
  emit(ChangeAppModeState());
}

}
