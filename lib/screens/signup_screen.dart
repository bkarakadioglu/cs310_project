

//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sucial/utils/colors.dart';

import 'package:sucial/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../utils/styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();

  static const String routeName = '/signup_screen';
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
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
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //Choose Photo Will Be implemented when Firebase is available
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.onlinewebfonts.com%2Ficon%2F241918&psig=AOvVaw14sDLK3I6bPoqgh6yc47rL&ust=1652892499499000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCOjd95ah5_cCFQAAAAAdAAAAABAD'),
                  ),
                  Positioned(
                    bottom: -8,
                    left: 90,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              //text field input for display name
              TextFieldInput(
                textEditingController: _textController,
                hintText:
                'Display Name', /*textInputType: TextInputType.username*/
              ),
              const SizedBox(height: 12),
              //text field input for username
              TextFieldInput(
                textEditingController: _textController1,
                hintText: 'Username', /*textInputType: TextInputType.username*/
              ),
              const SizedBox(height: 12),
              //text field input for email (do not forget to check email)
              TextFieldInput(
                textEditingController: _textController2,
                hintText: 'Email', /*textInputType: TextInputType.username*/
              ),
              const SizedBox(height: 12),
              //text field input for password
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Password',
                /*textInputType: TextInputType.username,*/
                isPass: true,
              ),
              const SizedBox(height: 12),
              //login button
              OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MobileScreenLayout()));
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      'Signup',
                      style: kButtonLightTextStyle,
                    ),
                  ),
                  style: kOutlinedDarkButtonStyle

              ),

            ],
          ),
        ),
      ),
    );
  }
}
