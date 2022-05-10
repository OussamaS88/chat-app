import 'package:chat_app/services/chat/chat_message.dart';
import 'package:chat_app/services/chat/chat_provider.dart';
import 'package:chat_app/services/chat/chat_room.dart';
import 'package:chat_app/services/chat/chat_user.dart';
import 'package:chat_app/services/chat/firestore_chat_provider.dart';
import 'package:chat_app/utilities/cache.dart';

class ChatService implements ChatProvider {
  final ChatProvider provider;
  final CacheClient cacheClient;

  ChatService({required this.provider, required this.cacheClient});

  factory ChatService.fromFirebase({required CacheClient cacheClient}) {
    final firestoreChatProvider = FirestoreChatProvider(cacheClient);
    return ChatService(
        provider: firestoreChatProvider, cacheClient: cacheClient);
  }

  @override
  Future<ChatRoom> addChatRoom(
          {required String recepientId, required String selfId}) =>
      provider.addChatRoom(recepientId: recepientId, selfId: selfId);
  @override
  Stream<Iterable<ChatMessage>> getChatRoomMessages(
          {required String chatRoomId}) =>
      provider.getChatRoomMessages(chatRoomId: chatRoomId);

  @override
  Stream<Iterable<ChatRoom>> getChatRooms({required String userId}) =>
      provider.getChatRooms(userId: userId);
  @override
  Future<ChatMessage> sendMessage({
    required String msgText,
    required String senderId,
    required String chatRoomId,
    required String imagePath,
  }) =>
      provider.sendMessage(
        msgText: msgText,
        senderId: senderId,
        chatRoomId: chatRoomId,
        imagePath: imagePath,
      );

  @override
  Future<ChatUser> getChatUser({required String userId}) =>
      provider.getChatUser(userId: userId);

  @override
  Stream<Iterable<ChatUser>> getAllUsers({required String userId}) =>
      provider.getAllUsers(userId: userId);
}
