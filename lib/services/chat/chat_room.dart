import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String chatRoomId;
  final List<String> userIDs;
  final List<Map<String, dynamic>> users;

  ChatRoom({
    required this.chatRoomId,
    required this.users,
    required this.userIDs,
  });
  ChatRoom.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : chatRoomId = snapshot.id,
        users = List<Map<String, dynamic>>.from(snapshot.data()['users']),
        userIDs = List<String>.from(
          snapshot.data()['user_ids'],
        );
  ChatRoom.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : chatRoomId = snapshot.id,
        users = List<Map<String, dynamic>>.from(snapshot.data()!['users']),
        userIDs = List<String>.from(
          snapshot.data()!['user_ids'],
        );
}
