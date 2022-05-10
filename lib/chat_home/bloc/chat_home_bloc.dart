import 'package:bloc/bloc.dart';
import 'package:chat_app/services/auth/auth_user.dart';
import 'package:chat_app/services/chat/chat_room.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/services/chat/chat_user.dart';
import 'package:equatable/equatable.dart';

part 'chat_home_event.dart';
part 'chat_home_state.dart';

class ChatHomeBloc extends Bloc<ChatHomeEvent, ChatHomeState> {
  final ChatService _chatService;
  final AuthUser _authUser;
  ChatHomeBloc({required ChatService chatService, required AuthUser user})
      : _chatService = chatService,
        _authUser = user,
        super(const ChatHomeState(
            chatRooms: [],
            status: ChatHomeStatus.loading,
            chatUser: ChatUser.empty)) {
    on<ChatHomeGetAllChatsEvent>(_chatHomeGetAllEvent);
    on<ChatHomeGetCurrentChatUserEvent>(_chatHomeGetCurrentChatUserEvent);
    add(const ChatHomeGetCurrentChatUserEvent());
  }

  void _chatHomeGetAllEvent(
      ChatHomeGetAllChatsEvent event, Emitter<ChatHomeState> emit) async {
    // print('loading......');
    emit(state.copyWith(status: ChatHomeStatus.loading));
    if (state.chatUser == ChatUser.empty) {
      emit(state.copyWith(status: ChatHomeStatus.error));
      return;
    }
    await emit.forEach(_chatService.getChatRooms(userId: _authUser.id),
        onData: (data) {
      // print(data);
      return (state.copyWith(
          status: ChatHomeStatus.finished,
          chatRooms: List.from(data as Iterable)));
    });
    // print('done');
    emit(state.copyWith(status: ChatHomeStatus.finished));
  }

  void _chatHomeGetCurrentChatUserEvent(ChatHomeGetCurrentChatUserEvent event,
      Emitter<ChatHomeState> emit) async {
    final ChatUser chatUser =
        await _chatService.getChatUser(userId: _authUser.id);
    // print(chatUser.userId);
    emit(state.copyWith(chatUser: chatUser));
    add(const ChatHomeGetAllChatsEvent());
  }
}
