// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names

class GetMyBankAccount_Model {
  var number_account ;
  var value_of_account ;

  GetMyBankAccount_Model.fromjson ( Map <String , dynamic> json ){
    number_account = json['number_account'];
    value_of_account = json['value_of_account'] ;
  }
}