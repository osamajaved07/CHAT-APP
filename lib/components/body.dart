// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:chat_application/components/chat_card.dart';
import 'package:chat_application/components/filled_outline_button.dart';
import 'package:chat_application/constants.dart';
import 'package:chat_application/model/Chat.dart';
import 'package:chat_application/screens/message_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where("email", isEqualTo: _search.text)
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
          content: Text("User not found", style: TextStyle( color: kContentColorLightTheme),),
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
          color: kPrimaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                
                cursorColor: Colors.white,
                controller: _search,
                decoration: InputDecoration(
                  
                  hintText: "Search here...",
                  suffixIcon: IconButton(
                    onPressed: onSearch,
                    icon: Icon(Icons.search),
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
                  leading: Icon(Icons.account_box_outlined, color: Colors.black,),
                  trailing: Icon(Icons.chat, color: Colors.black,),
                  onTap: (){},
                    title: Text(userMap!['email']),
                  ) // Show user email if found
                : Expanded(
                    child: ListView.builder(
                      itemCount: chatsData.length,
                      
                      itemBuilder: (context, index) => ChatCard(
                        chat: chatsData[index],
                        press: () {
                          print("Moving to message screen");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
      ],
    );
  }
}
