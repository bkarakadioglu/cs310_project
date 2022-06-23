import 'package:flutter/material.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/screenSizes.dart';
import 'package:sucial/utils/styles.dart';
import 'package:sucial/widgets/text_field_input.dart';
import 'package:sucial/screens/profile_view_screen.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:sucial/providers/user_provider.dart';
import 'package:sucial/resources/firestore_methods.dart';
import 'package:sucial/utils/utils.dart';
import 'package:provider/provider.dart';
class AddPostScreen extends StatefulWidget{
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();

  static const String routeName = '/add_post';
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return _file == null
        ? Scaffold(
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

                height: 200,
                width: screenWidth(context),
                child: GestureDetector(
                    child: Container(
                        width:120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              image:AssetImage("assets/add_image_image.png"),
                              fit:BoxFit.cover
                          ),

                        )
                    ),onTap:(){
                  _selectImage(context);
                }
                )
            ),


            SizedBox(height: 5,),

            Divider(thickness: 3, color: thirdColor,),
            Container(
                width: screenWidth(context), //test if this makes the text wrap
                child: TextFieldInput(textEditingController: _descriptionController, hintText: 'Description')),
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


    ) :
        Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text('add Post')],

        ),
      ),
      body: Column(
        children: [
          isLoading ? const LinearProgressIndicator():
          Padding(

            padding: EdgeInsetsDirectional.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    //color: primaryColor,
                    height: 200,
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                          image: MemoryImage(_file!),
                        ),
                ),
                ),


                SizedBox(height: 5,),

                Divider(thickness: 3, color: thirdColor,),
                Container(
                    width: screenWidth(context), //test if this makes the text wrap
                    child: TextFieldInput(textEditingController: _descriptionController, hintText: 'Description')),
                Divider(thickness: 3, color: thirdColor,),

                OutlinedButton(

                    onPressed: ()  =>
                      postImage(
                        userProvider.getUser.uid,
                        userProvider.getUser.username,
                        userProvider.getUser.photoUrl,
                      )
                      //Navigator.pop(context);
                    ,
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
        ],
      ),


    )
    ;

  }
}