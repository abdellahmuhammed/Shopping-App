// ignore_for_file: non_constant_identifier_names, missing_return

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static  Future<Response> getData({
    @required String url,
     Map < String , dynamic > query,
    String token,
    String lang = 'ar'
  }) async{
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token ?? '',
    };
  return await  dio.get(
      url,
    queryParameters: query,
  );
  }

  static Future<Response> postData({
    @required String url,
    @required Map < String , dynamic > data,
     Map < String , dynamic > query,
    String token,
    String lang = 'ar'
  }) async
  {
    dio.options.headers ={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token ?? '',
    };
   return await dio.post(
        url,
        data: data,
     queryParameters: query
    );
  }
}
