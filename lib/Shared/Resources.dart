// ignore_for_file: non_constant_identifier_names, file_names
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Resources
List <XFile> FileToimages = [];
late Map <String , dynamic> signup_data ;

BuildContext ? baseScreenContext ;
BuildContext ? searchScreenContext ;


// Some Converts
List <String> base64Strings = [];
Future < List <String> > xFilesToBase64 ( List <XFile> xFiles ) async {
  for ( XFile xFile in xFiles ) {
    Uint8List bytes = await xFile.readAsBytes();
    String base64String = base64Encode(bytes);
    base64Strings.add(base64String);
  }
  return base64Strings;
}

