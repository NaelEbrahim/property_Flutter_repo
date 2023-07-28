// ignore_for_file: non_constant_identifier_names, file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Resources
List <XFile> FileToimages = [];
late Map <String , dynamic> signup_data ;

BuildContext ? baseScreenContext ;
BuildContext ? searchScreenContext ;


// Some Converts
List  images = [] ;
 void xFilesToFiles ( List <XFile> xFiles ) async {
  for ( XFile item in xFiles ) {
    MultipartFile file  = await MultipartFile.fromFile( item.path , filename: item.path ) ;
    images.add(file);
  }
}

