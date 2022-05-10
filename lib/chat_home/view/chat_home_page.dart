import 'package:chat_app/app/bloc/app_bloc.dart';
import 'package:chat_app/chat_new/chat_new.dart';
import 'package:chat_app/services/auth/auth_user.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import '../chat_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeView());

  @override
  Widget build(BuildContext context) {
    final ChatService _chatService = context.read<ChatService>();
    final AuthUser _authUser =
        context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatNewPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'New chat',
      ),
      appBar: AppBar(
        title: const Text('Flutter Chat App'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  context.read<AppBloc>().add(AppLogoutRequested());
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                )
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8.0),
          BlocProvider(
            create: (_) =>
                ChatHomeBloc(chatService: _chatService, user: _authUser),
            child: const ChatHomeContent(),
          )
        ],
      ),
    );
  }
}
