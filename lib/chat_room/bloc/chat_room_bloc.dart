import 'package:bloc/bloc.dart';
import 'package:chat_app/services/chat/chat_exceptions.dart';
import 'package:chat_app/services/chat/chat_message.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final ChatService _chatService;
  final String _chatRoomId;
  final String _chatUserId;
  ChatRoomBloc(
      {required ChatService chatService,
      required String chatRoomId,
      required String chatUserId})
      : _chatService = chatService,
        _chatRoomId = chatRoomId,
        _chatUserId = chatUserId,
        super(const ChatRoomState(
          messages: [],
          status: ChatRoomStatus.loading,
          hasImage: false,
        )) {
    on<ChatRoomGetMessagesEvent>(_chatRoomGetMessagesEvent);
    on<ChatRoomSendMessageEvent>(_chatRoomSendMessageEvent);
    on<ChatRoomAddedImageEvent>(_chatRoomAddedImageEvent);
    add(const ChatRoomGetMessagesEvent());
  }

  void _chatRoomGetMessagesEvent(
      ChatRoomGetMessagesEvent event, Emitter<ChatRoomState> emit) async {
    emit(state.copyWith(status: ChatRoomStatus.loading));
    if (_chatRoomId == '') {
      emit(state.copyWith(
          status: ChatRoomStatus.error, errorMessage: 'Invalid chat ID'));
      return;
    }
    try {
      await emit
          .forEach(_chatService.getChatRoomMessages(chatRoomId: _chatRoomId),
              onData: (data) {
        return (state.copyWith(
          status: ChatRoomStatus.done,
          messages: List.from(data as Iterable),
        ));
      });
    } on CouldNotGetMessageException catch (e) {
      emit(state.copyWith(
          status: ChatRoomStatus.error, errorMessage: e.message));
    } on Exception catch (_) {
      emit(state.copyWith(
          status: ChatRoomStatus.error,
          errorMessage: "Unknown error occurred."));
    }

    emit(state.copyWith(status: ChatRoomStatus.done));
  }

  void _chatRoomSendMessageEvent(
      ChatRoomSendMessageEvent event, Emitter<ChatRoomState> emit) async {
    try {
      await _chatService.sendMessage(
          msgText: event.msgText,
          senderId: _chatUserId,
          chatRoomId: _chatRoomId,
          imagePath: event.imagePath);
    } on CouldNotSendMessageException catch (e) {
      emit(state.copyWith(
          status: ChatRoomStatus.error, errorMessage: e.message));
    } on Exception catch (_) {
      emit(state.copyWith(
          status: ChatRoomStatus.error,
          errorMessage: "Unknown error occurred."));
    }
  }

  void _chatRoomAddedImageEvent(
      ChatRoomAddedImageEvent event, Emitter<ChatRoomState> emit) {
    if (event.image != null) {
      emit(state.copyWith(hasImage: true, image: event.image));
    } else {
      emit(state.copyWith(hasImage: false));
    }
  }
}
