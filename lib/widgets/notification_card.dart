import 'package:flutter/material.dart';

import '../utils/colors.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Row(
            children: [
            CircleAvatar(
            radius: 16,
              backgroundImage: NetworkImage(
                  'https://static5.depositphotos.com/1037987/476/i/600/depositphotos_4767995-stock-photo-couple-giving-two-young-children.jpg'),
            ),
              SizedBox(width: 20,),
              Text('username',)
            ]
          ),
                Text('Lorem ipsum dolor sit amet.')
        ],
      ),
    ),]
    ,
    )
    ,
    );
  }
}
