// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:chat_application/components/chat_card.dart';
import 'package:chat_application/components/filled_outline_button.dart';
import 'package:chat_application/constants.dart';
import 'package:chat_application/model/Chat.dart';
import 'package:chat_application/screens/message_screen.dart';
import 'package:flutter/material.dart';


class Body extends StatelessWidget {
  const Body({super.key, });
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: (){}, text: "Recent Messages"),
              SizedBox(width: kDefaultPadding,),
              FillOutlineButton(press: (){}, text: "Active", isFilled: false,)
            ],
          ),
        ),

        Expanded(child: ListView.builder(
          itemCount: chatsData.length,
          itemBuilder: (context, Index) => ChatCard(chat: chatsData[Index], 
          press: () {
            print("Moving to message screen");
          Navigator.push(context, MaterialPageRoute(builder: (context) => MessagesScreen()));})
          ))
      ],
    );
  }
}

