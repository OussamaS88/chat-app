part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();

  @override
  List<Object> get props => [];
}

class ChatRoomGetMessagesEvent extends ChatRoomEvent {
  const ChatRoomGetMessagesEvent();
}

class ChatRoomSendMessageEvent extends ChatRoomEvent {
  final String msgText;
  final String imagePath;
  const ChatRoomSendMessageEvent(
      {required this.msgText, required this.imagePath});
}

class ChatRoomAddedImageEvent extends ChatRoomEvent {
  final XFile? image;
  const ChatRoomAddedImageEvent({required this.image});
}
