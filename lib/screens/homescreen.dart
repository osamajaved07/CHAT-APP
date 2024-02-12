// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field

import 'package:chat_application/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final formkey = GlobalKey<FormState>();
  
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
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
              }, child: Text("data")),

              SizedBox(height: 12,),

              ElevatedButton(onPressed: (){
                  AuthService().logout();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged Out.....")));
                    Navigator.pushReplacementNamed(context, "/login");
                  
                }, child: Text("Logout", style: TextStyle(
                  fontSize: 20
                ),))
              ],
              
          ),
        ),
      ),
    );
  }
}