// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

AppBar Home_AppBar () => AppBar(
  backgroundColor: myAppColor,
  bottomOpacity: 0.0,
  elevation: 0.0,
  // title:
  centerTitle: true,
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      reusableText(
        text: 'Current Location',
        fontsize: 14,
        fontWeight: FontWeight.w200,
        fontColor: Colors.white
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.blue,
          ),
          reusableText(text: 'Syria - Damascus', fontsize: 16,fontColor: Colors.white),
        ],
      ),
    ],
  ),
  actions: const [
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.filter_alt_outlined,
        color: Colors.white,
      ),
    ),
  ],
  leading: GestureDetector(
    onTap: () {
      // Scaffold.of(context).openDrawer();
    },
    child: const Icon(
      Icons.menu,
      color: Colors.white,
    ),
  ),
);

AppBar Profile_AppBar () => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){},
    icon: const Icon(Icons.arrow_back,color: Colors.white),
  ),
  title: reusableText(
      text: 'Profile',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
);

AppBar Filter_AppBar () => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){},
    icon: const Icon(Icons.arrow_back,color: Colors.white),
  ),
  title: reusableText(
      text: 'Filter',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
);

AppBar Favourite_AppBar () => AppBar(
  backgroundColor: myAppColor,
  leading: IconButton(
    onPressed: (){},
    icon: const Icon(Icons.arrow_back,color: Colors.white),
  ),
  title: reusableText(
      text: 'Favourite',
      fontsize: 19,
      fontColor: Colors.white,
      fontWeight: FontWeight.bold
  ),
  centerTitle: true,
);

