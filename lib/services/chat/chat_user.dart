import 'package:chat_app/services/auth/auth_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatUser extends Equatable {
  final String userId;
  final String username;

  const ChatUser({required this.userId, required this.username});

  static const empty = ChatUser(userId: '', username: '');

  factory ChatUser.fromAuthUser(
          {required AuthUser authUser, required String username}) =>
      ChatUser(
        userId: authUser.id,
        username: username,
      );
  factory ChatUser.fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      ChatUser(
        userId: snapshot.id,
        username: snapshot.data()['username'],
      );

  @override
  List<Object?> get props => [userId, username];
}
