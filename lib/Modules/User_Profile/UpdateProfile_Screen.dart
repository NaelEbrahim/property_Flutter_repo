// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable
import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Base_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

class UpdateProfile_Screen extends StatelessWidget {
  UpdateProfile_Screen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var information_aboutController = TextEditingController();
  var ageconrtoller = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    Map <String ,dynamic> updateData = {} ;
    return BlocProvider(
        create: (context) => MyBloc(),
      child: BlocConsumer<MyBloc,Bloc_States>(
        listener: (context, state) {
          if ( state is SuccessUpdateUserProfile ){
            Fluttertoast.showToast(
                msg: 'Successfuly Profile Updated',
                toastLength:
                Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 6,
                backgroundColor:
                Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Base_Screen()),(route) => false,);
          }
        } ,
        builder: (context, state) {
          var cubit = MyBloc.get(context);
          return Scaffold(
            backgroundColor: ScaffoldColorLight,
            appBar: AppBar(
              backgroundColor: myAppColorLight,
              title: reusableText(
                  text: 'Edit Profile',
                  fontsize: 19.0,
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.white
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          cubit.changeimage(context);
                        },
                        child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                  backgroundImage:
                                  (cubit.imagepath == null) ? const AssetImage('images/inisital_image.png') : Image.file(File(cubit.imagepath)).image,
                                  backgroundColor: Colors.grey,
                                  radius: 80.0),
                               CircleAvatar(
                                radius: 17.0,
                                backgroundColor: myAppColorLight,
                                child:
                                const Icon(Icons.add, color: Colors.white),
                              )
                            ])),
                    const SizedBox(height:15.0),
                    reusableText(
                        text: 'New Personal Photo',
                        fontsize: 15.0,
                        fontColor: secondryTextColorLight,
                        fontWeight: FontWeight.w500
                    ),
                    const SizedBox(height: 40.0),
                    reusableTextField(
                        hintText: 'New Name',
                        prefixIcon: const Icon(Icons.person_outline),
                        controller: nameController,
                        raduis: 25.0),
                    const SizedBox(height: 30.0),
                    reusableTextField(
                        hintText: 'New Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                        raduis: 25.0),
                    const SizedBox(height: 30.0),
                    reusableTextField(
                        hintText: 'New Phone',
                        prefixIcon: const Icon(Icons.phone_android_outlined),
                        textInputType: TextInputType.phone,
                        controller: phoneController,
                        raduis: 25.0),
                    const SizedBox(height: 30.0),
                    reusableTextField(
                        hintText: 'New Age',
                        prefixIcon: const Icon(Icons.numbers),
                        textInputType: TextInputType.phone,
                        controller: ageconrtoller,
                        raduis: 25.0),
                    const SizedBox(height: 30.0),
                    reusableTextField(
                        hintText: 'New Info About You',
                        prefixIcon: const Icon(Icons.info_outline),
                        controller: information_aboutController,
                        raduis: 25.0),
                    const SizedBox(height: 30.0),
                    ConditionalBuilder(
                      condition: state is! LoadingUpdateUserProfile,
                      builder: (context) => Container(
                        width: 220.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: myAppColorLight),
                        child: reusableTextButton(
                            context: context,
                            buttontext: 'UPDATE',
                            function: () async {
                              if( nameController.text.isNotEmpty ){
                                updateData['name'] = nameController.text;
                              }
                              if( emailController.text.isNotEmpty ){
                                updateData['email'] = emailController.text;
                              }
                              if( phoneController.text.isNotEmpty ){
                                updateData['phone'] = phoneController.text;
                              }
                              if( ageconrtoller.text.isNotEmpty ){
                                updateData['age'] = ageconrtoller.text ;
                              }
                              if( information_aboutController.text.isNotEmpty ){
                                updateData['information_about'] = information_aboutController.text;
                              }

                              if ( cubit.imagepath != null ) {
                                updateData['image[]'] = [await MultipartFile.fromFile(
                                  cubit.imagepath,
                                  filename: cubit.imagepath
                                )];
                              } // Wait Fix Backend

                              if ( updateData.isNotEmpty ) {
                                cubit.UpdateUserProfile(
                                    FormData.fromMap(updateData)
                                );
                              }else {
                                Fluttertoast.showToast(
                                    msg: 'Please make sure to fill One At least of the information',
                                    toastLength:
                                    Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            },
                            fontSize: 22.0,
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
