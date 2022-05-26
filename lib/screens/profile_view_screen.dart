import 'package:flutter/material.dart';
import 'package:sucial/model/post.dart';
import 'package:sucial/screens/add_post_screen.dart';
import 'package:sucial/ui/post_card.dart';
import 'package:sucial/utils/colors.dart';
import 'package:sucial/utils/dimensions.dart';
import 'package:sucial/utils/screenSizes.dart';
import 'package:sucial/utils/styles.dart';
import 'package:sucial/screens/edit_profile_screen.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();

  static const String routeName = '/profile_view';
}

class _ProfileViewState extends State<ProfileView> {
  List<Post> posts = [
    Post(text: 'Hello World 1', date: 'March 31', likes: 10, comments: 0, imageURL: "https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg"),
    Post(text: 'Hello World 2', date: 'March 30', likes: 0, comments: 5, imageURL: "https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg"),
    Post(text: 'Hello World 3', date: 'March 29', likes: 20, comments: 10, imageURL: "https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg"),
    Post(text: 'Hello World 4', date: 'March 29', likes: 20, comments: 10, imageURL: "https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg"),
    Post(text: 'Hello World 5', date: 'March 29', likes: 20, comments: 10, imageURL: "https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg"),
  ];
  int postCount = 0;

  void deletePost(Post post) {
    setState(() {
      posts.remove(post);
    });
  }

  void buttonClicked() {
    setState(() {
      postCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false, //for easier debug, in release should be changed to pushAndRemoveUntil
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "username"
            ),
            IconButton(
               onPressed: () {

                 Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
            },
            icon: Icon(Icons.edit),
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
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(45),
                          child: Image.network(
                            'https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg',
                            //fit: BoxFit.fitHeight,
                          ),
                       ),
                        radius: 45,
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '345',
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

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text('800',
                            style: TextStyle(
                              fontSize: 20,
                            ),),
                        ),
                        Text('Follower',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text('650',
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

                    const SizedBox(width: 8,),
                  ],
                ),

                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Display Name" , style: kBoldLabelStyle),
                    SizedBox(height: 5),
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse posuere lectus libero, non hendrerit mauris placerat quis."),

                  ],
                ),
                
                const Divider(
                  color: primaryColor,
                  thickness: 2.0,
                  height: 20,
                ),

                /*GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: List.generate(posts.length, (index) {
                    return Center(
                      child: PostCard(post: posts[index], delete: () => deletePost(posts[index]),),
                    );
                  }
                  ),*/
                Column(
                  children: posts.map((post) => PostCard(
                    post: post,
                    delete: (){
                      deletePost(post);
                    },
                  )).toList(),
                ),

              ],
            )
            ),
            ),
          ),
        );

  }
}