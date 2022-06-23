import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/utils/styles.dart';
//import 'package:sucial/utils/global_variable.dart';
import 'package:sucial/widgets/text_field_input.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucial/services/analytics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sucial/resources/auth_methods.dart';
import 'package:sucial/responsive/responsive_layout_screen.dart';
//import 'package:sucial/responsive/web_screen_layout.dart';
import 'package:sucial/screens/signup_screen.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/utils.dart';
import 'package:sucial/widgets/text_field_input.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static const String routeName = '/login_screen';
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future <void> setLogEvent(FirebaseAnalytics analytics, String name)async{
    await widget.analytics.logEvent(name: name);
  }

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              //webScreenLayout: WebScreenLayout(),
            ),
          ),
              (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
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
                    TextFieldInput(textEditingController: _emailController, hintText: 'Email', /*textInputType: TextInputType.username*/),
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
                          loginUser();
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => MobileScreenLayout()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: !_isLoading ? Text(
                            'Login',
                            style: kButtonLightTextStyle,
                          ) : const CircularProgressIndicator(
                            color: blueColor,
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
