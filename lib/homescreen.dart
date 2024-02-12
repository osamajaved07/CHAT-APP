// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Welcome to App"),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, "/forgotpassword");
              }, child: Text("data"))
              ],
              
          ),
        ),
      ),
    );
  }
}