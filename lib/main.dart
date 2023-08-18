import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Helper/Dio_Helper.dart';
import 'package:university_project_property_app/Modules/Base_Screen.dart';
import 'package:university_project_property_app/Modules/Login_Screen.dart';
import 'package:university_project_property_app/Shared/BloC_Observer.dart';
import 'package:university_project_property_app/Shared/Shared_Preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  Dio_Helper.init();
  await sharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ( sharedPreferences.getData('token') != null ) ? Base_Screen() : Login_Screen()
    );
  }
}