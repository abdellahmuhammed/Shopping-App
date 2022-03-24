// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://csi-covid19.000webhostapp.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> GetData(
      {@required String url, @required Map<String, dynamic> query}) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> postData(
      String url,
     FormData data ,
    //@required
      // Map<String, dynamic> query,
  ) async
  {
     return await dio.post(
         url,
         data: data,
     );
    //
    // return await dio.post(
    //   url,
    //   data: data,
    // );
  }
}
