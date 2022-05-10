import 'package:chat_app/app/bloc/app_bloc.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chat_new.dart';

class ChatNewPage extends StatelessWidget {
  const ChatNewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatService _chatService = context.read<ChatService>();

    final String _userId = context.select((AppBloc bloc) => bloc.state.user.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Chat'),
      ),
      body: BlocProvider(
        create: (_) => ChatNewBloc(chatService: _chatService, userId: _userId),
        child: const ChatNewContent(),
      ),
    );
  }
}
