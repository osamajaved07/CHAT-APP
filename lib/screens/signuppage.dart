// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_final_fields, unused_field, unused_import, curly_braces_in_flow_control_structures, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:chat_application/controller/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  final formkey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Stack(
        children: [
          SizedBox(
            height: 10,
          ),
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
                'assets/images/signUp.png',
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
              height: MediaQuery.of(context).size.height - 150,
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
                            'SIGN UP',
                            style: GoogleFonts.lora(
                                fontSize: 40, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Create your account below',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                color: Colors.black45),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          namefield(context),
                          SizedBox(
                            height: 20,
                          ),
                          emailfield(),
                          SizedBox(
                            height: 20,
                          ),
                          passwordfield(),
                          SizedBox(
                            height: 32,
                          ),
                          signupbutton(context),
                          SizedBox(
                            height: 20,
                          ),
                          googleloginbutton(context),
                          SizedBox(
                            height: 20,
                          ),
                          login(context)
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

  Row login(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'LogIn',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  OutlinedButton googleloginbutton(BuildContext context) {
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

  SizedBox signupbutton(BuildContext context) {
    return SizedBox(
        height: 48,
        width: MediaQuery.of(context).size.width * .9,
        child: ElevatedButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                AuthService()
                    .createAccountWithEmail(
                        _namecontroller.text, // Pass the name
                        _emailcontroller.text, // Pass the email
                        _passwordcontroller.text)
                    .then((value) {
                  if (value == "Account Created") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Account created successfully..!')));
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
              "SignUp",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )));
  }

  TextFormField passwordfield() {
    return TextFormField(
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

  TextFormField emailfield() {
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

  Container namefield(BuildContext context) {
    return Container(
      width:
          MediaQuery.of(context).size.width * 0.89, // 80% of the screen width
// height: 60, // Fixed height
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: _namecontroller,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name must not be empty';
                } else
                  return null;
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                labelText: 'First Name',
                hintText: 'John',
              ),
            ),
          ),
          SizedBox(width: 8),
          // Flexible(
          //   child: TextFormField(
          //     controller: _namecontroller,
          //     keyboardType: TextInputType.name,
          //     decoration: InputDecoration(
          //       border:
          //           OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          //       labelText: 'LastName',
          //       hintText: 'Doe',
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
