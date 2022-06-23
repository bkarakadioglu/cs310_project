import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sucial/model/post.dart';
import 'package:sucial/screens/add_post_screen.dart';
import 'package:sucial/screens/welcome_screen.dart';
import 'package:sucial/ui/post_card.dart';
import 'package:sucial/utils/GoogleProvider.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/styles.dart';
import 'package:sucial/screens/edit_profile_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucial/services/analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sucial/resources/auth_methods.dart';
import 'package:sucial/resources/firestore_methods.dart';
import 'package:sucial/screens/login_screen.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/utils.dart';
import 'package:sucial/widgets/follow_button.dart';
class ProfileView extends StatefulWidget {
  final String uid;


  const ProfileView({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();

  static const String routeName = '/profile_view';
}

class _ProfileViewState extends State<ProfileView> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    

    return isLoading
        ? const Center(
      child: CircularProgressIndicator(),) :
    Scaffold(

      appBar: AppBar(

        automaticallyImplyLeading: false, //for easier debug, in release should be changed to pushAndRemoveUntil
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              userData['username'],
            ),
            Row(
              children: [
                IconButton(
                   onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(analytics: FirebaseAnalytics.instance)));
                },
                icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    await AuthMethods().signOut();
                    Navigator.of(context)
                        .pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            Welcome(analytics: FirebaseAnalytics.instance),
                      ),
                    );
                    },

                  icon: Icon(Icons.logout)
                )
              ],
            ),
          ]
        ),
        backgroundColor: thirdColor,
        elevation: 0.0,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(
            Icons.add,
            color: thirdColor,

            ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen())),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        backgroundImage: NetworkImage(userData['photoUrl']),
                        radius: 45,
                      ),
                    ),
                    SizedBox(width: 15,)    ,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            postLen.toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text('Posts',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 15,)    ,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(followers.toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),),
                        ),
                        Text('Followers',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                    SizedBox(width: 15,)    ,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(following.toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),),
                        ),
                        Text('Following',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),



                  ],
                ),

                SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FirebaseAuth.instance.currentUser!.uid ==
                        widget.uid
                        ? FollowButton(
                      text: 'Sign Out',
                      backgroundColor:
                      mobileBackgroundColor,
                      textColor: primaryColor,
                      borderColor: Colors.grey,
                      function: () async {
                        await AuthMethods().signOut();
                        Navigator.of(context)
                            .pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                Welcome(analytics: FirebaseAnalytics.instance),
                          ),
                        );
                      },
                    )
                        : isFollowing
                        ? FollowButton(
                      text: 'Unfollow',
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      borderColor: Colors.grey,
                      function: () async {
                        await FireStoreMethods()
                            .followUser(
                          FirebaseAuth.instance
                              .currentUser!.uid,
                          userData['uid'],
                        );

                        setState(() {
                          isFollowing = false;
                          followers--;
                        });
                      },
                    )
                        : FollowButton(
                      text: 'Follow',

                      backgroundColor: Colors.blueGrey,
                      textColor: Colors.white,
                      borderColor: Colors.blue,
                      function: () async {
                        await FireStoreMethods()
                            .followUser(
                          FirebaseAuth.instance
                              .currentUser!.uid,
                          userData['uid'],
                        );

                        setState(() {
                          isFollowing = true;
                          followers++;
                        });
                      },
                    )
                  ],

                ),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bio" , style: kBoldLabelStyle),
                    SizedBox(height: 5),
                    Text(userData['bio']),

                  ],
                ),
                
                const Divider(
                  color: primaryColor,
                  thickness: 2.0,
                  height: 20,
                ),

                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    // (snapshot.connectionState == ConnectionState.waiting) {
                     // return const Center(
                     //   child: CircularProgressIndicator(),
                     // );
                    //}

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                        (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                )


              ],
            )
            ),
            ),
          ),
        );

  }
}