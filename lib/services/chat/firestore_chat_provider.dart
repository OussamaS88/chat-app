import 'dart:io';

import 'package:chat_app/services/auth/auth_user.dart';
import 'package:chat_app/services/chat/chat_exceptions.dart';
import 'package:chat_app/services/chat/chat_message.dart';
import 'package:chat_app/services/chat/chat_provider.dart';
import 'package:chat_app/services/chat/chat_room.dart';
import 'package:chat_app/services/chat/chat_user.dart';
import 'package:chat_app/utilities/cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirestoreChatProvider implements ChatProvider {
  var uuid = const Uuid();
  final CacheClient _cacheClient;
  late final AuthUser user;
  final chatRooms = FirebaseFirestore.instance.collection('ChatRoom');
  final users = FirebaseFirestore.instance.collection('user');

  final storageRef = FirebaseStorage.instance.ref();

  FirestoreChatProvider(this._cacheClient) {
    final cacheUser = _cacheClient.read(key: 'cache_user_id');
    if (cacheUser == null || cacheUser == '') {
      user = AuthUser.empty;
    }
    user = _cacheClient.read(key: 'cache_user_id') as AuthUser;
  }

  @override
  Future<ChatRoom> addChatRoom(
      {required String recepientId, required String selfId}) async {
    final ChatUser recipient = await getChatUser(userId: recepientId);
    final ChatUser self = await getChatUser(userId: selfId);
    final ref = chatRooms.doc(selfId + recepientId);
    final otherRef = chatRooms.doc(recepientId + selfId);
    final refResult = await ref.get();
    if (refResult.exists) {
      final cr = ChatRoom.fromDocumentSnapshot(refResult);
      return cr;
    }
    final otherRefResult = await otherRef.get();
    if (otherRefResult.exists) {
      final cr = ChatRoom.fromDocumentSnapshot(otherRefResult);
      return cr;
    }
    await ref.set({
      'user_ids': [recepientId, selfId],
      'users': [
        {'user_id': recepientId, 'username': recipient.username},
        {'user_id': selfId, 'username': self.username},
      ]
    }).onError((error, stackTrace) =>
        throw CouldNotCreateChatException.fromCode(error.toString()));
    final returnDoc = await ref.get();
    final cr = ChatRoom.fromDocumentSnapshot(returnDoc);
    return cr;
  }

  @override
  Stream<Iterable<ChatMessage>> getChatRoomMessages(
      {required String chatRoomId}) {
    final msgRef = chatRooms.doc(chatRoomId).collection('messages');
    final allMessages = msgRef
        .orderBy('date_sent')
        .snapshots()
        .map((event) => event.docs.map((doc) {
              return ChatMessage.fromSnapshot(doc);
            }))
        .handleError((error) {
      throw CouldNotGetMessageException.fromCode(error.toString());
    });
    return allMessages;
  }

  @override
  Stream<Iterable<ChatRoom>> getChatRooms({required String userId}) {
    final allChatRooms = chatRooms
        .where('user_ids', arrayContains: userId)
        .snapshots()
        .map((event) => event.docs.map((doc) {
              final chatRoom = ChatRoom.fromSnapshot(doc);
              return chatRoom;
            }))
        .handleError((error) {
      throw CouldNotGetChatException.fromCode(error.toString());
    });
    return allChatRooms;
  }

  @override
  Future<ChatUser> getChatUser({required String userId}) async {
    final doc = await users.doc(userId).get().onError((error, stackTrace) =>
        throw CouldNotGetUserException.fromCode(error.toString()));
    if (doc.data() == null) return ChatUser.empty;
    final ChatUser user =
        ChatUser(userId: userId, username: doc.data()?['username']);
    return user;
  }

  @override
  Future<ChatMessage> sendMessage({
    required String msgText,
    required String senderId,
    required String chatRoomId,
    required String imagePath,
  }) async {
    final msgRef = chatRooms.doc(chatRoomId).collection('messages');
    final dt = FieldValue.serverTimestamp();
    if (imagePath != '') {
      final chatRoomStorage = storageRef.child('chat_room');
      final thisRoomRef = chatRoomStorage.child(chatRoomId);
      final thisMessageRef = thisRoomRef.child(uuid.v4());
      File file = File(imagePath);
      try {
        final upload = await thisMessageRef.putFile(file);
        final document = await msgRef.add({
          'msg_text': msgText,
          'sender_id': senderId,
          'has_media': true,
          'image_url': await upload.ref.getDownloadURL(),
          'date_sent': dt,
        });
        final returnDoc = await document.get();
        return ChatMessage.fromSnapshot(returnDoc);
      } on FirebaseException catch (e) {
        throw CouldNotSendMessageException.fromCode(e.code);
      } on Exception catch (_) {
        throw const CouldNotSendMessageException();
      }
    } else {
      final document = await msgRef.add({
        'msg_text': msgText,
        'sender_id': senderId,
        'has_media': false,
        'date_sent': dt,
      }).onError((error, stackTrace) =>
          throw CouldNotSendMessageException(error.toString()));
      final returnDoc = await document.get();
      return ChatMessage.fromSnapshot(returnDoc);
    }
  }

  @override
  Stream<Iterable<ChatUser>> getAllUsers({required String userId}) {
    final allUsers = users
        .snapshots()
        .map((event) => event.docs.map((doc) {
              if (doc.id == userId) {
                return ChatUser.empty;
              }
              return ChatUser.fromSnapshot(doc);
            }))
        .handleError((error) {
      throw CouldNotGetUserException.fromCode(error.toString());
    });
    return allUsers;
  }
}
