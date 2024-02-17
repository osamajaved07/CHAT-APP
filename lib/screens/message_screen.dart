// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, camel_case_types

import 'package:chat_application/constants.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: mainBody(),


    );
  }

  AppBar Appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: Row(
        children: [
          BackButton(),

          CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),

          SizedBox(width: kDefaultPadding * 0.75,),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kristin Watson", style: TextStyle(
                fontSize: 16,
                color: kContentColorDarkTheme
              ),),

              Text("Active 3m ago", style: TextStyle(
                fontSize: 12,
                color: kContentColorDarkTheme
              ),)
            ],
          )
        ],
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.local_phone)),
        IconButton(onPressed: (){}, icon: Icon(Icons.videocam)),
      ],
    );
  }
}

class mainBody extends StatelessWidget {
  const mainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        ChatInputField(),
        
      ],
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
                offset: Offset (0 , 4),
                blurRadius: 32,
                color: Color(0xFF087949).withOpacity(0.08)
              )],
        color: Theme.of(context).scaffoldBackgroundColor
      ),
      child: SafeArea(child: Row(
        children: [
          Icon(Icons.mic, color: kPrimaryColor,),
    
          SizedBox(width: kDefaultPadding,),
    
          Expanded(child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75
            ),
            height: 50,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(40),
              
              
            ),
            child: Row(
              children: [
                Icon(Icons.sentiment_satisfied_alt_outlined,
                // color: Theme.of(context)
                // .textTheme
                // .bodyText1!
                // .color!
                // .withOpacity(0.64),
                ),
    
                SizedBox(width: kDefaultPadding / 4,),
    
                Expanded(child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type message",
                    border: InputBorder.none
                  ),
                )),
    
                Icon(Icons.attach_file,
                // color: Theme.of(context)
                // .textTheme
                // .bodyText1!
                // .color!
                // .withOpacity(0.64),
                ),
    
                SizedBox(width: kDefaultPadding / 4,),
    
                Icon(Icons.camera_alt_outlined,
                // color: Theme.of(context)
                // .textTheme
                // .bodyText1!
                // .color!
                // .withOpacity(0.64),
                ),
    
              ],
            ),
          ))
    
        ],
      )),
    );
  }
}