import 'package:flutter/material.dart';

import 'package:sucial/screens/feed_screen.dart';
import 'package:sucial/screens/notification_screen.dart';
import 'package:sucial/screens/profile_view_screen.dart';
import 'package:sucial/screens/search_screen.dart';
import 'package:sucial/screens/walkthrough_screens/walkthrough_screen1.dart';

List<Widget> homeScreenItems = [
  FeedScreen(), //the actual home screen where posts are shown
  SearchScreen(),
  NotificationScreen(),
  ProfileView(),
];

List<Widget> walkthroughScreenItems = [
  WalkthroughScreen1(),
  WalkthroughScreen2(),
  WalkthroughScreen3(),
  WalkthroughScreen4(),
];
