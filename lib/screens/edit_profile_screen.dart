import 'dart:typed_data';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/screenSizes.dart';
import 'package:sucial/utils/styles.dart';
import 'package:sucial/widgets/text_field_input.dart';
import 'package:sucial/screens/profile_view_screen.dart';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sucial/utils/FireStore.dart';
import 'package:sucial/utils/Storage.dart';
import 'package:sucial/utils/utils.dart';
import 'package:sucial/widgets/text_field_input.dart';
import '../providers/user_provider.dart';
import '../utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucial/services/analytics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sucial/resources/auth_methods.dart';
import 'package:sucial/resources/firestore_methods.dart';
import 'package:sucial/responsive/mobile_screen_layout.dart';
import 'package:sucial/responsive/responsive_layout_screen.dart';
import 'package:sucial/screens/login_screen.dart';
import 'package:sucial/utils/colors.dart';

import 'package:sucial/utils/utils.dart';
import 'package:sucial/widgets/text_field_input.dart';

class EditProfileScreen extends StatefulWidget{
  const EditProfileScreen({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();

  static const String routeName = '/edit_profile';
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isPrivate = false;
  Uint8List? _image;
  bool _isLoading = false;

  final TextEditingController _bioController = TextEditingController();

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }


  @override
  void dispose() {
    super.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,

        centerTitle: false,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text('edit')],

        ),
      ),
      body: Padding(

        padding: EdgeInsetsDirectional.all(15),
        child: SingleChildScrollView(
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
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: _image == null ? NetworkImage(userProvider.getUser.photoUrl) : MemoryImage(_image!) as ImageProvider<Object>?,
                          backgroundColor: Colors.red,
                        ),
                        Positioned(
                          bottom: -8,
                          left: 90,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 64),

                    //text field input for username

                    const SizedBox(height: 12),
                    //text field input for bio name
                    TextFieldInput(
                      textEditingController: _bioController,
                      hintText:
                      'New Bio', /*textInputType: TextInputType.username*/
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Text("Private Profile", style: kButtonLightTextStyle,),
                        Switch(value: isPrivate,
                            onChanged: (value)=>{
                              setState(() {
                                isPrivate = value;
                              }
                              )
                            } ,
                            activeTrackColor: primaryColor,
                            activeColor: secondaryColor)
                      ],),
                    const SizedBox(height: 12),
                    OutlinedButton(
                        onPressed: () async {
                          if(_image == null && _bioController.text == null){

                          }else if(_image != null && _bioController.text == null){
                            await FireStoreMethods().changeProfPic(userProvider.getUser.uid, _image!);
                          }else if(_image == null && _bioController.text != null){
                            await FireStoreMethods().changeBio(userProvider.getUser.uid, _bioController.text);
                          }else if(_image != null && _bioController.text != null){
                            await FireStoreMethods().changeProfPic(userProvider.getUser.uid, _image!);
                            await FireStoreMethods().changeBio(userProvider.getUser.uid, _bioController.text);


                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>  ResponsiveLayout(
                                mobileScreenLayout: MobileScreenLayout(),
                                //webScreenLayout: WebScreenLayout(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: !_isLoading ? Text(
                            'Doing the changes',
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







        /*Column(
          //hmainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: CircleAvatar(

                  backgroundColor: secondaryColor,
                  child: ClipRRect(

                    borderRadius: BorderRadius.circular(45),
                    child: Text("Change Photo", style: kButtonDarkTextStyle),

                  ),
                  radius: 90,
                ),

            ),
            SizedBox(height: 5,),
            Divider(thickness: 3, color: thirdColor,),
            TextFieldInput(textEditingController: TextEditingController(), hintText: 'Display Name'),
            Divider(thickness: 3, color: thirdColor,),
            TextFieldInput(textEditingController: TextEditingController(), hintText: 'Username'),
            Divider(thickness: 3, color: thirdColor,),
            Container(
                width: screenWidth(context), //test if this makes the text wrap
                child: TextFieldInput(contentPadding: 50, textEditingController: TextEditingController(), hintText: 'Bio')),
            Divider(thickness: 3, color: thirdColor,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              Text("Private Profile", style: kButtonLightTextStyle,),
              Switch(value: isPrivate,
                  onChanged: (value)=>{
                    setState(() {
                      isPrivate = value;
                    }
                    )
                  } ,
                  activeTrackColor: primaryColor,
                  activeColor: secondaryColor)
            ],),
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  
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


        ),*/
      ),


    );
  }
}