import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sucial/screens/welcome_screen.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/global_variables.dart';
import 'package:sucial/widgets/post_card.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar:
          AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: true,
        title: Text("SUcial")
        ,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: primaryColor,
            ),
            onPressed: ()  async {
              await AuthMethods().signOut();
              Navigator.of(context)
                  .pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      Welcome(analytics: FirebaseAnalytics.instance),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal:  0,
                vertical: 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}