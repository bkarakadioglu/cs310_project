import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/responsive/walkthrough_screen_layout.dart';
import 'package:sucial/screens/add_post_screen.dart';
import 'package:sucial/screens/login_screen.dart';
import 'package:sucial/screens/profile_view_screen.dart';
import 'package:sucial/screens/signup_screen.dart';
import 'package:sucial/screens/edit_profile_screen.dart';
import 'package:sucial/screens/welcome_screen.dart';
import 'package:sucial/utils/GoogleProvider.dart';
import 'package:sucial/utils/PartialRouter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucial/services/analytics.dart';
/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  runApp(ChangeNotifierProvider(
    create: (context) => GoogleProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SUcial',
      theme: ThemeData.dark(),
      home: WalkthroughScreenLayout(),
      routes: {
        SignupScreen.routeName: (context) => SignupScreen(analytics:analytics, observer: observer,),
        LoginScreen.routeName: (context) => LoginScreen(analytics:analytics, observer:observer),
        ProfileView.routeName: (context) => ProfileView(),
        MobileScreenLayout.routeName: (context) => MobileScreenLayout(),
        EditProfileScreen.routeName: (context) => EditProfileScreen(analytics: analytics),
        AddPostScreen.routeName: (context) => AddPostScreen(),
        '/router': (context) => partialRouter(analytics:analytics),
      },
    ),
  ));
}
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sucial/providers/user_provider.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/responsive/responsive_layout_screen.dart';
//import 'package:sucial/responsive/web_screen_layout.dart';
import 'package:sucial/screens/login_screen.dart';
import 'package:sucial/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SUcial',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  //webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
            FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
            return Welcome(analytics: analytics);
          },
        ),
      ),
    );
  }
}