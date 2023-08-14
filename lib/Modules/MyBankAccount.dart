// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Shared_Preferences.dart';

class MyBankAccount extends StatelessWidget {
  MyBankAccount({Key? key}) : super(key: key);

  var accountnumerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBloc()..GetMyBankAccount(),
      child: BlocConsumer <MyBloc,Bloc_States> (
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MyBloc.get(context);
          return  Scaffold(
                backgroundColor: ScaffoldColor,
                appBar: AppBar(
                  backgroundColor: myAppColor,
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  title: reusableText(
                      text: 'My Bank Account',
                      fontsize: 19,
                      fontColor: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                  centerTitle: true,
                ),
                body: Center(
                  child: ConditionalBuilder(
                      condition: cubit.getMyBankAccount_model != null ,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.green,
                              size: 120.0,
                            ),
                            const SizedBox(height: 40.0),
                            if ( sharedPreferences.getBankAccount() == null )
                              Column(
                                children: [
                                  reusableText(
                                      text: 'You Don\'t Have A Bank Account',
                                      fontsize: 18.0,
                                      //fontColor: Colors.black45,
                                      fontWeight: FontWeight.bold
                                  ),
                                ],
                              ),
                            if ( sharedPreferences.getBankAccount() != null )
                              Column(
                                children: [
                                  reusableText(
                                      text: 'Your Bank Account',
                                      fontsize: 18.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                  const SizedBox(height: 30.0),
                                  Container(
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.credit_card),
                                          const SizedBox(width: 20.0),
                                          reusableText(
                                              text: 'ID :',
                                              fontsize: 14.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          const SizedBox(width: 10.0),
                                          reusableText(
                                              text: cubit.getMyBankAccount_model!.number_account.toString(),
                                              fontsize: 14.0,
                                              fontWeight: FontWeight.bold
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  Container(
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.monetization_on),
                                          const SizedBox(width: 20.0),
                                          reusableText(
                                              text: 'Balance :',
                                              fontsize: 14.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                          const SizedBox(width: 10.0),
                                          reusableText(
                                              text: '\$ ${cubit.getMyBankAccount_model!.value_of_account.toString()}',
                                              fontsize: 14.0,
                                              fontWeight: FontWeight.bold
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ),
                      fallback: (context) => const CircularProgressIndicator()
                  )
                ),
              );
        },
      ),
    );
  }
}
