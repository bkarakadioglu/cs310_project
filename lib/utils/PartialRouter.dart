import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial/model/user.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/screens/googleSignUp.dart';
import 'package:sucial/screens/welcome_screen.dart';
import 'package:sucial/utils/FireStore.dart';
import 'package:sucial/utils/GoogleProvider.dart';
import 'package:sucial/utils/LoadingScaff.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
/*
class partialRouter extends StatelessWidget {
  const partialRouter({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return LoadingScaff();
        }
        else if (snapshot.hasError){
          return Welcome(analytics:analytics);
        }
        else if (snapshot.hasData) {
          GoogleProvider x = Provider.of<GoogleProvider>(context, listen: false);
          return StreamBuilder<List<UserObject>>(
            stream: fireStoreHandler().isUserExist(),
            builder: (context, snapshot2) {
              if (snapshot2.connectionState == ConnectionState.waiting){
                return LoadingScaff();
              }
              else if (snapshot2.hasData){
                var res = snapshot2.data!;
                bool fres = false;
                for (var i = 0; i < res.length; i++){
                  if (res[i].email == x.googleSignIn.currentUser!.email) fres = true;
                }
                if(fres){
                  return MobileScreenLayout();
                }
                else {
                  return GoogleSignupScreen();
                }
              }
              else{
                return Welcome(analytics:analytics);
              }
            },
          );
        }
        else {
          return Welcome(analytics:analytics);
        }
      }
    );
  }
}
*/