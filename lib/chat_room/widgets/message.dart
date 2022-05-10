import '../chat_room.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.msgText,
    required this.senderId,
    required this.userId,
    required this.imagePath,
    required this.hasMedia,
  }) : super(key: key);
  final String msgText;
  final String senderId;
  final String userId;
  final String imagePath;
  final bool hasMedia;

  @override
  Widget build(BuildContext context) {
    final bool isSenderSelf = senderId == userId;
    return isSenderSelf
        ? ChatBubbleRight(
            hasMedia: hasMedia,
            imageUrl: imagePath != '' ? imagePath : '',
            text: msgText,
            time: 'senderId')
        : ChatBubbleLeft(
          hasMedia: hasMedia,
            imageUrl: imagePath != '' ? imagePath : '',
            text: msgText,
            time: 'senderId');
  }
}
