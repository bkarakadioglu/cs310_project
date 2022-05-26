//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sucial/utils/colors.dart';

import '../widgets/notification_card.dart';
import '../widgets/timeline_post_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('notifications'),
      ),

      body: SafeArea(
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
                  const NotificationCard(),
                  const Divider(
                    color: primaryColor,
                    thickness: 0,
                    height: 2,
                  ),
                  const NotificationCard(),
                ],
              ),
            )
        ),
      )


    );
  }
}
