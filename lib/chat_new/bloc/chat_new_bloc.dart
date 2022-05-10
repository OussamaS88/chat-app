import 'package:bloc/bloc.dart';
import 'package:chat_app/services/chat/chat_exceptions.dart';
import 'package:chat_app/services/chat/chat_room.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/services/chat/chat_user.dart';
import 'package:equatable/equatable.dart';

part 'chat_new_event.dart';
part 'chat_new_state.dart';

class ChatNewBloc extends Bloc<ChatNewEvent, ChatNewState> {
  final ChatService _chatService;
  final String _userId;
  ChatNewBloc({required ChatService chatService, required String userId})
      : _chatService = chatService,
        _userId = userId,
        super(const ChatNewState(users: [], status: ChatNewStatus.loading)) {
    on<ChatNewCreateChatEvent>(_chatNewCreateChatEvent);
    on<ChatNewFetchUsersEvent>(_chatNewFetchUsersEvent);
    add(const ChatNewFetchUsersEvent());
  }

  void _chatNewCreateChatEvent(
      ChatNewCreateChatEvent event, Emitter<ChatNewState> emit) async {
    try {
      final ChatRoom cr = await _chatService.addChatRoom(
          recepientId: event.recipientId, selfId: _userId);
      emit(state.copyWith(status: ChatNewStatus.createdRoom, cr: cr));
    } on CouldNotCreateChatException catch (e) {
      emit(
          state.copyWith(status: ChatNewStatus.error, errorMessage: e.message));
    } on Exception catch (_) {
      emit(state.copyWith(
          status: ChatNewStatus.error,
          errorMessage: "Unknown error occurred."));
    }
  }

  void _chatNewFetchUsersEvent(
      ChatNewFetchUsersEvent event, Emitter<ChatNewState> emit) async {
    try {
      await emit.forEach(_chatService.getAllUsers(userId: _userId),
          onData: (data) {
        return (state.copyWith(
            status: ChatNewStatus.done, users: List.from(data as Iterable)));
      });
    } on CouldNotGetUserException catch (e) {
      emit(
          state.copyWith(status: ChatNewStatus.error, errorMessage: e.message));
    } on Exception catch (_) {
      emit(state.copyWith(
          status: ChatNewStatus.error,
          errorMessage: "Unknown error occurred."));
    }
  }
}
