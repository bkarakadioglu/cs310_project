//import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/styles.dart';

import 'package:sucial/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
  static const String routeName = '/login_screen';
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: Container(
          padding: EdgeInsets.all(50),
          width: double.infinity,
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MobileScreenLayout()));
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
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
    );
  }
}
