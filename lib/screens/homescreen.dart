// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, unused_import, non_constant_identifier_names, sized_box_for_whitespace, await_only_futures, no_leading_underscores_for_local_identifiers, avoid_print, override_on_non_overriding_member, use_key_in_widget_constructors, use_build_context_synchronously, unused_element

import 'package:chat_application/components/body.dart';
import 'package:chat_application/components/messages.dart';
import 'package:chat_application/constants.dart';
import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/main.dart';
import 'package:chat_application/model/Chat.dart';
import 'package:chat_application/model/group_chat/group_chat_screen.dart';
import 'package:chat_application/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  
  late Map<String, dynamic> userMap;
  bool isLoading = false;

  int _selectedIndex = 0;

  final formkey = GlobalKey<FormState>();

  final TextEditingController _search = TextEditingController();

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        userMap = querySnapshot.docs[0].data() as Map<String, dynamic>;
        isLoading = false;
      });
      print(userMap);

      // Create a new chat room
      String roomId = createChatRoomId(_auth.currentUser!.uid, userMap!['uid']);

      // Navigate to the chat room
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatRoom(chatRoomId: roomId, userMap: userMap!,),
        ),
      );
    } else {
      setState(() {
        // userMap = null;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kSecondaryColor,
          content: Text(
            "User not found",
            style: TextStyle(color: kContentColorLightTheme),
          ),
          duration: Duration(seconds: 4),
        ),
      );
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    print("Error: $e");
  }
}

String createChatRoomId(String userId1, String userId2) {
  List<String> userIds = [userId1, userId2];
  userIds.sort();
  return "${userIds[0]}_${userIds[1]}";
}


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        _addChatUserDialog();

      }, child: Icon(Icons.add_comment),),
      appBar: App_Bar(),
      body: isLoading
          ? Center(
              child: Container(
                alignment: Alignment.center,
                height: size.height / 20,
                width: size.width / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Body(),
      bottomNavigationBar: Bottomnavigationbar(),
    );
    
  }

  CurvedNavigationBar Bottomnavigationbar() {
    return CurvedNavigationBar(
      index: 0,
      backgroundColor: Colors.white, // Background color
      color: Colors.blue.shade400, // Button color
      buttonBackgroundColor: kPrimaryColor,
      // Active button color
      height: 50,
      items: <Widget>[
        Icon(Icons.messenger, size: 30),
        IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) => GroupChatHomeScreen(),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          icon: Icon(Icons.group),
          iconSize: 30,
        ),
        // Icon(
        //   Icons.call,
        //   size: 30,
        // ),
        IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) => ProfileScreen(),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          iconSize: 30,
        ),
      ],
    );
  }

  AppBar App_Bar() {
    return AppBar(
      backgroundColor:Colors.blue.shade400,
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton.outlined(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Logout"),
                  content: Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        AuthService().logout();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Logged Out...')),
                        );
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text("Logout"),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }
    void _addChatUserDialog() {
    // String name= '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: Row(
                children: const [
                  Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text('  Add User')
                ],
              ),

              //content
              content: TextFormField(
                controller: _search,
                maxLines: 1,
                // onChanged: (value) => name = value,
                decoration: InputDecoration(
                    hintText: 'Name',
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 16))),

                //add button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                      onSearch();
                      
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }

}

