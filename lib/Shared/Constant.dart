// ignore_for_file: file_names, non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

// Colors For App UI
 Color myAppColorLight = const Color(0xff052d5d);

  MaterialColor MaterialMyAppColor1 = MaterialColor(myAppColorLight.value,{
    50:  myAppColorLight.withOpacity(0.1),
    100: myAppColorLight.withOpacity(0.2),
    200: myAppColorLight.withOpacity(0.3),
    300: myAppColorLight.withOpacity(0.4),
    400: myAppColorLight.withOpacity(0.5),
    500: myAppColorLight.withOpacity(0.6),
    600: myAppColorLight.withOpacity(0.7),
    700: myAppColorLight.withOpacity(0.8),
    800: myAppColorLight.withOpacity(0.9),
    900: myAppColorLight.withOpacity(1.0),
  });

Color ScaffoldColorLight = Colors.grey[200]!;

Color containerBackgroundColor = Colors.white ;

Color primaryTextColorLight = Colors.black ;

Color secondryTextColorLight = Colors.black45 ;