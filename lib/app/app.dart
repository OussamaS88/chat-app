import 'package:chat_app/app/bloc/app_bloc.dart';
import 'package:chat_app/routes/routes.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/utilities/cache.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AuthService _authService;
  final CacheClient _cacheClient;
  final ChatService _chatService;
  const App({
    Key? key,
    required AuthService authService,
    required CacheClient cacheClient,
    required ChatService chatService,
  })  : _authService = authService,
        _cacheClient = cacheClient,
        _chatService = chatService,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authService),
        RepositoryProvider.value(value: _cacheClient),
        RepositoryProvider.value(value: _chatService)
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authService: _authService,
          cacheClient: _cacheClient,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat app',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
