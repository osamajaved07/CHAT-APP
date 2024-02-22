// ignore_for_file: prefer_const_constructors, dead_code, unreachable_switch_case, sized_box_for_whitespace, deprecated_member_use, unused_element

import "package:chat_application/components/audio_message.dart";
import "package:chat_application/components/text_messages.dart";
import "package:chat_application/components/video_message.dart";
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

          case ChatMessageType.video:
        return VideoMessage();
          
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
          if (message.isSender ) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({super.key, required this.status});
  
  @override
  Widget build(BuildContext context) {

    Color dotColor (MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
          break;
          case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
          break;
          case MessageStatus.viewed:
          return kPrimaryColor;
          break;
        default:
        return Colors.transparent;
      }
    }
    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
      size: 8,
      color: Theme.of(context).scaffoldBackgroundColor,),
    );
  }
}


