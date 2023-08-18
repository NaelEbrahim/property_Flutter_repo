// ignore_for_file: non_constant_identifier_names, file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:university_project_property_app/Models/GetUserProfile_Model.dart';
import 'package:university_project_property_app/Models/Profile_Model.dart';

// Resources
List <XFile> FileToimages = [];
late Map <String , dynamic> signup_data ;

List <GetUserProfile_Model> usersData = [] ;

List <User_Property> user_property = [] ;


BuildContext ? baseScreenContext ;
BuildContext ? searchScreenContext ;



// Some Converts
List images = [] ;
 void xFilesToFiles ( List <XFile> xFiles ) async {
  for ( XFile item in xFiles ) {
    MultipartFile file  = await MultipartFile.fromFile( item.path , filename: item.path ) ;
    images.add(file);
  }
}

