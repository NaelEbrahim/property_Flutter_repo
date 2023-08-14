// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types

import 'package:university_project_property_app/Shared/Resources.dart';

class Profile_Model {
  User_Profile_Data ? user_profile_data ;

  Profile_Model.fromjson ( Map <String , dynamic> json ) {
    if ( json != null ) {
      user_profile_data = User_Profile_Data.fromjson(json['user']) ;
      if ( json ['user property'] != null ){
        for (var element in json['user property'] ){
              user_property.add(User_Property.fromjson(element,{
                'ownername' : json['user']['name'],
                'ownerid' : json['user']['id'],
                'ownerimage' : json['user']['image']
              }));
        }
      }
    }
  }
}

class User_Profile_Data {
  var id ;
  var name ;
  var email ;
  var phone ;
  var age ;
  var gender ;
  var info ;
  var created_at ;
  var updated_at ;
  var image ;

  User_Profile_Data.fromjson ( Map <String , dynamic > json ) {
    id = json['id'] ;
    name = json ['name'] ;
    email = json ['email'] ;
    phone = json ['phone'] ;
    age = json ['age'] ;
    gender = json ['gender'] ;
    info = json ['information_about'] ;
    created_at = json ['created_at'] ;
    updated_at = json['updated_at'] ;
    if ( json['image'] != null ){
       image = json['image'][0] ;
    }
  }
}

class User_Property {
  var ownerimage ;
  var ownername ;
  var ownerid ;

  var property_id ;
  var typeofproperty ;
  var rent_or_sell ;
  var namestate ;
  var address ;
  var area ;
  var numberofRooms ;
  var numberofBaths ;
  var descreption ;
  var price ;
  var ownerRate ;
  var monthlyRent ;
  List <String> image = [] ;


  User_Property.fromjson ( Map <String , dynamic > json , Map <String , dynamic> ownerData) {
    ownerimage = ownerData['ownerimage'];
    ownername = ownerData['ownername'];
    ownerid = ownerData['ownerid'];

    property_id = json['property']['id'] ;
    ownerRate = json['myRate'] ;
    typeofproperty = json ['property']['typeofproperty'] ;
    rent_or_sell = json ['property']['rent_or_sell'] ;
    namestate = json['state']['nameState'] ;
    address = json ['location']['address'] ;
    area = json ['property']['area'] ;
    numberofRooms = json ['property']['numberofRooms'] ;
    numberofBaths = json ['property']['bathRoom'] ;
    descreption = json ['property']['descreption'] ;
    price = json ['property']['price'] ;
    monthlyRent = json['property']['monthlyRent'];
    if ( json['property']['image'] != null ){
      for (String element in json['property']['image']){
        image.add(element) ;
      }
    }
  }
}