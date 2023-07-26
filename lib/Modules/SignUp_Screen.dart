// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, file_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Modules/Login_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';

class SignUp_Screen extends StatelessWidget {
  SignUp_Screen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var information_aboutController = TextEditingController();
  var ageController = TextEditingController();

  final List<String> gender_items = ['Male', 'Female'];
  String? selectedgender;

  final List<int> age_items = [for (int i = 18; i <= 100; i++) i];
  int? selectedAge;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBloc(),
      child: BlocConsumer<MyBloc, Bloc_States>(
        listener: (context, state) => () {},
        builder: (context, state) {
          var bloc = MyBloc.get(context);
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 30.0, right: 30.0),
                      width: double.infinity,
                      child: Form(
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
                                raduis: 25.0
                            ),
                            const SizedBox(height: 30.0),
                            reusableTextField(
                                hintText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                textInputType: TextInputType.emailAddress,
                                controller: emailController,
                                raduis: 25.0
                            ),
                            const SizedBox(height: 30.0),
                            reusableTextField(
                                hintText: 'Phone',
                                prefixIcon: const Icon(Icons.phone_android_outlined),
                                textInputType: TextInputType.phone,
                                controller: phoneController,
                                raduis: 25.0
                            ),
                            const SizedBox(height: 30.0),
                            reusableTextField(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: bloc.eyeIcon,
                                textInputType: TextInputType.visiblePassword,
                                suffixfunction: () {
                                  bloc.ChangeEye();
                                },
                                obscureText: bloc.eyeVisible,
                                controller: passwordController,
                                raduis: 25.0
                            ),
                            const SizedBox(height: 30.0),
                            reusableTextField(
                                hintText: 'Info ( Optional )',
                                prefixIcon: const Icon(Icons.info_outline),
                                controller: information_aboutController,
                                raduis: 25.0),
                            const SizedBox(height: 30.0),
                            Row(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        Icon(
                                          Icons.list,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select Gender',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: gender_items.map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    value: selectedgender,
                                    onChanged: (value) {
                                      selectedgender = value as String;
                                      bloc.ChangeState();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 170,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.white,
                                      ),
                                      elevation: 1,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                      ),
                                      iconSize: 22,
                                      iconEnabledColor: Colors.black,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      //maxHeight: 200,
                                      width: 170,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
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
                                      children: const [
                                        Icon(
                                          Icons.list,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Select Age',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
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
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    value: selectedAge,
                                    onChanged: (value) {
                                      selectedAge = value as int;
                                      bloc.ChangeState();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.white,
                                      ),
                                      elevation: 1,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                      ),
                                      iconSize: 22,
                                      iconEnabledColor: Colors.black,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 130,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
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
                                )
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            ConditionalBuilder(
                              condition: state is! LoadingSignupState,
                              builder: (context) => Container(
                                width: 220.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: myAppColor),
                                child: reusableTextButton(
                                    context: context,
                                    buttontext: 'CREATE',
                                    function: () {
                                      if (formkey.currentState!.validate()) {
                                        bloc.Signup({
                                          'name': nameController.text,
                                          'email': emailController.text,
                                          'password': passwordController.text,
                                          'phone': phoneController.text,
                                          'age': selectedAge,
                                          'gender': selectedgender,
                                          'information_about':
                                          information_aboutController.text,
                                        });
                                      }
                                    },
                                    fontSize: 22.0,
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              fallback: (context) => const Center(child: CircularProgressIndicator()),
                            ),
                            const SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                reusableText(
                                  text: 'Already Have An Account?',
                                  fontsize: 15,
                                ),
                                reusableTextButton(
                                    context: context,
                                    buttontext: 'Login',
                                    textColor: myAppColor,
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
                        ),
                      ),
                    )
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
