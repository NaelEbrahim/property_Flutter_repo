// ignore_for_file: camel_case_types, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/SignUp_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MyBloc(),
        child: BlocConsumer <MyBloc,Bloc_States>(
          listener: (context, state) => (){},
          builder: (context, state) {
            var bloc = MyBloc.get(context);
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 60.0,left: 20.0,right: 20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('images/login.png'),
                            fit: BoxFit.contain,
                            height: 230,
                            width: 230,
                          ),
                          reusableText(
                              text: 'Welcome Back!',
                              fontsize: 26,
                              fontWeight: FontWeight.w700
                          ),
                          reusableText(
                              text: 'Sign in to Continue',
                              fontsize: 15,
                              fontColor: Colors.grey,
                              fontWeight: FontWeight.w500
                          ),
                          const SizedBox(height: 50.0),
                          reusableTextField(
                              hintText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 30.0),
                          reusableTextField(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: bloc.eyeIcon,
                              suffixfunction: (){bloc.ChangeEye();},
                              obscureText: bloc.eyeVisible,
                              controller: passwordController,
                              textInputType: TextInputType.visiblePassword
                          ),
                          const SizedBox(height: 50.0),
                          ConditionalBuilder(
                            condition: state is! LoadingLoginState,
                            builder: (context) => Container(
                              width: 220.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.indigo
                              ),
                              child: reusableTextButton(
                                  context: context,
                                  buttontext: 'LOG IN',
                                  function: (){
                                    if(formkey.currentState!.validate()) {
                                      bloc.login({
                                      'email' : emailController.text,
                                      'password' : passwordController.text
                                    });
                                    }
                                  },
                                  fontSize: 22.0,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            fallback: (context) => const Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(height: 50.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              reusableText(
                                text: 'Don\'t Have An Account?',
                                fontsize: 15,
                              ),
                              reusableTextButton(
                                  context: context,
                                  buttontext: 'Sign Up',
                                  textColor: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  function: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUp_Screen())
                                    );
                                  }
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
