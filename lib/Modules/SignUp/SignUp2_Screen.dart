// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable

import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Login_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

class SignUp2_Screen extends StatelessWidget {
  SignUp2_Screen({Key? key}) : super(key: key);

  final List<String> gender_items = ['Male', 'Female'];
  String ? selectedgender;

  final List<int> age_items = [for (int i = 18; i <= 100; i++) i];
  int ? selectedAge;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <MyBloc , Bloc_States>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MyBloc.get(context);
        return Column(
          children: [
            const SizedBox(height: 20.0),
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
                text: 'Personal Photo',
                fontsize: 15.0,
                fontColor: secondryTextColorLight,
                fontWeight: FontWeight.w500
            ),
            const SizedBox(height: 50.0),
            Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children:  [
                         Icon(
                          Icons.list,
                          size: 16,
                          color: primaryTextColorLight,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Select Gender',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColorLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    items: gender_items.map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColorLight,
                        ),
                      ),
                    )).toList(),
                    value: selectedgender,
                    onChanged: (value) {
                      selectedgender = value as String;
                      cubit.ChangeState();
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 170,
                      padding: const EdgeInsets.only(
                          left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: secondryTextColorLight,
                        ),
                        color: containerBackgroundColor,
                      ),
                      elevation: 1,
                    ),
                    iconStyleData: IconStyleData(
                      icon: const Icon(
                        Icons.arrow_drop_down_outlined,
                      ),
                      iconSize: 22,
                      iconEnabledColor: primaryTextColorLight,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      //maxHeight: 200,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: containerBackgroundColor,
                      ),
                      scrollbarTheme: const ScrollbarThemeData(
                        radius: Radius.circular(40),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding:
                      EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                const Spacer(),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children:  [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: primaryTextColorLight,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            'Select Age',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColorLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    items: age_items
                        .map((item) => DropdownMenuItem<int>(
                      value: item,
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColorLight,
                        ),
                      ),
                    ))
                        .toList(),
                    value: selectedAge,
                    onChanged: (value) {
                      selectedAge = value as int;
                      cubit.ChangeState();
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 160,
                      padding: const EdgeInsets.only(
                          left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: secondryTextColorLight,
                        ),
                        color: containerBackgroundColor,
                      ),
                      elevation: 1,
                    ),
                    iconStyleData: IconStyleData(
                      icon: const Icon(
                        Icons.arrow_drop_down_outlined,
                      ),
                      iconSize: 22,
                      iconEnabledColor: primaryTextColorLight,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 130,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: containerBackgroundColor,
                      ),
                      scrollbarTheme: const ScrollbarThemeData(
                        radius: Radius.circular(40),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40.0),
            ConditionalBuilder(
              condition: state is! LoadingSignupState,
              builder: (context) => Container(
                width: 220.0,
                height: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: myAppColorLight),
                child: reusableTextButton(
                    context: context,
                    buttontext: 'CREATE',
                    function: () async {
                       if ( selectedAge != null && selectedgender != null ) {
                        cubit.Signup(
                            FormData.fromMap({
                              'name': signup_data['name'],
                              'email': signup_data['email'],
                              'password': signup_data['password'],
                              'phone': signup_data['phone'],
                              'information_about': signup_data['information_about'],
                              'age': selectedAge.toString(),
                              'gender': selectedgender.toString(),
                              'image[]' : [ await MultipartFile.fromFile(
                                  cubit.imagepath,
                                  filename: cubit.imagepath
                              )]
                            })
                        );
                       }else {
                         Fluttertoast.showToast(
                             msg: 'Please make sure to fill all the information',
                             toastLength:
                             Toast.LENGTH_SHORT,
                             gravity: ToastGravity.BOTTOM,
                             timeInSecForIosWeb: 2,
                             backgroundColor:
                             Colors.red,
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
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                reusableText(
                  text: 'Already Have An Account?',
                  fontsize: 15,
                  fontColor: primaryTextColorLight
                ),
                reusableTextButton(
                    context: context,
                    buttontext: 'Login',
                    textColor: myAppColorLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    function: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login_Screen()),
                              (route) => false);
                    })
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        );
      },
    );
  }
}
