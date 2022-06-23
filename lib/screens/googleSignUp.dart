import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sucial/utils/FireStore.dart';
import 'package:sucial/utils/GoogleProvider.dart';
import 'package:sucial/utils/Storage.dart';
import 'package:sucial/widgets/text_field_input.dart';
import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class GoogleSignupScreen extends StatefulWidget {
  const GoogleSignupScreen({Key? key}) : super(key: key);

  @override
  State<GoogleSignupScreen> createState() => _GoogleSignupScreenState();

  static const String routeName = '/signup_screen';
}

class _GoogleSignupScreenState extends State<GoogleSignupScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  //final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _usernameController.dispose();

    //_emailController.dispose();
  }



  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    var gp = Provider.of<GoogleProvider>(context, listen: false);
    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: gp.googleSignIn.currentUser!.email,
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
          builder: (context) => const ResponsiveLayout(
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

                    //text field input for username
                    TextFieldInput(
                      textEditingController: _usernameController,
                      hintText: 'Username', /*textInputType: TextInputType.username*/
                    ),
                    /*const SizedBox(height: 12),
                    //text field input for email (do not forget to check email)
                    TextFieldInput(
                      textEditingController: _emailController,
                      hintText: 'Email', /*textInputType: TextInputType.username*/
                    ),*/
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
                        onPressed: ()  {
                          //await setLogEvent(widget.analytics, 'Register Process');
                          signUpUser();
                          //setCurrentScreen(widget.analytics, "Sign up Button Press");
                          Navigator.pushNamed(context, "/login_screen");
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
