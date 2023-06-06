import 'package:flutter/material.dart';
import 'package:university_project_property_app/Shared/Components.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: reusableText(text: "Profile_Screen", fontsize: 25.0),
    );
  }
}
