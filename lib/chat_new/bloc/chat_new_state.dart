part of 'chat_new_bloc.dart';

enum ChatNewStatus { loading, done, createdRoom, error }

class ChatNewState extends Equatable {
  final List<ChatUser> users;
  final String? errorMessage;
  final ChatNewStatus status;
  final ChatRoom? cr;
  const ChatNewState(
      {required this.users, this.errorMessage, required this.status, this.cr});

  ChatNewState copyWith({
    List<ChatUser>? users,
    String? errorMessage,
    ChatNewStatus? status,
    ChatRoom? cr,
  }) {
    return ChatNewState(
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      cr: cr ?? this.cr,
    );
  }

  @override
  List<Object> get props => [users, status];
}
