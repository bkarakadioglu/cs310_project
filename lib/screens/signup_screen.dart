import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sucial/utils/FireStore.dart';
import 'package:sucial/utils/Storage.dart';
import 'package:sucial/utils/utils.dart';
import 'package:sucial/widgets/text_field_input.dart';
import '../utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucial/services/analytics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sucial/resources/auth_methods.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/responsive/responsive_layout_screen.dart';
import 'package:sucial/screens/login_screen.dart';
import 'package:sucial/utils/colors.dart';
//import 'package:sucial/utils/global_variable.dart';
import 'package:sucial/utils/utils.dart';
import 'package:sucial/widgets/text_field_input.dart';





class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  @override
  State<SignupScreen> createState() => _SignupScreenState();

  static const String routeName = '/signup_screen';
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var picLink = 'https://pic.onlinewebfonts.com/svg/img_241918.png';
  Uint8List? _image;
  bool _isLoading = false;

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
    _passwordController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
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

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            //webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }


  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
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
                                _image != null
                                    ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                  backgroundColor: Colors.red,
                                )
                                    : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://i.stack.imgur.com/l60Hf.png'),
                                  backgroundColor: Colors.red,
                                ),
                                Positioned(
                                  bottom: -8,
                                  left: 90,
                                  child: IconButton(
                                    onPressed: selectImage, /*() async {
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
                                    },*/
                                    icon: const Icon(Icons.add_a_photo),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 64),

                            //text field input for username
                            TextFieldInput(
                              textEditingController: _usernameController,
                              hintText: 'Username', /*textInputType: TextInputType.username*/
                            ),
                            const SizedBox(height: 12),
                            //text field input for email (do not forget to check email)
                            TextFieldInput(
                              textEditingController: _emailController,
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
                            //text field input for bio name
                            TextFieldInput(
                              textEditingController: _bioController,
                              hintText:
                              'Bio', /*textInputType: TextInputType.username*/
                            ),
                            const SizedBox(height: 12),
                            //login button
                            OutlinedButton(
                                onPressed: () async {
                                  await setLogEvent(widget.analytics, 'Register Process');
                                  signUpUser();
                                  setCurrentScreen(widget.analytics, "Sign up Button Press");
                                  //Navigator.pushNamed(context, "/login_screen");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: !_isLoading ? Text(
                                    'Signup',
                                    style: kButtonLightTextStyle,
                                  ) : const CircularProgressIndicator(
                                    color: blueColor,
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
