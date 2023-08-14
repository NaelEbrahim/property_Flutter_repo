// ignore_for_file: camel_case_types, file_names

import 'package:university_project_property_app/Shared/Shared_Preferences.dart';

class GetMyChats_Model {
  List mychatsIds = [];

  GetMyChats_Model.fromFireBase ( mychats ){
    mychats.forEach((doc) {
      if( doc.id != sharedPreferences.getUserData()['user_id']) {
        mychatsIds.add(doc.id);
      }
    });
  }
}