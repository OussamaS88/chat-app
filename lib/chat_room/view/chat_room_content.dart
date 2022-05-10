import 'package:chat_app/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../chat_room.dart';

class ChatRoomContent extends StatefulWidget {
  const ChatRoomContent({Key? key}) : super(key: key);

  @override
  State<ChatRoomContent> createState() => _ChatRoomContentState();
}

class _ChatRoomContentState extends State<ChatRoomContent> {
  late final TextEditingController _textController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    final String _userId = context.select((AppBloc bloc) => bloc.state.user.id);
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(builder: (context, state) {
      switch (state.status) {
        case ChatRoomStatus.loading:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [CircularProgressIndicator()],
              )
            ],
          );
        case ChatRoomStatus.error:
          return const Text('Error.');
        case ChatRoomStatus.done:
          final messages = state.messages;
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          });
          return Stack(children: [
            Positioned(
              top: 0,
              bottom: MediaQuery.of(context).size.height * 0.13,
              right: 0,
              left: 0,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages.elementAt(index);
                  return Message(
                    hasMedia: message.hasMedia,
                    msgText: message.msgText,
                    senderId: message.senderId,
                    userId: _userId,
                    imagePath: message.imageUrl ?? '',
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                // alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.black54,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        //margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[850],
                        ),
                        child: Row(children: [
                          IconButton(
                            onPressed: () async {
                              final image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                context
                                    .read<ChatRoomBloc>()
                                    .add(ChatRoomAddedImageEvent(image: image));
                              } else {
                                context.read<ChatRoomBloc>().add(
                                    const ChatRoomAddedImageEvent(image: null));
                              }
                            },
                            icon: const Icon(Icons.attach_file_rounded),
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextField(
                              onTap: () {
                                SchedulerBinding.instance
                                    ?.addPostFrameCallback((_) {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                });
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: _textController,
                              autofocus: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: 'Type your message....',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ])),
                    IconButton(
                      onPressed: () {
                        if (state.hasImage) {
                          context.read<ChatRoomBloc>().add(
                              ChatRoomSendMessageEvent(
                                  msgText: _textController.text,
                                  imagePath: state.image!.path));
                          _textController.text = '';
                          context
                              .read<ChatRoomBloc>()
                              .add(const ChatRoomAddedImageEvent(image: null));
                        } else {
                          if (_textController.text == '') {
                            return;
                          }
                          context.read<ChatRoomBloc>().add(
                              ChatRoomSendMessageEvent(
                                  msgText: _textController.text,
                                  imagePath: ''));
                          _textController.text = '';
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 35,
                      ),
                      color: Colors.indigoAccent.shade700,
                    )
                  ],
                ),
              ),
            ),
          ]);
      }
    });
  }
}
