import 'package:flutter/material.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/screenSizes.dart';
import 'package:sucial/utils/styles.dart';
import 'package:sucial/widgets/text_field_input.dart';
import 'package:sucial/screens/profile_view_screen.dart';
class AddPostScreen extends StatefulWidget{
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();

  static const String routeName = '/add_post';
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,

        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text('add Post')],

        ),
      ),
      body: Padding(

        padding: EdgeInsetsDirectional.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: primaryColor,
              height: 200,
              width: screenWidth(context),
              child: Image.network("http://cdn.onlinewebfonts.com/svg/img_234957.png")
            ),


            SizedBox(height: 5,),
            
            Divider(thickness: 3, color: thirdColor,),
            Container(
                width: screenWidth(context), //test if this makes the text wrap
                child: TextFieldInput(contentPadding: 50, textEditingController: TextEditingController(), hintText: 'Description')),
            Divider(thickness: 3, color: thirdColor,),

            OutlinedButton(

                onPressed: () {
                  Navigator.pop(context);

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Post',
                    style: kButtonLightTextStyle,
                  ),
                ),
                style: kOutlinedDarkButtonStyle

            ),

          ],


        ),
      ),


    );
  }
}