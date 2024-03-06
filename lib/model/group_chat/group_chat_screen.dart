// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:chat_application/constants.dart';

import 'package:chat_application/model/group_chat/create_group/add_members.dart';
import 'package:chat_application/model/group_chat/group_chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  List membersList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  List groupList = [];

  @override
  void initState() {
    super.initState();
    getAvailableGroups();
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Text("Groups"),
        ),
        body: isLoading
            ? Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: groupList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GroupChatRoom(
                          groupName: groupList[index]['name'],
                          groupChatId: groupList[index]['id'],
                        ),
                      ),
                    ),
                    leading: Icon(Icons.group),
                    title: Text(groupList[index]['name']),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddMembersInGroup(
                  // groupChatId: widget.groupId,
                  // name: widget.groupName,
                  // membersList: membersList,
                  ),
            ),
          ),
          tooltip: "Create Group",
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.white, // Background color
          color: kPrimaryColor, // Button color
          buttonBackgroundColor: kPrimaryColor,

          // Active button color
          height: 50,
          items: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
              },
              icon: Icon(Icons.messenger),
              iconSize: 30,
            ),
            Icon(Icons.group, size: 30),
            Icon(Icons.call, size: 30),
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/ProfileScreen");
              },
              icon: CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage("assets/images/user_2.png"),
              ),
              iconSize: 30,
            ),
          ],
          onTap: (index) {
            setState(() {});

            // Handle navigation based on index
          },
        ));
  }
}
