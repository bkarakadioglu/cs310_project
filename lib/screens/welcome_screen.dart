import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial/screens//login_screen.dart';
import 'package:sucial/screens/signup_screen.dart';
import 'package:sucial/utils/GoogleProvider.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/styles.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 300),
                child: RichText(
                  text: TextSpan(
                    text: "SUcial",
                    style: kHeadingTextStyle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Expanded(
                      flex: 3,
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
                    ),

                    Expanded(

                      flex: 1,
                      child: Container(

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: IconButton(
                          icon: Image.network("https://icon-library.com/images/facebook-icon-jpg-download/facebook-icon-jpg-download-14.jpg"),
                          onPressed: () {},
                        ),
                      ),



                    ),

                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),

                        child: IconButton(
                          icon: Image.network("https://cdn.icon-icons.com/icons2/729/PNG/128/google_icon-icons.com_62736.png"),
                          onPressed: () async {
                            final provider = Provider.of<GoogleProvider>(context,listen: false);
                            await provider.googleLogin();
                            Navigator.pushNamed(context, "/router");
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                  ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(

                    flex: 4,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Sign Up',
                            style: kButtonLightTextStyle,
                          ),
                        ),
                        style: kOutlinedDarkButtonStyle

                    ),
                  ),
                  SizedBox(width: 40),
                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}
