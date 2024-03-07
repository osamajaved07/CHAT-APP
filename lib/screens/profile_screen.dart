// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_print, use_build_context_synchronously, must_be_immutable, non_constant_identifier_names, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:chat_application/constants.dart';
import 'package:chat_application/model/group_chat/group_chat_screen.dart';
import 'package:chat_application/screens/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _username = FirebaseAuth.instance.currentUser?.displayName ?? '';
    _email = FirebaseAuth.instance.currentUser?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade400,
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 30,
            ),
            if (FirebaseAuth.instance.currentUser !=
                null) // Check if currentUser is not null
              CircleAvatar(
                backgroundColor: Colors.blue[200],
                maxRadius: 36,
                child: Text(
                  _username.isNotEmpty
                      ? _username.toString().toUpperCase()
                      : '',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            SizedBox(
              height: 18,
            ),
            if (FirebaseAuth.instance.currentUser != null)
              Text(
                "UserName: $_username",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            SizedBox(
              height: 8,
            ),
            if (FirebaseAuth.instance.currentUser != null)
              Text(
                "Email: $_email",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            SizedBox(height: 60),
            if (FirebaseAuth.instance.currentUser != null)
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String Name =
                            FirebaseAuth.instance.currentUser!.displayName ??
                                '';

                        return AlertDialog(
                          title: Text("Update Profile"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Here you can update your profile"),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                initialValue: Name,
                                onChanged: (value) {
                                  Name = value;
                                },
                                decoration:
                                    InputDecoration(labelText: "Username"),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close")),
                            TextButton(
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user != null) {
                                    try {
                                      await user.updateDisplayName(Name);

                                      setState(() {
                                        _username = Name;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Profile updated successfully!'),
                                        ),
                                      );
                                    } catch (e) {
                                      print('Error updating profile: $e');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Error updating profile: $e'),
                                        ),
                                      );
                                      // Handle error
                                    }
                                  }
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .update({
                                    'name': Name,
                                  });

                                  Navigator.of(context).pop();
                                },
                                child: Text("Update"))
                          ],
                        );
                      });
                },
                child: Text('Update Profile'),
              ), // Check and use only if currentUser is not null
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        backgroundColor: Colors.white, // Background color
        color: Colors.blue.shade400, // Button color
        buttonBackgroundColor: kPrimaryColor,
        // Active button color
        height: 50,
        items: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (_, __, ___) => HomePage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: Icon(Icons.messenger),
            iconSize: 30,
          ),
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
          // Icon(Icons.phone, size: 30),
          CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
        ],
      ),
    );
  }
}
