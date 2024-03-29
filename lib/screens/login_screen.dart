// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_final_fields, unused_field, unnecessary_string_escapes, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:chat_application/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final formkey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple[50],
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/login.png',
                width: 250,
                height: 250,
              ),
            ],
          ),
          Positioned(
            top: 250, // Adjust this value based on the image height
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: 600,
              // height: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color.fromARGB(168, 255, 255, 255)),
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 18),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Text(
                            'LOGIN',
                            style: GoogleFonts.lora(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Enter your details below',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                color: Colors.black45),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          emailfield1(),
                          SizedBox(
                            height: 20,
                          ),
                          passwordfield1(),
                          SizedBox(
                            height: 32,
                          ),
                          _loginbutton(context),
                          SizedBox(
                            height: 20,
                          ),
                          googleloginbutton1(context),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlinedButton googleloginbutton1(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          AuthService().continueWithGoogle().then((value) {
            if (value == "Google account login successfull...") {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Google Login Successfully..')));
              Navigator.pushNamed(context, "/home");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red.shade400,
              ));
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/gog.png',
              height: 30,
              width: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Continue with google',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  SizedBox _loginbutton(BuildContext context) {
    return SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width * .9,
        child: ElevatedButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                AuthService()
                    .loginWithEmail(
                        _emailcontroller.text, _passwordcontroller.text)
                    .then((value) {
                  if (value == "Login Successfully") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login Successfully..')));
                    Navigator.pushNamed(context, "/home");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        value,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red.shade400,
                    ));
                  }
                });
              }
            },
            child: Text(
              "Login",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )));
  }

  TextFormField passwordfield1() {
    return TextFormField(
      // validator: (value) => value!.length<8? "Password cannot be less than 8 characters":null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password must not be empty';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        } else {
          return null;
        }
      },
      controller: _passwordcontroller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        label: Text('Password'),
        hintText: 'Enter your Password here',
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible; // Toggle visibility
            });
          },
        ),
      ),
    );
  }

  TextFormField emailfield1() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email must not be empty';
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
      controller: _emailcontroller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          label: Text('Email'),
          hintText: 'Enter your Email here'),
    );
  }
}
