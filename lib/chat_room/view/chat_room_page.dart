import 'package:chat_app/app/bloc/app_bloc.dart';
import 'package:chat_app/chat_room/bloc/chat_room_bloc.dart';
import 'package:chat_app/chat_room/view/chat_room_content.dart';
import 'package:chat_app/services/chat/chat_room.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({
    Key? key,
    required this.cr,
    required this.context,
  }) : super(key: key);
  final ChatRoom cr;
  final BuildContext context;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  // late final TextEditingController _textController;

  // @override
  // void initState() {
  //   super.initState();
  //   _textController = TextEditingController();
  // }

  @override
  Widget build(BuildContext context) {
    final ChatService _chatService = context.read<ChatService>();
    final String _userId = context.select((AppBloc bloc) => bloc.state.user.id);
    final String otherUserId = widget.cr.users.first['user_id'] == _userId
        ? widget.cr.users.last['username']
        : widget.cr.users.first['username'];
    return Scaffold(
      appBar: AppBar(
        title: Text(otherUserId),
      ),
      body: BlocProvider(
        create: (context) => ChatRoomBloc(
          chatRoomId: widget.cr.chatRoomId,
          chatService: _chatService,
          chatUserId: _userId,
        ),
        child: const ChatRoomContent(),
        // child: Stack(
        //   children: [
        //     // Align(child: Text(cr.chatRoomId)),
        //     const Align(
        //       // child: BlocProvider(
        //       //   create: (_) => ChatRoomBloc(
        //       //     chatRoomId: widget.cr.chatRoomId,
        //       //     chatService: _chatService,
        //       //     chatUserId: _userId,
        //       //   ),
        //       //   child: const ChatRoomContent(),
        //       // ),
        //       child: ChatRoomContent()
        //     ),
        //     Positioned(
        //       bottom: 0,
        //       child: Container(
        //         // alignment: Alignment.bottomCenter,
        //         width: MediaQuery.of(context).size.width * 1,
        //         height: MediaQuery.of(context).size.height * 0.1,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(0),
        //           color: Colors.black54,
        //         ),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Container(
        //                 //margin: EdgeInsets.only(left: 10),
        //                 alignment: Alignment.centerLeft,
        //                 width: MediaQuery.of(context).size.width * 0.8,
        //                 height: 50,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10),
        //                   color: Colors.grey[850],
        //                 ),
        //                 child: Row(children: [
        //                   IconButton(
        //                     onPressed: () {},
        //                     icon: const Icon(Icons.attach_file_rounded),
        //                     color: Colors.grey,
        //                   ),
        //                   // const Text(
        //                   //   "Your Messages",
        //                   //   style: TextStyle(
        //                   //       color: Colors.grey,
        //                   //       fontFamily: "RobotoMedium",
        //                   //       fontSize: 17),
        //                   // ),
        //                   SizedBox(
        //                     width: MediaQuery.of(context).size.width * 0.6,
        //                     child: TextField(
        //                       keyboardType: TextInputType.multiline,
        //                       maxLines: null,
        //                       controller: _textController,
        //                       autofocus: true,
        //                       style: const TextStyle(color: Colors.white),
        //                       decoration: const InputDecoration(
        //                           hintText: 'Type your message....',
        //                           hintStyle: TextStyle(color: Colors.grey)),
        //                     ),
        //                   ),
        //                 ])),
        //             IconButton(
        //               onPressed: () {
        //                 context.read<ChatRoomBloc>().add(
        //                     ChatRoomSendMessageEvent(
        //                         msgText: _textController.text));
        //                 _textController.text = '';
        //               },
        //               icon: const Icon(
        //                 Icons.send,
        //                 size: 35,
        //               ),
        //               color: Colors.indigoAccent.shade700,
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
