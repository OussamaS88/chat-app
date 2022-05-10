import 'package:chat_app/app/bloc/app_bloc.dart';
import 'package:chat_app/chat_room/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chat_home.dart';

class ChatHomeContent extends StatelessWidget {
  const ChatHomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _userId = context.select((AppBloc bloc) => bloc.state.user.id);
    return BlocBuilder<ChatHomeBloc, ChatHomeState>(
      builder: (context, state) {
        switch (state.status) {
          case ChatHomeStatus.error:
            return const Text('error');
          case ChatHomeStatus.loading:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                )
              ],
            );
          case ChatHomeStatus.finished:
            final chatRooms = state.chatRooms;
            return Expanded(
                child: ListView.builder(
                    itemCount: state.chatRooms.length,
                    itemBuilder: (context, index) {
                      final room = chatRooms.elementAt(index);
                      return Card(
                        child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoomPage(
                                    cr: room,
                                    context: context,
                                  ),
                                ),
                              );
                            },
                            title: Text(room.users.first['user_id'] == _userId
                                ? room.users.last['username']
                                : room.users.first['username'])),
                      );
                    }));
          default:
            return const Text('unknown');
        }
      },
    );
  }
}
