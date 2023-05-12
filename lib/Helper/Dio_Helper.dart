// ignore_for_file: camel_case_types

import 'package:dio/dio.dart';

class Dio_Helper {
  static late Dio dio ;

  static init () {
  dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.43.115:8000/api/',
    )
  );
  }

  static Future <Response> postData ( String url , Map <String , dynamic> data ) {
    return dio.post(
        url ,
        data: data
    );
  }

}