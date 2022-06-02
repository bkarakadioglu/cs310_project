import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TimelinePostCard extends StatelessWidget {
  const TimelinePostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int likes = 100;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg'),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'username',
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.report)),
              ],
            ),
          ),
          //IMAGE
          SizedBox(
            child: Image.network(
                'https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg'),
          ),
          //REPOST,COMMENT,UPVOTE,DOWNVOTE
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.message_outlined)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.directions)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_upward_outlined)),
                    Text('100'),
                    //number of likes-dislike (will be available with firebase)
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_downward_outlined)),
                  ],
                )
              ],
            ),
          ),
          //Description
          Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lorem ipsum dolor sit amet. Consectetur edipiscing elit.'),

                  ],
                ),

              ],
            )

            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10,),
                    Text('username')
                  ],
                ),
                Row(
                  children: [
                    Text('Lorem ipsum dolor sit amet. Consectetur edipiscing elit.'),
                    SizedBox(width: 10,)

                  ],
                )
              ],
            )*/
          )

        ],
      ),
    );
  }
}
