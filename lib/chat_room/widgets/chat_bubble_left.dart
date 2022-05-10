import 'package:flutter/material.dart';
import './widgets.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:open_file/open_file.dart';

class ChatBubbleLeft extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String time;
  final bool hasMedia;

  const ChatBubbleLeft(
      {Key? key,
      required this.hasMedia,
      required this.imageUrl,
      required this.text,
      required this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> openFile() async {
      var filePath = r'/storage/emulated/0/update.apk';
      final _result = await OpenFile.open(filePath);
      print(_result.message);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            width: 12,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffEAEFF3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
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
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
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
