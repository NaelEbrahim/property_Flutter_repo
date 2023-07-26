// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

const Color myAppColor = Color(0xff052d5d);

MaterialColor MaterialMyAppColor = MaterialColor(myAppColor.value, {
  50:  myAppColor.withOpacity(0.1),
  100: myAppColor.withOpacity(0.2),
  200: myAppColor.withOpacity(0.3),
  300: myAppColor.withOpacity(0.4),
  400: myAppColor.withOpacity(0.5),
  500: myAppColor.withOpacity(0.6),
  600: myAppColor.withOpacity(0.7),
  700: myAppColor.withOpacity(0.8),
  800: myAppColor.withOpacity(0.9),
  900: myAppColor.withOpacity(1.0),
});

Color ScaffoldColor =  Colors.grey[200]!;
