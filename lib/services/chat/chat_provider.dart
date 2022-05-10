import 'package:chat_app/services/chat/chat_message.dart';
import 'package:chat_app/services/chat/chat_room.dart';
import 'package:chat_app/services/chat/chat_user.dart';

abstract class ChatProvider {
  Future<ChatUser> getChatUser({required String userId});

  Stream<Iterable<ChatRoom>> getChatRooms({required String userId});

  Future<ChatRoom> addChatRoom(
      {required String recepientId, required String selfId});

  Future<ChatMessage> sendMessage(
      {required String msgText,
      required String senderId,
      required String chatRoomId,
      required String imagePath});

  Stream<Iterable<ChatMessage>> getChatRoomMessages(
      {required String chatRoomId});
  Stream<Iterable<ChatUser>> getAllUsers({required String userId});
}
