import 'package:flutter/material.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/screenSizes.dart';
import 'package:sucial/utils/styles.dart';
import 'package:sucial/widgets/text_field_input.dart';
import 'package:sucial/screens/profile_view_screen.dart';
class EditProfileScreen extends StatefulWidget{
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();

  static const String routeName = '/edit_profile';
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isPrivate = false;
  @override
  Widget build(BuildContext context) {
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
        child: Column(
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


        ),
      ),


    );
  }
}