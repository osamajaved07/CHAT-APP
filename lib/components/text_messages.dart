// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:chat_application/constants.dart';
import 'package:chat_application/model/ChatMessage.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key, required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
    
      
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2
      ),
    
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(message.isSender? 1 : 0.08),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Text(message.text, style: TextStyle(
        color: message.isSender? 
        Colors.white : Theme.of(context)
        .textTheme
        .bodyText1?.color,
      ),));
  }
}

