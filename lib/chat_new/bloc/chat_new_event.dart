part of 'chat_new_bloc.dart';

abstract class ChatNewEvent extends Equatable {
  const ChatNewEvent();

  @override
  List<Object> get props => [];
}

class ChatNewCreateChatEvent extends ChatNewEvent {
  final String recipientId;

  const ChatNewCreateChatEvent(this.recipientId);
}

class ChatNewFetchUsersEvent extends ChatNewEvent {
  const ChatNewFetchUsersEvent();
}
