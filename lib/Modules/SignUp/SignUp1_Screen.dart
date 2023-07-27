// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

class SignUp1_Screen extends StatelessWidget {
  SignUp1_Screen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var information_aboutController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyBloc, Bloc_States>(
      listener: (context, state) => () {},
      builder: (context, state) {
        var cubit = MyBloc.get(context);
        return Form(
          key: formkey,
          child: Column(
            children: [
              const Image(
                image: AssetImage('images/sign_up.png'),
                fit: BoxFit.contain,
                height: 150,
                width: 230,
              ),
              reusableText(
                  text: 'Let\'s Get Started!',
                  fontsize: 26,
                  fontWeight: FontWeight.w700),
              reusableText(
                  text: 'Create A New Account',
                  fontsize: 16,
                  fontColor: Colors.grey,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 40.0),
              reusableTextField(
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  controller: nameController,
                  raduis: 25.0),
              const SizedBox(height: 30.0),
              reusableTextField(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                  raduis: 25.0),
              const SizedBox(height: 30.0),
              reusableTextField(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: cubit.eyeIcon,
                  textInputType: TextInputType.visiblePassword,
                  suffixfunction: () {
                    cubit.ChangeEye();
                  },
                  obscureText: cubit.eyeVisible,
                  controller: passwordController,
                  raduis: 25.0),
              const SizedBox(height: 30.0),
              reusableTextField(
                  hintText: 'Phone',
                  prefixIcon: const Icon(Icons.phone_android_outlined),
                  textInputType: TextInputType.phone,
                  controller: phoneController,
                  raduis: 25.0),
              const SizedBox(height: 30.0),
              reusableTextField(
                  hintText: 'Info About You',
                  prefixIcon: const Icon(Icons.info_outline),
                  controller: information_aboutController,
                  raduis: 25.0),
              const SizedBox(height: 30.0),
              Container(
                width: 220.0,
                height: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: myAppColor),
                child: reusableTextButton(
                    context: context,
                    buttontext: 'Next',
                    function: () async {
                      if (formkey.currentState!.validate()) {
                        signup_data = {
                          'name': nameController.text,
                          'email': emailController.text,
                          'password': passwordController.text,
                          'phone': phoneController.text,
                          'information_about': information_aboutController.text,
                        };
                        cubit.ChangePropertyCategory(1);
                      }
                    },
                    fontSize: 22.0,
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}