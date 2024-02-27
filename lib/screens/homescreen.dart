// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, unused_import, non_constant_identifier_names, sized_box_for_whitespace, await_only_futures, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:chat_application/components/body.dart';
import 'package:chat_application/constants.dart';
import 'package:chat_application/controller/auth_controller.dart';
import 'package:chat_application/model/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, dynamic> userMap;
  bool isLoading = false;

  int _selectedIndex = 1;

  final formkey = GlobalKey<FormState>();
  final TextEditingController _search = TextEditingController();
  
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  void onSearch () async {

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _firestore.collection('users').where("email", isEqualTo: _search.text)
    .get().then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);

    });
    

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: App_Bar(),

      body: isLoading? Center(
        child: Container(
          height: size.height / 20,
          width: size.width / 20,
          child: CircularProgressIndicator(),
          
        ),
      ) : Body(),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: kPrimaryColor,
        onPressed: (){},
        child: Icon(Icons.person_add_alt_1, color: Colors.white,),),

        bottomNavigationBar: Bottomnavigationbar(),
    );
  }

  BottomNavigationBar Bottomnavigationbar() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,

        onTap: (value){
          setState(() {
            _selectedIndex = value;
          });

        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger),
        label: "chats"
        ),

        BottomNavigationBarItem(icon: Icon(Icons.people),
        label: "People"
        ),

        BottomNavigationBarItem(icon: Icon(Icons.call),
        label: "Calls"
        ),

        BottomNavigationBarItem(icon: CircleAvatar(
          radius: 14,
          backgroundImage: AssetImage("assets/images/user_2.png"),),
        label: "Profile")
      ],);
  }

  AppBar App_Bar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        Row(
          children: [
            IconButton.outlined(onPressed: (){
              AuthService().logout();
              Navigator.pushReplacementNamed(context, "/login");
            }, icon: Icon(Icons.logout)),
          ],
        )
      ],
    );
  }
}