import 'package:chat_app/chat_room/chat_room.dart';
import 'package:chat_app/services/chat/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chat_new.dart';

class ChatNewContent extends StatelessWidget {
  const ChatNewContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatNewBloc, ChatNewState>(
      listener: (context, state) {
        if (state.status == ChatNewStatus.createdRoom) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ChatRoomPage(
                cr: state.cr!,
                context: context,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ChatNewStatus.loading:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                )
              ],
            );
          case ChatNewStatus.done:
            final users = state.users;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users.elementAt(index);
                  if (user == ChatUser.empty) {
                    return const SizedBox();
                  }
                  return Card(
                    child: ListTile(
                      onTap: () {
                        context
                            .read<ChatNewBloc>()
                            .add(ChatNewCreateChatEvent(user.userId));
                      },
                      title: Text(user.username),
                    ),
                  );
                });
          case ChatNewStatus.createdRoom:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                )
              ],
            );
          case ChatNewStatus.error:
            return const Text('An error has occurred.');
        }
      },
    );
  }
}
