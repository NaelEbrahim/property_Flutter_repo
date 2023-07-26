// ignore_for_file: camel_case_types, must_be_immutable, file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Base_Screen.dart';
import 'package:university_project_property_app/Modules/SignUp_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

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
          listener: (context, state) {
          if (state is SuccessLoginState) {
            if ( MyBloc.get(context).login_model!.token != null ) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Base_Screen()));
              Fluttertoast.showToast(
                  msg: 'Welcome  ${MyBloc.get(context).login_model!.user_data!.name.toString().toUpperCase()}',
                  toastLength:
                  Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 2,
                  backgroundColor:
                  Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              }
              else{
              Fluttertoast.showToast(
                    msg: MyBloc.get(context).login_model!.message,
                    toastLength:
                    Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 2,
                    backgroundColor:
                    Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
            }
          },
          builder: (context, state) {
            var bloc = MyBloc.get(context);
            return Scaffold(
              backgroundColor: ScaffoldColor,
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
                            height: 200,
                            width: 200,
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
                              raduis: 25.0 ,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'email must not empty';
                                } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return "invalid email";
                                }
                                return null;
                              }
                          ),
                          const SizedBox(height: 30.0),
                          reusableTextField(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: bloc.eyeIcon,
                              suffixfunction: (){bloc.ChangeEye();},
                              obscureText: bloc.eyeVisible,
                              controller: passwordController,
                              textInputType: TextInputType.visiblePassword,
                              raduis: 25.0
                          ),
                          const SizedBox(height: 50.0),
                          ConditionalBuilder(
                            condition: state is! LoadingLoginState,
                            builder: (context) => Container(
                              width: 220.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: myAppColor
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
                          reusableText(text: 'Or Connect Via', fontsize: 15.0,fontColor: Colors.grey),
                          const SizedBox(height: 20.0),
                          Container(
                            height: 50.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Image.asset('images/googleIcon.ico'),
                                 const SizedBox(width: 10.0),
                                 reusableText(
                                     text: 'Google',
                                     fontsize: 14.0,
                                     fontColor: Colors.white,
                                     fontWeight: FontWeight.bold
                                 )
                               ],
                            )
                          ),
                          const SizedBox(height: 30.0),
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
                                  textColor: myAppColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  function: (){
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUp_Screen()),
                                            (route) => false
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
