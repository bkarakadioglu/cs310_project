//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sucial/utils/colors.dart';

import '../widgets/timeline_post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('timeline'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.messenger_outline), //messages icon will be located in the appbar instead of bottom navigation, will be implemented when firebase is available
          ),
        ],
      ),
      //body: const TimelinePostCard(), const TimelinePostCard(),
      body:SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(
                    color: primaryColor,
                    thickness: 0,
                    height: 2,
                  ),
                  const TimelinePostCard(),
                  const Divider(
                    color: primaryColor,
                    thickness: 0,
                    height: 2,
                  ),
                  const TimelinePostCard(),
                ],
              ),
            ),
        )
      )

    );
  }
}
