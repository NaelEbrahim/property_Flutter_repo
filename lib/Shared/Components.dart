import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Modules/Add_Property/Add_Property.dart';
import 'package:university_project_property_app/Modules/Login_Screen.dart';
import 'package:university_project_property_app/Shared/Constant.dart';
import 'package:university_project_property_app/Shared/Shared_Preferences.dart';

Widget reusableText(
        {required String text,
        required double fontsize,
        int maxLines = 5,
        FontWeight fontWeight = FontWeight.normal,
        Color fontColor = Colors.black,
        bool linethrough = false,
        TextAlign align = TextAlign.start}) =>
    Text(
      text,
      maxLines: maxLines,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
          fontWeight: fontWeight,
          fontSize: fontsize,
          color: fontColor,
          decoration:
              (linethrough) ? TextDecoration.lineThrough : TextDecoration.none),
    );

Widget reusableTextField(
        {required String hintText,
        required Icon prefixIcon,
        TextStyle? hintstyle,
        IconData? suffixIcon,
        void Function()? suffixfunction,
        required TextEditingController controller,
        bool obscureText = false,
        double raduis = 0.0,
        Color fontColor = myAppColor,
        int maxlines = 1,
        Color focuseColor = myAppColor,
        TextInputType textInputType = TextInputType.text,
        String? Function(String?)? validator}) =>
    TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      maxLines: maxlines,
      style: TextStyle(color: fontColor, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis),
          borderSide: BorderSide(color: focuseColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis),
          borderSide: const BorderSide(color: Colors.red),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: (suffixIcon != null)
            ? IconButton(
                onPressed: suffixfunction,
                icon: Icon(suffixIcon),
              )
            : null,
        hintText: hintText,
        hintStyle: hintstyle ?? GoogleFonts.raleway(color: Colors.black),
        prefixIconColor: Colors.black,
        suffixIconColor: Colors.black,
      ),
      validator: (validator == null ) ? (value) {
        if (value!.isEmpty) {
          return 'must\'t be empty';
        }
        return null;
      } : validator,
    );

Widget reusableTextButton(
        {required BuildContext context,
        required String buttontext,
        required Function() function,
        Color textColor = Colors.black,
        double fontSize = 20.0,
        FontWeight fontWeight = FontWeight.normal}) =>
    TextButton(
        onPressed: function,
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero)
        ),
        child: reusableText(
            text: buttontext,
            fontsize: fontSize,
            fontColor: textColor,
            fontWeight: fontWeight));

Widget opendrawer(BuildContext context) {
  return Drawer(
    width: 300,
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [myAppColor, Colors.white],
          stops: [0.24, 0.2],
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsetsDirectional.only(top: 50.0, start: 90.0),
            child: Column(
              children: [
                reusableText(
                    text: "Hello!",
                    fontWeight: FontWeight.bold,
                    fontColor: Colors.white,
                    fontsize: 40.0),
                const SizedBox(height: 25.0),
                reusableText(
                    text: sharedPreferences.getUserData()['user_name'].toString().toUpperCase(),
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontsize: 22.0),
              ],
            )),
        Container(
          padding: const EdgeInsetsDirectional.only(
            top: 10.0,
          ),
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                ListTile(
                  leading: const Icon(Icons.add_circle_outlined, color: myAppColor),
                  title: reusableText(
                      text: "Add Property",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Property()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on, color: myAppColor),
                  title: reusableText(
                      text: "My Balancs",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold),
                  onTap: () {
                    //  _Showdialog(context);
                    // print(sharedhelper.getCurrentExpertData()['expert_name']);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: myAppColor),
                  title: reusableText(
                      text: "Settings",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold),
                  onTap: () {
                    Navigator.pop(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => expert_schedules()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: myAppColor),
                  title: reusableText(
                      text: "Logout",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold),
                  onTap: () {
                    MyBloc.get(context)
                        .Logout(sharedPreferences.getData('token'));
                    sharedPreferences.logout();
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login_Screen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    ),
  );
}
