part of 'chat_room_bloc.dart';

enum ChatRoomStatus {
  loading,
  done,
  error,
}

class ChatRoomState extends Equatable {
  final List<ChatMessage> messages;
  final String? errorMessage;
  final ChatRoomStatus status;
  final bool hasImage;
  final XFile? image;
  // final String chatRoomId;

  const ChatRoomState(
      {required this.messages,
      this.errorMessage,
      required this.status,
      required this.hasImage,
      this.image
      // required this.chatRoomId,
      });

  ChatRoomState copyWith({
    List<ChatMessage>? messages,
    String? errorMessage,
    ChatRoomStatus? status,
    String? chatRoomId,
    bool? hasImage,
    XFile? image,
  }) {
    return ChatRoomState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      hasImage: hasImage ?? this.hasImage,
      image: image ?? this.image,

      // chatRoomId: chatRoomId ?? this.chatRoomId,
    );
  }

  @override
  List<Object> get props => [
        messages,
        status,
        hasImage
        // chatRoomId,
      ];
}
