import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/responsive/walkthrough_screen_layout.dart';
import 'package:sucial/screens/add_post_screen.dart';
import 'package:sucial/screens/login_screen.dart';
import 'package:sucial/screens/profile_view_screen.dart';
import 'package:sucial/screens/signup_screen.dart';
import 'package:sucial/screens/edit_profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucial/utils/GoogleProvider.dart';
import 'package:sucial/utils/PartialRouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => GoogleProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SUcial',
      theme: ThemeData.dark(),
      home: WalkthroughScreenLayout(),
      routes: {
        SignupScreen.routeName: (context) => SignupScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ProfileView.routeName: (context) => ProfileView(),
        MobileScreenLayout.routeName: (context) => MobileScreenLayout(),
        EditProfileScreen.routeName: (context) => EditProfileScreen(),
        AddPostScreen.routeName: (context) => AddPostScreen(),
        '/router': (context) => partialRouter(),
      },
    ),
  ));
}
