// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last, avoid_types_as_parameter_names, unused_local_variable, unused_import

import 'package:chat_application/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({super.key});

  @override
  State<GroupChatHomeScreen> createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  @override

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Groups"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, Index){
        return ListTile(
          onTap: (){
            Navigator.pushNamed(context, "/GroupChatRoom");
          },
          leading: Icon(Icons.group),
          title: Text("Group $Index"),
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){},
      child: Icon(Icons.create),
      tooltip: "Create Group",),
      );
  }
}