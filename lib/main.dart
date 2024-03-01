// ignore_for_file: prefer_const_constructors, camel_case_types, unused_import, use_key_in_widget_constructors

import 'package:chat_application/constants.dart';
import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/firebase_options.dart';


import 'package:chat_application/screens/forgot_password_page.dart';
import 'package:chat_application/screens/homescreen.dart';
import 'package:chat_application/screens/loginpage.dart';
import 'package:chat_application/screens/message_screen.dart';
import 'package:chat_application/screens/signuppage.dart';

import 'package:chat_application/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.light,

      
      
      debugShowCheckedModeBanner: false,

      routes: {
        "/signup": (context) => signuppage(),
        "/login": (context) => loginpage(),
        "/home": (context) => HomePage(),
        "/": (context) => checkuser(),
        "/forgotpassword": (context) => ForgotPasswordPage(),
        "/messagescreen" : (context) => MessagesScreen(),
      },
      
    );
  }
}

class checkuser extends StatefulWidget {
  const checkuser({super.key});

  @override
  State<checkuser> createState() => _checkuserState();
}

class _checkuserState extends State<checkuser> {

  @override
  void initState() {
    AuthService().isLoogedIn().then((value) {
      if(value){
        Navigator.pushReplacementNamed(context, '/home');
      }
      else{
        Navigator.pushReplacementNamed(context, '/login');

      }

    });
    // 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child:CircularProgressIndicator() ,
    );
  }
}

