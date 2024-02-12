// ignore_for_file: prefer_const_constructors, camel_case_types, unused_import

import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/firebase_options.dart';
import 'package:chat_application/forgot_password_page.dart';
import 'package:chat_application/homescreen.dart';
import 'package:chat_application/loginpage.dart';
import 'package:chat_application/signuppage.dart';
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
      theme: ThemeData(

        textTheme: GoogleFonts.loraTextTheme(),
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 166, 58)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      routes: {
        "/signup": (context) => signuppage(),
        "/login": (context) => loginpage(),
        "/home": (context) => HomePage(),
        "/": (context) => checkuser(),
        "/forgotpassword": (context) => ForgotPasswordPage(),
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