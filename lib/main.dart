import 'package:flutter/material.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/responsive/responsive_layout_screen.dart';
import 'package:sucial/responsive/walkthrough_screen_layout.dart';
import 'package:sucial/screens/add_post_screen.dart';
import 'package:sucial/screens/login_screen.dart';
import 'package:sucial/screens/profile_view_screen.dart';
import 'package:sucial/screens/signup_screen.dart';
import 'package:sucial/screens/welcome_screen.dart';
import 'package:sucial/screens/edit_profile_screen.dart';
import 'package:sucial/screens/add_post_screen.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SUcial',
    theme: ThemeData.dark(),
    initialRoute: '/',
    routes: {
      //'/': (context) => WalkthroughScreenLayout(),
      '/': (context) => const Welcome(),
      SignupScreen.routeName: (context) => SignupScreen(),
      LoginScreen.routeName: (context) => LoginScreen(),
      ProfileView.routeName: (context) => ProfileView(),
      MobileScreenLayout.routeName: (context) => MobileScreenLayout(),

      EditProfileScreen.routeName: (context) => EditProfileScreen(),
      AddPostScreen.routeName: (context) => AddPostScreen(),
    },
  ));
}
