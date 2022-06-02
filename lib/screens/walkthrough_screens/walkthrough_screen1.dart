import 'package:flutter/material.dart';
import 'package:sucial/screens/welcome_screen.dart';
import 'package:sucial/utils/styles.dart';

class WalkthroughScreen1 extends StatelessWidget {
  const WalkthroughScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text(
                      'Timeline',
                      style: kHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'See the photos posted by your friends in your timeline.'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Like, share, comment!'),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                      child: Image.asset(
                        'walkthrough_images/timeline.png',
                        width: 250,
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class WalkthroughScreen2 extends StatelessWidget {
  const WalkthroughScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text(
                      'Search',
                      style: kHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Search for people and posts.'),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                      child: Image.asset(
                        'walkthrough_images/search.png',
                        width: 250,
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class WalkthroughScreen3 extends StatelessWidget {
  const WalkthroughScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text(
                      'Notifications',
                      style: kHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Get notifications from your friends.'),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                      child: Image.asset(
                        'walkthrough_images/notifications.png',
                        width: 250,
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class WalkthroughScreen4 extends StatelessWidget {
  const WalkthroughScreen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text(
                      'Profile',
                      style: kHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'See your posts, or add new posts.'),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Edit your profile.'),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                      child: Image.asset(
                        'walkthrough_images/profile.png',
                        width: 250,
                      ),
                    ),
                    SizedBox(height: 20,),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'Done',
                            style: kButtonLightTextStyle,
                          ),
                        ),
                        style: kOutlinedDarkButtonStyle

                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
