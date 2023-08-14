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

  static Future<bool> putBankAccount(accountId) async {
    return await sherdpreferance!.setString('bankAccount', accountId.toString());
  }

  static String ? getBankAccount() {
    return sherdpreferance!.getString('bankAccount');
  }

  static void removeFromUserData () {
    sherdpreferance!.remove('bankAccount');
  }

  static void logout ()  {
    sherdpreferance!.remove("token");
    if ( sherdpreferance!.getString('bankAccount') != null ){
      sherdpreferance!.remove('bankAccount');
    }
  }

  static Future <bool> putUserData ( Map <String,dynamic> data ) async {
    return await sherdpreferance!.setString("User_Data", jsonEncode(data));
  }

  static Map <String,dynamic> getUserData()  {
    String ? encoded_current_user = sherdpreferance!.getString("User_Data") ;
    Map <String,dynamic> current_user =  jsonDecode(encoded_current_user!);
    return current_user ;
  }

}
