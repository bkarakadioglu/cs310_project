import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/utils/styles.dart';

import 'package:sucial/widgets/text_field_input.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucial/services/analytics.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static const String routeName = '/login_screen';
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future <void> setLogEvent(FirebaseAnalytics analytics, String name)async{
    await widget.analytics.logEvent(name: name);
  }

  @override
  void dispose(){
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: Container(), flex: 2,),
                    //text or image of the logo of the SUcial
                    Text("Login", style: kHeadingTextStyle),
                    const SizedBox(height:200),
                    //text field input for username
                    TextFieldInput(textEditingController: _usernameController, hintText: 'Username', /*textInputType: TextInputType.username*/),
                    const SizedBox(height:24),
                    //text field input for password
                    TextFieldInput(textEditingController: _passwordController, hintText: 'Password', /*textInputType: TextInputType.username,*/ isPass: true,),
                    const SizedBox(height:24),
                    //login button
                    OutlinedButton(
                        onPressed: () async {
                          await setLogEvent(widget.analytics, 'Login Process');
                          setCurrentScreen(widget.analytics, "Log in Press");
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: _usernameController.text, password: _passwordController.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MobileScreenLayout()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Login',
                            style: kButtonLightTextStyle,
                          ),
                        ),
                        style: kOutlinedDarkButtonStyle
                    ),
                    //SizedBox(height: 100),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
