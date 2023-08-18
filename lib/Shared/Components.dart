// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:university_project_property_app/Bloc/Bloc.dart';
import 'package:university_project_property_app/Modules/Add_Property/Add_Property.dart';
import 'package:university_project_property_app/Modules/Chatting/Chat_Screen.dart';
import 'package:university_project_property_app/Modules/Login_Screen.dart';
import 'package:university_project_property_app/Modules/MyBankAccount.dart';
import 'package:university_project_property_app/Modules/MyPublications_Screen.dart';
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
        Color fontColor = Colors.black45,//myAppColorLight,
        int maxlines = 1,
        Color focuseColor = Colors.black,//myAppColorLight,
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [myAppColorLight, containerBackgroundColor],
          stops: const [0.24, 0.2],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Container(
            padding: const EdgeInsetsDirectional.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                reusableText(
                    text: "Hello!",
                    fontWeight: FontWeight.bold,
                    fontColor: Colors.white,
                    fontsize: 40.0),
                const SizedBox(height: 25.0),
                if ( sharedPreferences.getUserData() != null )
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
                  leading:  Icon(Icons.monetization_on, color: secondryTextColorLight),
                  title: reusableText(
                      text: "My Bank Account",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontColor: primaryTextColorLight
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyBankAccount()));
                  },
                ),
                ListTile(
                  leading:  Icon(Icons.post_add_outlined, color: secondryTextColorLight),
                  title: reusableText(
                      text: "My Publications",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontColor: primaryTextColorLight
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyPublications_Screen()));
                  },
                ),
                ListTile(
                  leading:  Icon(Icons.add_circle_outlined, color: secondryTextColorLight),
                  title: reusableText(
                      text: "Add Property",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontColor: primaryTextColorLight
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Property()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.dark_mode_outlined, color: secondryTextColorLight),
                  title: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    tileColor: containerBackgroundColor,
                    title : reusableText(
                        text: 'Dark Mode',
                        fontsize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontColor: primaryTextColorLight
                    ),
                    value: MyBloc.get(context).isDark,
                    onChanged: (value){
                      MyBloc.get(context).ChangeAppTheme();
                    },
                    //secondary: ,
                  ),
                ),
                ListTile(
                  leading:  Icon(Icons.chat_outlined, color: secondryTextColorLight),
                  title: reusableText(
                      text: "My Chats",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontColor: primaryTextColorLight
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Chat_Screen()));
                  },
                ),
                ListTile(
                  leading:  Icon(Icons.logout, color: secondryTextColorLight),
                  title: reusableText(
                      text: "Logout",
                      fontsize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontColor: primaryTextColorLight
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    MyBloc.get(context).Logout(sharedPreferences.getData('token')).then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login_Screen()),(route)=>false);
                    });
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
