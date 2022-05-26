import 'package:flutter/material.dart';
import 'package:sucial/model/post.dart';
import 'package:sucial/utils/colors.dart';

class PostCard extends StatelessWidget {

  final Post post;
  final VoidCallback delete;
  PostCard({required this.post, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(

              padding: EdgeInsets.all(10),
                child: Image.network(post.imageURL)
            ),
            Text(
              post.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  post.date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  )
                ),

                const Spacer(),

                const Icon(
                  Icons.favorite,
                  size: 14.0,
                  color: secondaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                    post.likes.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    )
                ),

                const SizedBox(width: 8),

                const Icon(
                  Icons.comment,
                  size: 14.0,
                  color: secondaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                    post.comments.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    )
                ),

                const SizedBox(width: 2),

                IconButton(
                  iconSize: 14,
                  onPressed: delete,
                  icon: const Icon(Icons.delete, size: 14, color: secondaryColor,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
