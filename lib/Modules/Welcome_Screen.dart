// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:university_project_property_app/Modules/Login_Screen.dart';
import 'package:university_project_property_app/Modules/SignUp_Screen.dart';
import 'package:university_project_property_app/Shared/Components.dart';

class Welcome_Screen extends StatelessWidget {
  const Welcome_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 350,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image.asset(
                  'images/tierra-mallorca-rgJ1J8SDEAY-unsplash.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 280,
            child: reusableText(
              text: 'Discover Dream House from Smartphone !',
              fontsize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 280,
            child: reusableText(
              text: 'Searching and Finding the most Suitable House with you',
              fontsize: 18,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 270.0,
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.black,
            ),
            child: reusableTextButton(
              context: context,
              buttontext: 'Register',
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUp_Screen(),
                  ),
                );
              },
              fontSize: 18.0,
              textColor: Colors.white,
              //fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              reusableText(
                text: 'Don\'t Have An Account?',
                fontsize: 14,
                fontWeight: FontWeight.w300,
              ),
              reusableTextButton(
                context: context,
                buttontext: 'Log In',
                textColor: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login_Screen(),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
