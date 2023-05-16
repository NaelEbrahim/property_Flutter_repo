import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Helper/Dio_Helper.dart';
import 'package:university_project_property_app/Modules/Login_Screen.dart';
import 'package:university_project_property_app/Shared/BloC_Observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  Dio_Helper.init();
  runApp(const MyApp());
}
//hello gitLab
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBloc(),
      child: BlocConsumer<MyBloc, Bloc_States>(
        listener: (context, state) => () {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.indigo
            ),
            debugShowCheckedModeBanner: false,
            home: Login_Screen(),
          );
        },
      ),
    );
  }
}
