// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:university_project_property_app/Shared/Components.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    search.addListener(() {});
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  List img = [
    'images/tierra-mallorca-rgJ1J8SDEAY-unsplash.jpg',
    'images/tierra-mallorca-rgJ1J8SDEAY-unsplash.jpg',
    'images/tierra-mallorca-rgJ1J8SDEAY-unsplash.jpg',
  ];

  card(double prize, String loc, int bedcount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.93,
        height: 140,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'images/tierra-mallorca-rgJ1J8SDEAY-unsplash.jpg',
                width: MediaQuery.of(context).size.width * 0.3,
                height: 130,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(
                    text: '\$${prize.toString()}',
                    fontsize: 20,
                    fontColor: Colors.blue,
                  ),
                  Container(
                    width: 100,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'View',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  reusableText(
                    text: loc,
                    fontsize: 14,
                    fontWeight: FontWeight.w200,
                    fontColor: Colors.grey,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'images/87-870480_related-wallpapers-bed-icon-png.png',
                        width: 20,
                        height: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(bedcount.toString()),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        // title:
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            reusableText(
              text: 'Current Location',
              fontsize: 14,
              fontWeight: FontWeight.w200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                ),
                reusableText(text: 'Syria - Damascus', fontsize: 16),
              ],
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.filter_alt_outlined,
              color: Colors.black,
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  reusableTextField(
                    hintText: 'Search For Dream House',
                    hintstyle: const TextStyle(fontWeight: FontWeight.w200),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black26,
                    ),
                    controller: search,
                  ),
                  CarouselSlider.builder(
                    itemCount: img.length,
                    itemBuilder: (context, index, l) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          height: 200,
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
                      );
                    },
                    options: CarouselOptions(
                      height: 150,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      //reverse: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return card(250000, 'Syria - Damascus - Al Amin', 4);
                    },
                    itemCount: 5,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width * 0.06,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.88,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 28,
                    ),
                    Icon(
                      Icons.category_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                      size: 28,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
