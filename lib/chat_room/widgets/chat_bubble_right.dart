import 'package:flutter/material.dart';
import './widgets.dart';

class ChatBubbleRight extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String time;
  final bool hasMedia;

  const ChatBubbleRight(
      {Key? key,
      required this.hasMedia,
      required this.imageUrl,
      required this.text,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 106, 166, 215),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: text == '' ? 0 : 150,
                    child: text != ''
                        ? Text(
                            text,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          )
                        : null,
                  ),
                  SizedBox(
                    width: imageUrl != '' ? 150 : 0,
                    height: imageUrl != '' ? 150 : 0,
                    child: imageUrl != '' ? Img(imgUrl: imageUrl) : null,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
