// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_application/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
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
                backgroundColor: Colors.deepPurple[100],
                maxRadius: 36,
                child: Text(
                  FirebaseAuth.instance.currentUser!.displayName
                      .toString()
                      .toUpperCase(),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            SizedBox(
              height: 18,
            ),
            if (FirebaseAuth.instance.currentUser != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "UserName:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 8,
            ),
            if (FirebaseAuth.instance.currentUser != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Email:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ), // Check and use only if currentUser is not null
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 3,
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
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/GroupChatHomeScreen");
            },
            icon: Icon(Icons.group),
            iconSize: 30,
          ),
          Icon(Icons.phone, size: 30),
          CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
        ],
      ),
    );
  }
}
