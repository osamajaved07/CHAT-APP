// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, must_be_immutable, await_only_futures, empty_catches, unused_local_variable, avoid_print

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTP_Screen extends StatefulWidget {
  String verificationid;
   OTP_Screen({super.key, required this.verificationid});

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.blue.shade400,
        title: Text("OTP verification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 32, right: 12),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Verification Code", style:  TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600
            ),),

            SizedBox(height: 8,),


            Text("We have sent the code verification to"),

            SizedBox(height: 8,),

            Row(
              
              children: [
                Text("+92 331******9"),
                SizedBox(width: 12,),
                Text("Change phone number?", style:  TextStyle(
                  fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.w600
            ),)
        
              ],
            ),

            SizedBox(height: 24,),

            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    controller: otpController,
                    onChanged: (value) {
                      if(value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),

                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    onChanged: (value) {
                      if(value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),

                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                    onChanged: (value) {
                      if(value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),

                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextFormField(
                  
                    decoration: InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)
                      )
                    ),
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),

                SizedBox(height: 30,),
                ElevatedButton(onPressed: () async{
                  try {
                    PhoneAuthCredential credential = await PhoneAuthProvider.credential(
                      verificationId: widget.verificationid, 
                      smsCode: otpController.text.toString());

                      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                        Navigator.pushNamed(context, "/home");
                      });
                  } catch (ex){
                    print(ex.toString());

                  }
                }, child: Text('OTP'))
              ],
            ))
            
          ],
        ),
      ),
    );
  }
}