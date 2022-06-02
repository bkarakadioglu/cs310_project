import 'package:flutter/material.dart';
import 'package:sucial/utils/styles.dart';
import 'package:sucial/widgets/text_field_input.dart';

import '../utils/colors.dart';

bool user_search = true;


String hint_text(bool user_search)
{
  if(user_search == true)
  {
    return 'You can search for users.';
  }
  else
  {
    return 'You can search for posts.';
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
  static const String routeName = '/search_screen';
}


class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //for easier debug, in release should be changed to pushAndRemoveUntil
        title:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("search"),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    user_search = true;
                  });

                },
                icon: Icon(Icons.person, color: user_search == true ? primaryColor : secondaryColor,),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    user_search = false;
                  });
                },
                icon: Icon(Icons.photo, color: user_search == false ? primaryColor : secondaryColor,),
              ),
            ],
          )
        ]),
        backgroundColor: thirdColor,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            TextFieldInput(textEditingController: TextEditingController(), hintText: hint_text(user_search)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

              ],
            ),
          ],
        ),
      ),
    );
  }
}

