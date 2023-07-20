// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names

class Login_Model {
  User_Data ? user_data ;
  var token ;

  Login_Model.fromjson(Map<String,dynamic>json){
    token = json['token'];
    user_data = ( json['token'] == null ) ? null : User_Data.fromjson(json['user']) ;
  }
}

class User_Data {
  var id ;
  var name ;
  var email ;
  var phone ;
  var image ;
  var age ;
  var gender ;
  var information_about ;

  User_Data.fromjson ( Map <String , dynamic> json ){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    age = json['age'];
    gender = json['gender'];
    information_about = json['information_about'];
  }
}
