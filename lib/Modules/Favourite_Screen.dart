// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Bloc/Bloc_States.dart';
import 'package:university_project_property_app/Models/ShowFavorite_Model.dart';
import 'package:university_project_property_app/Modules/Base_Screen.dart';
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
        return ConditionalBuilder(
          condition: cubit.showFavorite_Model != null,
          builder: (context) =>
          (cubit.showFavorite_Model!.favorites.isNotEmpty)
              ? SingleChildScrollView(
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
                          BuildCard(
                              cubit.showFavorite_Model!.favorites[index],
                              context),
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 10.0),
                      itemCount: cubit.showFavorite_Model!.favorites.length),
                ],
              ),
            ),
          )
              : Center(
                child: Image.asset('images/noresult.png',
                height: 200.0, width: 200.0),
              ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  BuildCard(PropertyFavorite item, BuildContext context) {
    var cubit = MyBloc.get(context);
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: containerBackgroundColor,
          borderRadius: BorderRadius.circular(10.0)),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 140,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            (item.image.isNotEmpty)
                ? item.image[0]
                : 'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg',
            width: MediaQuery
                .of(context)
                .size
                .width * 0.3,
            height: 140,
            fit: BoxFit.fill,
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
                    text: (item.rent_or_sell == 'sell') ? '\$${item.price
                        .toString()}' :
                    '\$${item.monthlyRent.toString()}/Month',
                    fontsize: 20,
                    fontColor: primaryTextColorLight,
                    fontWeight: FontWeight.bold),
                Container(
                  width: 100,
                  height: 25,
                  decoration: BoxDecoration(
                    color: myAppColorLight,
                    borderRadius: const BorderRadius.all(
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
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Property_Details(item)));
                          })),
                ),
                reusableText(
                    maxLines: 1,
                    text: item.address.toString(),
                    fontsize: 14,
                    fontWeight: FontWeight.w400,
                    fontColor: secondryTextColorLight
                ),
                Row(
                  children: [
                    Icon(Icons.bed_outlined, color: primaryTextColorLight),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                        text: item.numberofRooms.toString(),
                        fontsize: 13,
                        fontColor: primaryTextColorLight
                    ),
                    const Spacer(),
                    Icon(Icons.bathtub_outlined, color: primaryTextColorLight),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(
                        text: item.numberofBaths.toString(),
                        fontsize: 13,
                        fontColor: primaryTextColorLight
                    ),
                    const Spacer(),
                    Icon(Icons.area_chart_outlined,
                        color: primaryTextColorLight),
                    const SizedBox(
                      width: 5,
                    ),
                    reusableText(text: item.area.toString(),
                        fontsize: 13,
                        fontColor: primaryTextColorLight
                    )
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              cubit.DeleteFavorite(item.id).then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Base_Screen()), (route) => false);
              });
            },
            icon: const Icon(Icons.delete, size: 27.0, color: Colors.red),
            padding: const EdgeInsets.all(8.0),
          )
        ],
      ),
    );
  }
}
