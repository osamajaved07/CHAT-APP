// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_import

import 'package:chat_application/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupChatRoom extends StatefulWidget {
  const GroupChatRoom({super.key});

  @override
  State<GroupChatRoom> createState() => _GroupChatRoomState();
}

class _GroupChatRoomState extends State<GroupChatRoom> {

  String currentUserName  = 'User1';
  final TextEditingController _message = TextEditingController();
   List<Map<String, dynamic>> dummyChatList = [
    {
      "message" : "Hello",
      "sendBy" : "User1",
      "type" : "text"
    },
    {
      "message" : "Hello",
      "sendBy" : "User4",
      "type" : "text"
    },
    {
      "message" : "Hello",
      "sendBy" : "User9",
      "type" : "text"
    },
    {
      "message" : "Hello",
      "sendBy" : "User3",
      "type" : "text"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Group Name"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.27,
              width: size.width ,
              child: ListView.builder(
                itemCount: dummyChatList.length,
                itemBuilder: (context, index) {
                  return messageTile(size,dummyChatList[index]);
                }),
              ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.photo),
                            ),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send), onPressed: (){}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageTile (Size size, Map<String, dynamic> chatMap){
    return Container(
      width: size.width,
      alignment: chatMap['sendBy'] == currentUserName ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: size.width / 100,
        vertical: size.height / 400
      ),

      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height / 50,
          horizontal: size.width / 40
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,

        ),
        child: Text(chatMap['message']),
      ),

    );
  }
}