// ignore_for_file: prefer_const_constructors, unnecessary_string_escapes

import 'package:chat_application/constants.dart';
import 'package:flutter/material.dart';

class VideoMessage extends StatelessWidget {
  const VideoMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45 ,

      child: AspectRatio(aspectRatio: 1.6, 
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("assets/images/Video Place Here.png"),
            ),

            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle
              ),
              child: Icon(Icons.play_arrow,
              size: 16,
              color: Colors.white,),
            )
          ],
        ),),
    );
  }
}
