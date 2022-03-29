import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/models/search/SearchModel.dart';
import 'package:shopapp/shared/components/constant.dart';
import 'package:shopapp/shared/network/remote/diohelper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void getSearch(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(
            url: 'products/search',
            data: {
              'text': text
            },
            token:
            '8zUzCkxEbICkTv8WciCrrpfIyoT3329NZxqeOCvO89kw0Wwa5YKKyu1suNDGwGBhJ8KZBd')
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      printFullText('searching successfully');
      emit(SuccessSearchState());
    }).catchError((error) {
      printFullText('error happened when get data from search ${error.toString()}');
      emit(ErrorSearchState(error));
    });
  }
}
