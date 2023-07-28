// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Models/Home_Model.dart';
import 'package:university_project_property_app/Modules/Property_Details.dart';
import 'package:university_project_property_app/Shared/Components.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Resources.dart';

class Favourite_Screen extends StatelessWidget {
  const Favourite_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyBloc, Bloc_States>(
      listener: (context, state) => {},
      builder: (context, state) {
        baseScreenContext = context;
        var cubit = MyBloc.get(context);
        return Center(
          child: ConditionalBuilder(
            condition: cubit.home_model != null,
            builder: (context) => (cubit.home_model!.propertylist.isNotEmpty) ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            BuildCard(cubit.home_model!.propertylist[index],
                                context),
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 10.0),
                        itemCount: 10
                    ),
                  ],
                ),
              ),
            ) : Image.asset('images/noresult.png', height: 200.0, width: 200.0),
            fallback: (context) => const CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  BuildCard(PropertyModel item, BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
      ),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'images/house_test.jpg',
            width: MediaQuery
                .of(context)
                .size
                .width * 0.3,
            height: 140,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText(
                    text: '\$${item.price.toString()}',
                    fontsize: 20,
                    fontColor: myAppColor,
                    fontWeight: FontWeight.bold
                ),
                Container(
                  width: 100,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: myAppColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                      child: reusableTextButton(
                          context: context,
                          buttontext: 'View',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.white,
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    Property_Details(item))
                            );
                          }
                      )
                  ),
                ),
                reusableText(
                  maxLines: 1,
                  text: item.address.toString(),
                  fontsize: 14,
                  fontWeight: FontWeight.w200,
                  fontColor: Colors.grey,
                ),
                Row(
                  children: [
                    const Icon(Icons.bed),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                        text: item.numberofRooms.toString(), fontsize: 13),

                    const Spacer(),

                    const Icon(Icons.bathtub_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                        text: item.numberofBaths.toString(), fontsize: 13),

                    const Spacer(),

                    const Icon(Icons.area_chart_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(text: item.area.toString(), fontsize: 13)
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
                Icons.favorite,
                size: 27.0,
                color: Colors.red
            ),
            padding: const EdgeInsets.all(8.0),
          )
        ],
      ),
    );
  }
}
