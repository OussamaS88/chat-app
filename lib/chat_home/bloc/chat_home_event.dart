part of 'chat_home_bloc.dart';

abstract class ChatHomeEvent extends Equatable {
  const ChatHomeEvent();

  @override
  List<Object> get props => [];
}

class ChatHomeGetAllChatsEvent extends ChatHomeEvent {
  const ChatHomeGetAllChatsEvent();
}

class ChatHomeGetCurrentChatUserEvent extends ChatHomeEvent {
  const ChatHomeGetCurrentChatUserEvent();
}

class ChatHomeGetChatUserEvent extends ChatHomeEvent {
  const ChatHomeGetChatUserEvent();
}
