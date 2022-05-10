import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);
  
  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
          create: (_) => LoginBloc(context.read<AuthService>()),
          child: const LoginForm(),
        ),
    );
  }
}