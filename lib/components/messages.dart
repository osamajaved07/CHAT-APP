// ignore_for_file: prefer_const_constructors, dead_code

import "package:chat_application/components/text_messages.dart";
import "package:chat_application/constants.dart";
import "package:chat_application/model/ChatMessage.dart";
import "package:flutter/material.dart";


class Messages extends StatelessWidget {
  const Messages({
    super.key, required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint (ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
        return TextMessage(message: message);
          
          break;
          case ChatMessageType.audio:
        return AudioMessage(message: message,);
          
          break;
        default:
        return SizedBox();
      }

    }
    return Padding(
      padding: const EdgeInsets.only(top:kDefaultPadding),
      child: Row(
        mainAxisAlignment: message.isSender? MainAxisAlignment.end : MainAxisAlignment.start,
      
        children: [
          if(!message.isSender)
          ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/user_2.png"),
            ),
            SizedBox(width: kDefaultPadding / 2,)
          ],
          messageContaint(message),
        ],
      ),
    );
  }
}

class AudioMessage extends StatelessWidget {
  const AudioMessage({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      height: 30,
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor.withOpacity(message.isSender ? 1 : 0.1)
      ),

      child: Row(
        children: [
          Icon(Icons.play_arrow,
          color: message.isSender ?  Colors.white : kPrimaryColor),
          Expanded(child: Container(
            
          ))
        ],
      ),
    );
  }
}