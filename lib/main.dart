import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/auth/auth_user.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/utilities/cache.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final _authService = AuthService.fromFirebase();
  final _cacheClient = CacheClient();
  _cacheClient.write(key: 'cache_user_id', value: AuthUser.empty);
  final _chatService = ChatService.fromFirebase(cacheClient: _cacheClient);
  runApp(App(
    authService: _authService,
    cacheClient: _cacheClient,
    chatService: _chatService,
  ));
}
