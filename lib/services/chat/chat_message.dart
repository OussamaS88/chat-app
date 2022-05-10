import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String msgText;
  final String senderId;
  final String? imageUrl;
  final bool hasMedia;

  const ChatMessage(
      {required this.msgText,
      required this.senderId,
      this.imageUrl,
      required this.hasMedia});

  static const empty = ChatMessage(msgText: '', senderId: '', hasMedia: false);

  factory ChatMessage.fromSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      ChatMessage(
          msgText: snapshot.data()!['msg_text'],
          senderId: snapshot.data()!['sender_id'],
          imageUrl: snapshot.data()!['image_url'],
          hasMedia: snapshot.data()!['has_media'] as bool);
  @override
  List<Object?> get props => [msgText, senderId, hasMedia];
}
