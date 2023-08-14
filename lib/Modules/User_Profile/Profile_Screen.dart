// ignore_for_file: camel_case_types, file_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyBloc , Bloc_States>(
      listener: (context, state) {},
        builder: (context, state) {
          baseScreenContext = context ;
          var cubit = MyBloc.get(context);
        return ConditionalBuilder(
            condition: cubit.profile_model != null ,
            builder: (context) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [myAppColor, ScaffoldColor],
                    stops: const [0.2, 0.2],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0,left: 130.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 85,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 80.0,
                              backgroundImage: Image.network(cubit.profile_model!.user_profile_data!.image).image,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Column(
                            children: [
                              reusableText(text: cubit.profile_model!.user_profile_data!.name.toString().toUpperCase(), fontsize: 18.0,fontWeight: FontWeight.bold),
                              const SizedBox(height: 3.0),
                              reusableText(text: 'USER', fontsize: 13.0,fontWeight: FontWeight.bold,fontColor: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText(text: 'Name', fontsize: 20,fontWeight : FontWeight.bold , fontColor: myAppColor),
                          const SizedBox(height: 5.0),
                          reusableText(text: cubit.profile_model!.user_profile_data!.name, fontsize: 16.0,fontWeight: FontWeight.bold),
                          const SizedBox(height: 5.0),
                          const Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                          const SizedBox(height: 5.0),

                          reusableText(text: 'Emial', fontsize: 20,fontWeight : FontWeight.bold , fontColor: myAppColor),
                          const SizedBox(height: 5.0),
                          reusableText(text: cubit.profile_model!.user_profile_data!.email, fontsize: 16.0,fontWeight: FontWeight.bold),
                          const SizedBox(height: 5.0),
                          const Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                          const SizedBox(height: 5.0),

                          reusableText(text: 'Age', fontsize: 20,fontWeight : FontWeight.bold , fontColor: myAppColor),
                          const SizedBox(height: 5.0),
                          reusableText(text: cubit.profile_model!.user_profile_data!.age.toString(), fontsize: 16.0,fontWeight: FontWeight.bold),
                          const SizedBox(height: 5.0),
                          const Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                          const SizedBox(height: 5.0),

                          reusableText(text: 'Gender', fontsize: 20,fontWeight : FontWeight.bold , fontColor: myAppColor),
                          const SizedBox(height: 5.0),
                          reusableText(text: cubit.profile_model!.user_profile_data!.gender, fontsize: 16.0,fontWeight: FontWeight.bold),
                          const SizedBox(height: 5.0),
                          const Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                          const SizedBox(height: 5.0),

                          reusableText(text: 'Phone', fontsize: 20,fontWeight : FontWeight.bold , fontColor: myAppColor),
                          const SizedBox(height: 5.0),
                          reusableText(text: '0${cubit.profile_model!.user_profile_data!.phone}', fontsize: 16.0,fontWeight: FontWeight.bold),
                          const SizedBox(height: 5.0),
                          const Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                          const SizedBox(height: 5.0),

                          reusableText(text: 'Info', fontsize: 20,fontWeight : FontWeight.bold , fontColor: myAppColor),
                          const SizedBox(height: 5.0),
                          reusableText(text: cubit.profile_model!.user_profile_data!.info, fontsize: 16.0,fontWeight: FontWeight.bold),
                          const SizedBox(height: 5.0),
                          const Divider(
                            color: Colors.black26,
                            thickness: 2,
                          ),
                          const SizedBox(height: 5.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
