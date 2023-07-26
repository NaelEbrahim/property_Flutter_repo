// ignore_for_file: camel_case_types, file_names

import 'package:dio/dio.dart';

class Dio_Helper {
  static late Dio dio ;

  static init () {
  dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.43.115:8000/api/',
      headers: {
        'Accept' : 'application/json',
      }
    )
  );
  }

  static Future <Response> postData ({
    required String url ,
    required Map <String , dynamic> data ,
    headers }) {
    return dio.post(
        url ,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          headers: {
           'Authorization' : 'Bearer $headers'
          })
    );
  }

  static Future <Response> getData (String url){
    return dio.get(url);
  }


}