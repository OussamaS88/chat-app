part of 'chat_home_bloc.dart';

enum ChatHomeStatus { loading, finished, error }

class ChatHomeState extends Equatable {
  final List<ChatRoom> chatRooms;
  final String? errorMessage;
  final ChatHomeStatus status;
  final ChatUser chatUser;

  const ChatHomeState(
      {required this.chatRooms,
      this.errorMessage,
      required this.status,
      required this.chatUser});

  ChatHomeState copyWith({
    List<ChatRoom>? chatRooms,
    String? errorMessage,
    ChatHomeStatus? status,
    ChatUser? chatUser,
  }) {
    return ChatHomeState(
      status: status ?? this.status,
      chatRooms: chatRooms ?? this.chatRooms,
      errorMessage: errorMessage ?? this.errorMessage,
      chatUser: chatUser ?? this.chatUser,
    );
  }

  @override
  List<Object> get props => [chatRooms, status];
}
