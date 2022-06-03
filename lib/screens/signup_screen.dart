import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sucial/utils/FireStore.dart';
import 'package:sucial/utils/Storage.dart';
import 'package:sucial/widgets/text_field_input.dart';
import '../utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucial/services/analytics.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  State<SignupScreen> createState() => _SignupScreenState();

  static const String routeName = '/signup_screen';
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var picLink = 'https://pic.onlinewebfonts.com/svg/img_241918.png';

  void setuserId(FirebaseAnalytics analytics, String userId){
    widget.analytics.setUserId();
  }
  void setCurrentScreen(FirebaseAnalytics analytics, String screenName){
    widget.analytics.setCurrentScreen(screenName: screenName);
  }

  Future <void> setLogEvent(FirebaseAnalytics analytics, String name)async{
    await widget.analytics.logEvent(name: name);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _passwordController.dispose();
  }

  Future<String> getPic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("profPic")){
      return sharedPreferences.getString("profPic")!;
    }
    else{
      return picLink;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return WillPopScope(
      onWillPop: () async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.clear();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 60,),
                            //Choose Photo Will Be implemented when Firebase is available
                            Stack(
                              children: [
                                FutureBuilder<String>(
                                  future: getPic(),
                                  builder: (context, snapshot){
                                    if(snapshot.hasData){
                                      return CircleAvatar(
                                            radius: 64,
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(snapshot.data!)
                                        );
                                    }
                                    else {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                  }
                                ),
                                Positioned(
                                  bottom: -8,
                                  left: 90,
                                  child: IconButton(
                                    onPressed: () async {
                                      final result = await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: ['png','jpg','jpeg']
                                      );
                                      if (result == null){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Please Chose A File"))
                                        );
                                        return null;
                                      }
                                      else {
                                        final path = result.files.single.path;
                                        final fileName = result.files.single.name;
                                        var storagePath = await storage.uploadFile(fileName, path!);
                                        SharedPreferences sharedPreferences  = await SharedPreferences.getInstance();
                                        sharedPreferences.setString("profPic", storagePath);
                                        setState(() {});
                                      }
                                    },
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
                              isPass: true
                            ),
                            const SizedBox(height: 12),
                            //login button
                            OutlinedButton(
                                onPressed: () async {
                                  await setLogEvent(widget.analytics, 'Register Process');
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => MobileScreenLayout()));
                                  var x = FirebaseAuth.instance;
                                  await x.createUserWithEmailAndPassword(email: _textController2.text, password: _passwordController.text).catchError((error)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(error!.toString()))
                                    );

                                  });
                                  var fireHandle = fireStoreHandler();
                                  await fireHandle.setUser().add({"email":_textController2.text, "displayName": _textController.text, "userName": _textController1.text, "userPic": await getPic(), "userLikes":0, "userPosts":{}, "userFollowers":0, "userFollowings": []}).catchError((error)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error!.toString()))
                                    );
                                  });
                                  setCurrentScreen(widget.analytics, "Sign up Button Press");
                                  Navigator.pushNamed(context, "/login_screen");
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
          ),
        ),
      ),
    );
  }
}
