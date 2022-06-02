//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/global_variables.dart';

class WalkthroughScreenLayout extends StatefulWidget {
  const WalkthroughScreenLayout({Key? key}) : super(key: key);

  @override
  State<WalkthroughScreenLayout> createState() => _WalkthroughScreenLayoutState();

  static const String routeName = '/walkthrough_screen_layout';
}

class _WalkthroughScreenLayoutState extends State<WalkthroughScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState(){
    super.initState();
    pageController = PageController();

  }

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: [
            walkthroughScreenItems[0],
            walkthroughScreenItems[1],
            walkthroughScreenItems[2],
            walkthroughScreenItems[3],
          ],

          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                  color: _page == 0 ? primaryColor : secondaryColor,),
                label: '',
                backgroundColor: primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor,),
                label: '',
                backgroundColor: primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite,
                  color: _page == 2 ? primaryColor : secondaryColor,),
                label: '',
                backgroundColor: primaryColor
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,
                  color: _page == 3 ? primaryColor : secondaryColor,),
                label: '',
                backgroundColor: primaryColor
            ),

          ],
          onTap: navigationTapped,
        ));
  }
}
