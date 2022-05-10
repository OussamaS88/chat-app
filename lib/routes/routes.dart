import 'package:chat_app/app/bloc/app_bloc.dart';
import 'package:chat_app/chat_home/view/chat_home_page.dart';
import 'package:chat_app/login/login.dart';
import 'package:flutter/widgets.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeView.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}

const chatRoomRoute = '/chatRoom/';
