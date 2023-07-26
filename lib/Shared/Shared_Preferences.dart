// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class sharedPreferences
{
  static SharedPreferences ? sherdpreferance;

  static init () async {
    sherdpreferance = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(String token) async {
    return await sherdpreferance!.setString("token", token);
  }

  static String? getData(String data)  {
    return sherdpreferance!.getString(data);
  }

  static Future<bool> putyouareData(String youare) async {
    return await sherdpreferance!.setString("youare", youare);
  }

  static String? getyouareData(String token)  {
    return  sherdpreferance!.getString("youare");
  }

  static void logout ()  {
    sherdpreferance!.remove("token");
  }

  static Future <bool> putUserData ( Map <String,dynamic> data ) async {
    return await sherdpreferance!.setString("User_Data", jsonEncode(data));
  }

  static Map <String,dynamic> getUserData()  {
    String ? encoded_current_user = sherdpreferance!.getString("User_Data") ;
    Map <String,dynamic> current_user =  jsonDecode(encoded_current_user!);
    return current_user ;
  }

  static Future <bool> putCurrentexpertData ( Map <String,dynamic> data ) async {
    return await sherdpreferance!.setString("Currentexpert", jsonEncode(data));
  }

  static Map <String,dynamic> getCurrentExpertData()  {
    String? encoded_current_expert = sherdpreferance!.getString("Currentexpert") ;
    Map <String,dynamic> current_expert =  jsonDecode(encoded_current_expert!);
    return current_expert ;
  }

}
