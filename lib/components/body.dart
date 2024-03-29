// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, use_build_context_synchronously, unused_field, prefer_final_fields, override_on_non_overriding_member, unused_import, unused_local_variable

// import 'dart:html';

import 'package:chat_application/components/chat_card.dart';
import 'package:chat_application/components/filled_outline_button.dart';
import 'package:chat_application/components/messages.dart';
import 'package:chat_application/constants.dart';
import 'package:chat_application/controller/chatroom_controller.dart';
import 'package:chat_application/model/Chat.dart';
import 'package:chat_application/screens/message_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with WidgetsBindingObserver {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

   static User get user => auth.currentUser!;
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  FocusNode _searchfocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


     static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
  return FirebaseFirestore.instance
      .collection('chatroom')
      .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
    // getMyUsersId();
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
    print("Status Updated");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("App lifecycle state changed to: $state");

    if (state == AppLifecycleState.resumed) {
      setStatus(
        "Online",
      );
    } else {
      // Delaying the setting of status to offline to avoid flickering
      setStatus("Offline");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchfocusNode.dispose();

    super.dispose();
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
  // String chatRoomId(String user1, String user2) {
  //   return user1.compareTo(user2) < 0 ? "$user1$user2" : "$user2$user1";
  // }

  String getChatRoomId(String user1, String user2) {
    List<String> users = [user1, user2];
    users.sort();
    return "${users[0]}${users[1]}";
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where("name", isEqualTo: _search.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          userMap = querySnapshot.docs[0].data() as Map<String, dynamic>?;
          isLoading = false;
        });
        print(userMap);
      } else {
        setState(() {
          userMap = null;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kSecondaryColor,
            content: Text(
              "User not found",
              style: TextStyle(color: kContentColorLightTheme),
            ),
            duration: Duration(seconds: 4), // Adjust duration as needed
          ),
        );
        print("User not found");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: Colors.blue.shade400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search here...",
                  hintStyle: TextStyle(color: Colors.white),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _search.clear();
                          _searchfocusNode.unfocus();
                          setState(() {});
                        },
                        icon: Icon(Icons.close),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: onSearch,
                        icon: Icon(Icons.search),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  FillOutlineButton(press: () {}, text: "Recent Messages"),
                  SizedBox(width: kDefaultPadding),
                  FillOutlineButton(
                    press: () {},
                    text: "Active",
                    isFilled: false,
                  ),
                ],
              ),
            ],
          ),
        ),
        isLoading
            ? CircularProgressIndicator() // Show loading indicator
            : userMap != null
                ? ListTile(
                    leading: Icon(
                      Icons.account_box_outlined,
                      color: Colors.black,
                    ),
                    trailing: Icon(
                      Icons.chat,
                      color: Colors.black,
                    ),
                    onTap: () {
                      String roomId = chatRoomId(
                          _auth.currentUser!.displayName!, userMap!['name']);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChatRoom(
                            chatRoomId: roomId,
                            userMap: userMap!,
                          ),
                        ),
                      );
                    },
                    title: Text(userMap!['name']),
                  ) // Show user email if found
                  : Expanded(
  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: ChatroomService.getMyChatrooms(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());
        case ConnectionState.done:
        case ConnectionState.active:
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print("No Chats found");
            return Center(child: Text("No chat found"));
          }

          final chatDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              final chatRoomId = chatDocs[index].id;

              return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy('time', descending: true)
                    .limit(1)
                    .get(),
                builder: (context, chatSnapshot) {
                  switch (chatSnapshot.connectionState) {
                    case ConnectionState.waiting:
                      return SizedBox.shrink();
                    case ConnectionState.done:
                    case ConnectionState.active:
                      final chatDocs = chatSnapshot.data!.docs;

                      if (chatDocs.isEmpty) {
                        return SizedBox.shrink();
                      }

                      final lastMessageData = chatDocs[0].data();
                      final lastMessage = lastMessageData['message'] ?? '';

                      return ListTile(
                        title: Text(lastMessage),
                        onTap: () {
                          // Navigate to chat room or do something else
                        },
                      );
                    default:
                      return SizedBox.shrink();
                  }
                },
              );
            },
          );
        default:
          return SizedBox.shrink();
      }
    },
  ),
),


        // Expanded(
        //     child: ListView.builder(
        //       itemCount: chatsData.length,
        //       itemBuilder: (context, index) => ChatCard(
        //         chat: chatsData[index],
        //         press: () {
        //           print("Moving to message screen");
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => MessagesScreen(),
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //   ),
      ],
    );
  }

}
